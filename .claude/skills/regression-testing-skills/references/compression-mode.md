# Compression mode — detailed protocol

This is the detailed workflow for the `compress` mode of `regression-testing-skills`. The slash command at `.claude/commands/regression-testing-skills/compress.md` is the orchestrator that drives this protocol end-to-end. The parent SKILL.md has only a one-section pointer; everything else lives here.

## When to invoke

Compression mode addresses skill bloat. Each rule in a mature skill was added in response to a real failure (via the single-delta `/regression-testing-skills:learn` loop). Over time, rules accumulate by addition, not by reorganisation. Eventually:

- The same rule appears in 2-3 sections (Cross-cutting + Axiom body + Final-pass checklist), each with slightly different wording.
- A single underlying principle has 3+ named sub-patterns, each with its own ACTION block.
- Quick-reference / pointer entries proliferate and lose their target axiom bodies.
- The model applying the skill gets diluted attention across the bloat — A/B test pass rates start dropping on the same corpus that used to score 100%.

The compress mode reads the skill, runs a structural audit, asks an LLM to write a compressed draft, A/B tests the draft against the original on the existing regression corpus, and commits the compressed version if it preserves quality.

**Invoke when:**

- The skill is over 6,000 words AND showing signs of redundancy (duplicate rules, multi-example actions, pointer-without-body entries — the audit will surface these).
- Recent feedback iterations are seeing flat or declining A/B pass rates on the existing corpus.
- The user explicitly asks to "compress", "tighten", "deduplicate", "reorganise", or "audit" the skill.

**Skip when:**

- The skill has fewer than 4 corpus entries (insufficient regression evidence — the test would have wide noise bands and might OK a quality-loss compression).
- An active single-delta feedback cycle is in flight (a stash exists at `.claude/cache/regression-testing/stashes/` for any artifact under `projects/`). The two protocols share a workspace; running them concurrently is unsafe.
- The skill has been compressed within the last 30 days. Compression buys time but doesn't unbloat by itself; pacing matters.

## Trial count

The slash command accepts `--trials N` (default 1). One trial per condition is enough when the diff is clear; three trials separate noise from structural loss when borderline.

| Trials | Cost (estimated, baseline + compressed) | When to use |
|---|---|---|
| 1 | ~150-220k tokens | Default. The diagnoser surfaces ESCALATE_TRIALS if the diff is ambiguous; user re-invokes with `--trials 3` if needed. |
| 2 | ~300-440k tokens | Rarely useful — either commit to 1 or 3. |
| 3 | ~450-660k tokens | Borderline cases (single-trial diff within ±2 deltas of parity), or when the user wants robust signal upfront. |

The trial subagents are independent (no anchoring within a condition across trials). Each trial spawns one corpus-scorer subagent per condition.

## Phase-by-phase workflow

### Phase 0: Audit (bash, ~0 tokens)

Run `scripts/audit-skill.sh <skill-path> <workspace>/audit.md`. The audit is structural only — word counts, section sizes, example density per section, repeated content, repeated quoted phrases. It writes `audit.md` to the workspace.

Why bash: word-counting and grep-ing are mechanical. Sending 10k words of SKILL.md to an LLM just to count its words wastes tokens.

What the audit does NOT do: semantic deduplication. That is LLM territory in Phase 1. The audit narrows the search space; the LLM auditor decides what to do with the findings.

### Phase 1: Compress (LLM, ~10-15k tokens combined)

Two sequential LLM calls, both reading the audit and the canonical SKILL.md:

