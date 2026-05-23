#!/usr/bin/env bash
# aggregate-trial-scores.sh
#
# Usage: bash aggregate-trial-scores.sh <iteration-dir> [<trial-count>]
#
# Reads scoring.md files written by the corpus-scorer subagent and produces
# aggregate.md with a side-by-side baseline-vs-compressed comparison and a
# decision verdict (SHIP | ITERATE | ESCALATE_TRIALS).
#
# Expected directory layout under <iteration-dir>:
#
#   <iteration-dir>/
#     baseline/
#       trial-N/
#         <fixture-name>/scoring.md
#     compressed/
#       trial-N/
#         <fixture-name>/scoring.md
#
# Each scoring.md must end with a Summary table of the form:
#
#   ## Summary
#   | Caught | Partial | Missed |
#   |--------|---------|--------|
#   | X/N    | Y/N     | Z/N    |
#
# The script extracts the X, Y, Z, N integers from each scoring.md, tallies
# them across fixtures and trials per condition, and writes
# <iteration-dir>/aggregate.md.
#
# Partial verdicts count as 0.5 caught for aggregate purposes (matching the
# convention used in the pm-writing-standards manual run).
#
# Exits 0 on success, 1 on bad arguments or unparseable input.

set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <iteration-dir> [<trial-count>]" >&2
  exit 1
fi

iter_dir="$1"
declared_trials="${2:-}"

if [[ ! -d "$iter_dir" ]]; then
  echo "Error: $iter_dir is not a directory" >&2
  exit 1
fi

aggregate_path="$iter_dir/aggregate.md"

