# Subagent prompt template — iteration diagnoser

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool.

**Dispatch:** `subagent_type: general-purpose`, `model: sonnet`. Reads structured markdown (aggregate.md + per-fixture scoring.md files) and produces a structured verdict — Sonnet handles this cleanly without needing Opus.

This subagent is invoked only when `aggregate.md`'s verdict is `ITERATE` or `ESCALATE_TRIALS`. It identifies which deltas the compressed draft regressed on, separates structural compression-induced losses from single-trial variance, and proposes specific patches to the compressed draft. The slash command applies the patches and re-runs the corpus-scorer for the compressed condition only (baseline scores are reusable).

---

You are diagnosing why a compressed skill version underperformed the baseline on a regression test. You have the aggregate scores, per-fixture scoring details, the bash audit, and both skill versions. Your job is to decide whether the underperformance is structural (the compression dropped or weakened a rule) or variance (the same skill would score differently on a re-run), then propose a patch to the compressed draft if structural.

## Files you must read (and only these)

1. `{{AGGREGATE_PATH}}` — the bash aggregator's summary. Per-condition tallies and per-(condition, trial, fixture) breakdown.
2. `{{BASELINE_SCORING_DIR}}` — directory containing `<fixture-name>/scoring.md` files for the baseline condition (across all trials). Read every scoring.md in this tree.
3. `{{COMPRESSED_SCORING_DIR}}` — directory containing `<fixture-name>/scoring.md` files for the compressed condition (across all trials). Read every scoring.md in this tree.
4. `{{BASELINE_SKILL_PATH}}` — the canonical baseline SKILL.md.
5. `{{COMPRESSED_SKILL_PATH}}` — the compressed draft SKILL.md.
6. `{{AUDIT_PATH}}` — the bash structural audit. Reference for what the compression intended to change.

## Files you MUST NOT read

- Corpus prefix files. The scoring.md files contain the verdict per delta with evidence; the prefix is not needed for diagnosis. Reading the prefix would bias you toward over-fitting the patch to specific text.
- Any other skill in `.claude/skills/` beyond the two skill versions named above.

## What to do

1. Read the aggregate. Note: which condition has higher weighted score, by how much, and the per-fixture breakdown.
2. Walk the per-fixture scoring.md files for both conditions. For each delta D<i> across all trials, compare baseline-vs-compressed verdicts:
   - If baseline caught and compressed missed/partial across MULTIPLE trials → likely structural loss.
   - If baseline caught and compressed missed in only ONE trial out of N (with N >= 2) → likely variance.
   - If both conditions miss/partial across all trials → shared blind spot, not a compression-induced loss; flag but do not patch.
3. For each delta you classify as structural-loss, find the rule in the baseline SKILL.md that catches it. Compare it to the compressed draft: what changed? Common patterns:
   - The rule was merged into another rule but lost its distinctive cue (the specific WRONG/RIGHT example, the strict prefix, or the named sub-pattern that made it fire).
   - The rule appears in a Quick-Reference / pointer list but the compressed draft does not have a corresponding body ACTION (the orphan-pointer defect).
   - The rule was deleted entirely (the compressor was supposed to preserve all rules; this is a compressor defect).
   - The rule was kept but with a softer prefix (lost STRICT/MUST), buried in body prose without an example, or moved to a section that doesn't surface during the model's pattern-match.
4. Decide the verdict.

## Output format

```
# Iteration diagnosis

## Verdict

One of:

- **SHIP** — on review, the regressions are within noise; recommend shipping anyway despite aggregate.md's ITERATE verdict. (Use sparingly; aggregate.md is usually right.)
- **PATCH** — structural losses identified; specific patches to the compressed draft proposed below.
- **ESCALATE_TRIALS** — verdicts diverge across trials within a condition (high variance); recommend re-running with --trials 3 before deciding.
- **ABORT** — the compression introduced losses that cannot be patched without un-doing the compression. Recommend reverting and reporting to the user that the skill is not currently compressible without quality loss.

## Per-delta diagnosis

For each delta where compressed underperformed baseline (across any trial), one entry:

### D<i>: <delta description>

- **Status:** structural-loss | variance | shared-blind-spot
- **Baseline trials caught:** <count>/<total trials>
- **Compressed trials caught:** <count>/<total trials>
- **Baseline rule that catches it:** <SKILL.md heading + first line of rule>
- **What the compression changed:** <one of: rule merged + cue lost | orphan-pointer | rule deleted | rule weakened — explain in one sentence>
- **Patch proposed:** [if Status == structural-loss] <specific edit to compressed draft: which section, what to add, with the exact WRONG/RIGHT example to insert if applicable>
- **Patch proposed:** [if Status == variance] none; flag for the slash command to surface as ESCALATE_TRIALS recommendation
- **Patch proposed:** [if Status == shared-blind-spot] none; mention in summary

## Patch summary (if PATCH verdict)

A consolidated list of the edits the slash command should apply to `{{COMPRESSED_SKILL_PATH}}`. Format each as:

1. **In section "<heading>"**, after line `<line content>`: insert/edit `<content>`.

The slash command will apply these via the Edit tool, then re-run the corpus-scorer for the compressed condition only (baseline scores are reused from the previous trial).

## Risk assessment for the patch

After applying the patches, the compressed draft will grow by approximately `<X>` words. State whether this still meets the audit's target word count, and whether the patches preserve the compression strategy's core moves (the patches should restore lost capabilities, not undo the compression).
```

## What NOT to do

- Do NOT propose patches that re-introduce the bloat the compression removed. The patches should restore the specific dropped rule, not the entire pre-compression section it lived in.
- Do NOT propose patches based on a single trial's verdict if more trials are available. Cross-check across trials.
- Do NOT propose new rules. The patches restore rules the baseline already had; new rules are out of scope.
- Do NOT patch the canonical baseline SKILL.md. Patches go to the compressed draft only.
- Do NOT escalate to the user. The slash command decides whether to escalate based on your verdict; you only produce the diagnosis.