1. **Skill auditor** (Sonnet, may run inline in the parent agent's context). Reads the audit + SKILL.md; outputs a compression strategy listing specific moves (collapse cross-section restatement, merge sub-pattern proliferation, deduplicate multi-example redundancy, fix pointer-without-body, rewrite final-pass to scans). Schema in `references/subagent-prompt-skill-auditor.md`.

2. **Skill compressor** (Opus, separate subagent). Reads the strategy + SKILL.md + the audit; writes the compressed draft directly to `<workspace>/skill-iter-<N>/SKILL.md` via the Write tool. The strategy constrains the moves; Opus is justified here because output quality dominates token cost — getting the draft wrong forces an extra iteration. Schema in `references/subagent-prompt-skill-compressor.md`.

Snapshot the canonical SKILL.md to `<workspace>/skill-snapshot/SKILL.md` BEFORE this phase via `scripts/snapshot-skill.sh <skill-path> 1`. The snapshot is the immutable baseline reference for all subsequent iterations within this compress run.

### Phase 2: Score corpus (LLM, ~150-220k tokens)

For each condition (baseline + compressed), spawn ONE corpus-scorer subagent per trial. Default `--trials 1` → 2 subagents total. `--trials 3` → 6 subagents (3 trials × 2 conditions, each trial a fresh subagent — no cross-trial anchoring within a condition).

Each subagent reads ONE skill version and ALL fixtures in the corpus, scores each fixture against its `delta.md` directly, and writes one `scoring.md` per fixture. The scoring.md uses a compact verdict-per-delta schema (`caught | partial | missed` + 1-line evidence) plus a Summary table; the bash aggregator parses the Summary tables.

Why per-(condition, trial) batched-across-fixtures, not per-(fixture, condition)? Two competing pressures:

1. **Isolation across conditions.** A subagent that scored baseline-then-compressed within one context would have anchoring bias: its read of the prefix is contaminated by the baseline scoring. Per-condition isolation removes the bias.
2. **Amortise the SKILL.md system-prompt overhead.** The skill is the largest prompt input; reading it once per subagent (then reusing for all 4 fixtures) is much cheaper than reading it once per (fixture, condition).

The right shape is per-(condition, trial), batched-across-fixtures. Each subagent reads ONE skill version + all four `(prefix.md, delta.md)` pairs.

Schema and dispatch details in `references/subagent-prompt-corpus-scorer.md`. Use `model: sonnet`.

#### Reuse across iterations

If this is iteration 2+ (first iteration regressed and the diagnoser proposed patches), only re-run the COMPRESSED condition. Baseline scores are reusable from iteration 1 — the canonical SKILL.md hasn't changed. Copy the iteration-1 baseline scoring directory into iteration-2/baseline/ before scoring iteration-2/compressed/.

### Phase 3: Aggregate (bash, ~0 tokens)

Run `scripts/aggregate-trial-scores.sh <workspace>/iteration-<N> <trials>`. The script walks the per-(condition, trial, fixture) scoring.md files, tallies caught/partial/missed (partials weighted 0.5), and writes `aggregate.md` with a side-by-side comparison table and a verdict line:

- **SHIP** — diff per trial >= -1.0 (parity within ±1 delta or compressed wins).
- **ITERATE** — diff per trial < -1.0 (compressed regressed by more than 1 delta).
- **ESCALATE_TRIALS** — diff per trial in (-2.0, -1.0] AND only 1 trial ran (borderline; surface recommendation to re-run with --trials 3).

### Phase 4: Diagnose (LLM, ~5-10k tokens, conditional)

Spawn the iteration-diagnoser subagent (Sonnet) only when aggregate verdict is ITERATE or ESCALATE_TRIALS. The diagnoser reads aggregate.md + per-fixture scoring.md files for both conditions + both skill versions + the audit, then produces a verdict (SHIP | PATCH | ESCALATE_TRIALS | ABORT) and, if PATCH, a list of specific edits to the compressed draft.

Schema in `references/subagent-prompt-iteration-diagnoser.md`.

### Phase 5: Iterate or ship (LLM, ~10k tokens conditional)

Branch on the diagnoser's verdict (or aggregate's verdict if Phase 4 was skipped):

- **SHIP** — replace `<skill-path>/SKILL.md` with `<workspace>/skill-iter-<N>/SKILL.md`. Surface a one-paragraph summary to the user with: original word count, compressed word count, % reduction, aggregate score (baseline X/N caught vs compressed Y/N caught), and the list of moves applied. The user can `git diff` the skill if they want detail.

- **PATCH** — apply the diagnoser's proposed edits to the compressed draft via Edit tool calls (one per patch). Run snapshot-skill.sh again to write skill-iter-<N+1>/SKILL.md. Rerun Phase 2 for the COMPRESSED condition only (Baseline scores are reused). Re-run Phase 3 → Phase 4. Cap at iteration 3; if iteration 3 still regresses, escalate to user (do not commit; leave the draft for manual review).