# extract_summary <scoring-md-path>
# Echos: "caught partial missed total" (space-separated integers).
# caught and total are integers; partial/missed are also integers.
# Returns nonzero if the file lacks a parseable Summary table.
extract_summary() {
  local file="$1"
  # Find the Summary table — the data row directly under "## Summary".
  # The data row is the third "|" line after "## Summary" (header, separator,
  # data). We grep for the line starting with "| " and a digit, after the
  # ## Summary anchor.
  local summary_block
  summary_block=$(awk '
    /^## Summary/ { in_summary = 1; next }
    in_summary && /^\|[[:space:]]*[0-9]/ { print; exit }
  ' "$file" 2>/dev/null || true)

  if [[ -z "$summary_block" ]]; then
    return 1
  fi

  # Extract the three "X/N" cells. Strip pipes and whitespace.
  local cells
  cells=$(echo "$summary_block" | tr '|' '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | awk 'NF > 0 { print }')

  local caught_cell partial_cell missed_cell
  caught_cell=$(echo "$cells" | sed -n '1p')
  partial_cell=$(echo "$cells" | sed -n '2p')
  missed_cell=$(echo "$cells" | sed -n '3p')

  local caught partial missed total
  caught=$(echo "$caught_cell" | awk -F'/' '{ print $1 }' | tr -dc '0-9')
  total=$(echo "$caught_cell" | awk -F'/' '{ print $2 }' | tr -dc '0-9')
  partial=$(echo "$partial_cell" | awk -F'/' '{ print $1 }' | tr -dc '0-9')
  missed=$(echo "$missed_cell" | awk -F'/' '{ print $1 }' | tr -dc '0-9')

  # Validate.
  if [[ -z "$caught" || -z "$partial" || -z "$missed" || -z "$total" ]]; then
    return 1
  fi

  echo "$caught $partial $missed $total"
}

# Walk a condition directory and tally per-trial per-fixture stats.
# Outputs lines: "trial fixture caught partial missed total"
# Skips fixtures whose scoring.md is missing or unparseable (with a warning
# to stderr).
walk_condition() {
  local cond_dir="$1"
  local cond_name="$2"
  if [[ ! -d "$cond_dir" ]]; then
    return 0
  fi

  for trial_dir in "$cond_dir"/trial-*/; do
    [[ -d "$trial_dir" ]] || continue
    local trial_name
    trial_name=$(basename "$trial_dir")
    for fixture_dir in "$trial_dir"*/; do
      [[ -d "$fixture_dir" ]] || continue
      local fixture_name
      fixture_name=$(basename "$fixture_dir")
      local scoring_md="$fixture_dir/scoring.md"
      if [[ ! -f "$scoring_md" ]]; then
        echo "Warning: missing $scoring_md" >&2
        continue
      fi
      local stats
      if ! stats=$(extract_summary "$scoring_md"); then
        echo "Warning: could not parse summary in $scoring_md" >&2
        continue
      fi
      echo "$trial_name $fixture_name $stats"
    done
  done
}

baseline_lines=$(walk_condition "$iter_dir/baseline" "baseline" || true)
compressed_lines=$(walk_condition "$iter_dir/compressed" "compressed" || true)

# Sum partials with 0.5 weight using awk.
# Input: lines of "trial fixture caught partial missed total"
# Output: "weighted_caught caught_int total_deltas n_observations"
# weighted_caught = sum(caught) + 0.5 * sum(partial)
sum_condition() {
  awk '
    {
      caught += $3
      partial += $4
      missed += $5
      total += $6
      n++
    }
    END {
      weighted = caught + 0.5 * partial
      printf("%.1f %d %d %d %d\n", weighted, caught, partial, missed, total)
    }
  '
}

baseline_summary=$(echo "$baseline_lines" | sum_condition)
compressed_summary=$(echo "$compressed_lines" | sum_condition)

# Parse summary lines. Format: "weighted caught partial missed total"
read -r baseline_weighted baseline_caught baseline_partial baseline_missed baseline_total <<< "$baseline_summary"
read -r compressed_weighted compressed_caught compressed_partial compressed_missed compressed_total <<< "$compressed_summary"

# Compute observed-trial counts.
baseline_trials=$(echo "$baseline_lines" | awk '{ print $1 }' | sort -u | wc -l | tr -d ' ')
compressed_trials=$(echo "$compressed_lines" | awk '{ print $1 }' | sort -u | wc -l | tr -d ' ')

if [[ "${baseline_total:-0}" == "0" || "${compressed_total:-0}" == "0" ]]; then
  echo "Error: no parseable scoring.md files found under $iter_dir" >&2
  exit 1
fi

# Compute the per-trial-equivalent comparison: weighted score per trial.
# (Both conditions should have the same number of trials and the same
# total deltas per trial, but defend against asymmetry.)
weighted_diff_per_trial=$(awk -v cb="$baseline_weighted" -v cc="$compressed_weighted" -v tb="$baseline_trials" -v tc="$compressed_trials" '
  BEGIN {
    if (tb == 0 || tc == 0) { print "0"; exit }
    bp = cb / tb
    cp = cc / tc
    printf("%.2f\n", cp - bp)
  }
')

# Decision logic. Thresholds (per single trial of all fixtures):
#   diff >= -1.0  → SHIP (parity or compressed wins)
#   diff < -1.0   → ITERATE (compressed regressed)
#   ABS(diff) within (1.0, 2.0] AND only 1 trial → ESCALATE_TRIALS
# These thresholds match the plan's "parity within ±1 delta" rule.

decision=$(awk -v diff="$weighted_diff_per_trial" -v trials="$baseline_trials" -v declared="$declared_trials" '
  BEGIN {
    abs = (diff < 0) ? -diff : diff
    if (diff >= -1.0) {
      print "SHIP"
    } else if (abs > 1.0 && abs <= 2.0 && trials == 1) {
      print "ESCALATE_TRIALS"
    } else {
      print "ITERATE"
    }
  }
')

# --- Write aggregate.md ----------------------------------------------------
{
  echo "# Aggregate scoring: $(basename "$iter_dir")"
  echo ""
  echo "Generated by aggregate-trial-scores.sh."
  echo ""
  echo "## Per-trial breakdown"
  echo ""
  echo "Weighted caught = caught + 0.5 × partial. Total deltas across all fixtures and trials are summed per condition."
  echo ""
  echo "| Condition | Trials observed | Caught | Partial | Missed | Total deltas | Weighted caught |"
  echo "|---|---|---|---|---|---|---|"
  printf "| Baseline | %d | %d | %d | %d | %d | %.1f |\n" \
    "$baseline_trials" "$baseline_caught" "$baseline_partial" "$baseline_missed" "$baseline_total" "$baseline_weighted"
  printf "| Compressed | %d | %d | %d | %d | %d | %.1f |\n" \
    "$compressed_trials" "$compressed_caught" "$compressed_partial" "$compressed_missed" "$compressed_total" "$compressed_weighted"
  echo ""
  echo "## Per-trial-equivalent diff"
  echo ""
  echo "Weighted-caught per trial: baseline = $(awk -v c="$baseline_weighted" -v t="$baseline_trials" 'BEGIN{ if (t>0) printf("%.2f", c/t); else printf("0"); }'), compressed = $(awk -v c="$compressed_weighted" -v t="$compressed_trials" 'BEGIN{ if (t>0) printf("%.2f", c/t); else printf("0"); }')."
  echo ""
  echo "Compressed minus baseline (deltas per trial): **$weighted_diff_per_trial**"
  echo ""
  echo "## Per-(condition, trial, fixture)"
  echo ""
  echo "| Condition | Trial | Fixture | Caught | Partial | Missed | Total |"
  echo "|---|---|---|---|---|---|---|"
  echo "$baseline_lines" | while read -r trial fixture caught partial missed total; do
    [[ -z "$trial" ]] && continue
    printf "| baseline | %s | %s | %d | %d | %d | %d |\n" "$trial" "$fixture" "$caught" "$partial" "$missed" "$total"
  done
  echo "$compressed_lines" | while read -r trial fixture caught partial missed total; do
    [[ -z "$trial" ]] && continue
    printf "| compressed | %s | %s | %d | %d | %d | %d |\n" "$trial" "$fixture" "$caught" "$partial" "$missed" "$total"
  done
  echo ""
  echo "## Decision"
  echo ""
  echo "**Verdict: $decision**"
  echo ""
  case "$decision" in
    SHIP)
      echo "Compressed is at parity with baseline (within ±1 delta per trial) or above. The slash command may replace SKILL.md with the compressed draft and commit (autonomous, per the auto-commit-on-parity policy)."
      ;;
    ITERATE)
      echo "Compressed regressed by more than 1 delta per trial. Spawn the iteration-diagnoser subagent to identify structural vs variance losses and propose a patch. Re-run scoring on the patched draft (compressed condition only — baseline scores are reusable across iterations within the same compress run)."
      ;;
    ESCALATE_TRIALS)
      echo "Compressed-vs-baseline diff is borderline (±1 to ±2 deltas) and only one trial ran. Re-invoke the slash command with --trials 3 to separate variance from structural loss before deciding."
      ;;
  esac
  echo ""
  echo "_End of aggregate._"
} > "$aggregate_path"

echo "Wrote $aggregate_path"
echo "Verdict: $decision (diff per trial: $weighted_diff_per_trial)"