- **ESCALATE_TRIALS** — surface a message to the user: "Compress mode finished one trial; the diff is borderline. Re-invoke `/regression-testing-skills:compress <skill> --trials 3` for robust signal." Do not commit.

- **ABORT** — surface a message to the user: "Compress mode could not produce a draft that preserves quality on the corpus. Diagnosis at `<workspace>/iteration-<N>/diagnosis.md`. The skill may not be currently compressible without quality loss; consider expanding the corpus first or making targeted edits manually." Do not commit; leave drafts and diagnosis for manual review.

### Phase 6: Cleanup

On commit (SHIP):

- Delete the compressed draft from `<workspace>/skill-iter-<N>/` only if the user has confirmed the SHIP. Until commit, the draft stays for inspection.
- Leave the snapshot at `<workspace>/skill-snapshot/SKILL.md` — useful as historical reference.
- Leave the per-iteration scoring directories in place — useful for debugging if the next compress run produces different results.

On non-commit (PATCH that ran out of iterations, ESCALATE_TRIALS, or ABORT):

- Leave everything in the workspace untouched. The user reviews and decides what to do.

## Decision-tree summary

```
audit.sh → strategy → compressor draft
  → score (baseline + compressed)
    → aggregate verdict
      ├ SHIP → commit, summary
      ├ ITERATE → diagnoser
      │   ├ SHIP override → commit, summary
      │   ├ PATCH → apply edits, re-score compressed only, loop (max 3 iterations)
      │   ├ ESCALATE_TRIALS → message user (re-invoke with --trials 3)
      │   └ ABORT → message user (manual review needed)
      └ ESCALATE_TRIALS → message user (re-invoke with --trials 3)
```

## Failure modes the protocol self-recognises

- **Empty corpus** (fewer than 4 entries): the protocol aborts with a message asking the user to populate the corpus via the single-delta loop first. Compression on an empty corpus would commit any compressed draft, including bad ones.
- **No SKILL.md to compress**: the named skill directory has no SKILL.md. Abort with an error.
- **Audit detects no compression opportunities**: the bash audit reports tight section ratios, no repeated content, no multi-example actions. The skill is already lean. Surface to user: "audit detected no structural bloat; compression is unlikely to help. Skip?"
- **Compressor fails to hit the target word count without dropping rules**: the compressor was instructed to overshoot the target rather than drop rules. If the compressed draft is within 10% of the original word count, the audit was wrong about the available compression — surface to user.
- **Aggregator cannot parse a scoring.md**: a subagent produced a malformed Summary table. Re-run that specific subagent; if still malformed, abort.

## Worked example (pm-writing-standards, manual run, 2026-05-01 to 2026-05-02)

The compression mode is modeled on a manual run that established the protocol works. Reproducing the result:

- **Skill:** pm-writing-standards (10,640 words, 255 lines, 4 corpus entries with 27 deltas total)
- **Audit findings:** Cross-cutting + Final-pass + Axiom 3 each duplicating each other; 16 WRONG/RIGHT pairs in Cross-cutting alone; named TL;DR sub-patterns proliferating across Axiom 1 sub-sections.
- **Iteration 1 compressed draft:** 5,370 words (50% reduction). A/B test across 3 trials: ~62.5/81 deltas caught vs baseline ~71.5/81. **-11pp regression** — diagnoser identified structural loss on Lead-with-verdict (Quick-Reference pointer without axiom body) and named TL;DR sub-patterns folded into one rule without specific examples.
- **Iteration 2 compressed draft:** 5,954 words (44% reduction; +600 words from iter-1). Restored the missing ACTIONs and named sub-patterns. A/B test across 3 trials: parity within ±0.17 deltas across all 4 fixtures.
- **Decision:** SHIP. Live SKILL.md replaced.
- **Estimated tokens, manual run:** ~3M.
- **Estimated tokens, automated mode (this protocol, ship-on-trial-1):** ~700-900k. Roughly 70-75% cheaper.

The automated mode reproduces the manual run's structure: audit → compress → A/B test → iterate or ship. The savings come from skipping the verbose violations.md generation step, batching scoring across fixtures per condition, and selecting Sonnet over Opus for the workhorse phases.
