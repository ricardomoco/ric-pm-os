---
description: Compress an existing {{COMPANY}} skill — audits structural bloat, produces a compressed draft, A/B-tests against the existing regression corpus, and commits on parity.
argument-hint: <skill-name> [--trials N]
---

You are running the **compression mode** of the `regression-testing-skills` protocol. The user invoked `/regression-testing-skills:compress $ARGUMENTS`.

**Read `.claude/skills/regression-testing-skills/SKILL.md` and `.claude/skills/regression-testing-skills/references/compression-mode.md` for the full protocol.** This slash command is the orchestrator that drives it end-to-end. Run silently to the user; surface only the final summary unless you hit a high-ambiguity case requiring escalation.

## Step 0 — Parse arguments and validate

Parse `$ARGUMENTS`:

- First token: `<skill-name>` (the directory under `.claude/skills/`). Required. If missing, escalate via AskUserQuestion asking which skill to compress.
- Optional flag: `--trials N` (where N is 1, 2, or 3). Default N=1.

Resolve absolute paths once and reuse:

- `SKILL_DIR` = `.claude/skills/<skill-name>`
- `SKILL_PATH` = `<SKILL_DIR>/SKILL.md`
- `WORKSPACE` = `.claude/skills/<skill-name>-workspace`
- `CORPUS_DIR` = `<SKILL_DIR>/regression-corpus`
- `PM_WRITING_STANDARDS_PATH` = `.claude/skills/pm-writing-standards/SKILL.md`

Validate:

- `<SKILL_DIR>` exists and contains `SKILL.md`. If not, abort with an error.
- `<CORPUS_DIR>` exists and contains at least 4 entries (subdirectories with both `prefix.md` and `delta.md`). If fewer, abort with: "Compression mode requires at least 4 corpus entries to test fidelity. The current skill has <count>. Run `/regression-testing-skills:learn <skill-name>` on real feedback first to grow the corpus, then retry."
- No active stash exists at `.claude/cache/regression-testing/stashes/` for any artifact under `projects/`. If one does, abort with: "An active feedback cycle is in flight (stash at <path>). Finish that cycle (commit or revert the artifact) before running compress mode — the two protocols share workspace conventions."

For sibling reference files: glob `<SKILL_DIR>/references/*.md`, exclude `SKILL-draft-optimized.md`, `subagent-prompt-*.md`, `compression-mode.md`, and `example-*.md`. The remaining files are `ADDITIONAL_REFERENCES`.

## Step 1 — Phase 0: Audit (bash)

Run:

```
bash .claude/skills/regression-testing-skills/scripts/audit-skill.sh <SKILL_PATH> <WORKSPACE>/audit.md
```

Read the audit output. If the audit reports no compression candidates (largest-to-smallest section ratio < 3.0, no repeated content, no multi-example actions, total word count < 6000), surface to user via AskUserQuestion: "Audit detected no significant structural bloat (ratio <X>×, total <Y> words). Compress mode is unlikely to help. Skip?" Options: skip / proceed anyway / show the audit.

If the audit looks productive, continue.

## Step 2 — Phase 1a: Skill auditor (LLM, inline or subagent)

Read `references/subagent-prompt-skill-auditor.md`. Substitute placeholders:

- `{{SKILL_PATH}}`, `{{AUDIT_PATH}}` (= `<WORKSPACE>/audit.md`), `{{TARGET_WORD_COUNT}}` (read from the audit's "Suggested target word count" line).

Either run inline (read the SKILL.md + audit.md in the parent context, produce the compression strategy as a markdown block) OR dispatch a single subagent with `model: sonnet`. Inline is cheaper; use it unless the parent context is already large.

Save the strategy to `<WORKSPACE>/strategy.md`.

If the auditor's strategy lists zero compression moves, the skill is already lean. Surface to user: "Auditor found no compression moves. Skill is already lean. Aborting." Do not commit anything.

## Step 3 — Snapshot the canonical skill

Run:

```
bash .claude/skills/regression-testing-skills/scripts/snapshot-skill.sh <SKILL_DIR> 1
```

This writes the canonical SKILL.md to both `<WORKSPACE>/skill-snapshot/SKILL.md` (the immutable baseline reference) and `<WORKSPACE>/skill-iter-1/SKILL.md` (will be overwritten by the compressor in the next step).

`SNAPSHOT_PATH` = `<WORKSPACE>/skill-snapshot/SKILL.md`. Remember it for the corpus-scorer subagent.

## Step 4 — Phase 1b: Skill compressor (LLM subagent)

Read `references/subagent-prompt-skill-compressor.md`. Substitute placeholders:

- `{{SKILL_PATH}}` = `<SKILL_PATH>` (canonical)
- `{{STRATEGY_PATH}}` = `<WORKSPACE>/strategy.md`
- `{{AUDIT_PATH}}` = `<WORKSPACE>/audit.md`
- `{{ADDITIONAL_REFERENCES}}` = list of paths from Step 0
- `{{COMPRESSED_DRAFT_PATH}}` = `<WORKSPACE>/skill-iter-1/SKILL.md`
- `{{SKILL_DIR}}` = `<SKILL_DIR>`

Dispatch ONE subagent: `subagent_type: general-purpose`, `model: opus`. The subagent writes the compressed draft directly to the path above.

Verify after dispatch: the file exists, has valid frontmatter (same `name` as canonical), and is non-empty. If any check fails, re-dispatch ONCE with the failure noted in the prompt; if the second attempt also fails, abort with the diagnostic.

`COMPRESSED_PATH` = `<WORKSPACE>/skill-iter-1/SKILL.md`.

## Step 5 — Phase 2: Score corpus (LLM, parallel subagents)

For each trial t in 1..N (where N is the `--trials` value), spawn TWO subagents in parallel via Agent: one for baseline, one for compressed. Total subagents this step: `2 × N`.

For each subagent, read `references/subagent-prompt-corpus-scorer.md` and substitute:

- `{{SKILL_PATH}}` = `<SNAPSHOT_PATH>` for baseline subagents, `<COMPRESSED_PATH>` for compressed subagents.
- `{{PM_WRITING_STANDARDS_PATH}}` = path above (skip if compressing pm-writing-standards itself; in that case omit this line from the prompt).
- `{{ADDITIONAL_REFERENCES}}` = same list as before.
- `{{FIXTURE_LIST}}` = one line per corpus entry, formatted as `<fixture-name> <prefix-path> <delta-path> <output-path>` where `<output-path>` = `<WORKSPACE>/iteration-1/<condition>/trial-<t>/<fixture-name>/scoring.md`.
- `{{OUTPUT_BASE_PATH}}` = `<WORKSPACE>/iteration-1/<condition>/trial-<t>/`.

Dispatch all `2 × N` subagents in a SINGLE message (parallel). Each writes one scoring.md per fixture under the output-base path.

After all subagents complete, verify each expected scoring.md exists and parses (the data row of the Summary table is `| X/N | Y/N | Z/N |`).

## Step 6 — Phase 3: Aggregate (bash)

Run:

```
bash .claude/skills/regression-testing-skills/scripts/aggregate-trial-scores.sh <WORKSPACE>/iteration-1 <N>
```

Read `<WORKSPACE>/iteration-1/aggregate.md`. The script writes a verdict line (SHIP | ITERATE | ESCALATE_TRIALS) at the top of the Decision section.

## Step 7 — Decide based on aggregate verdict

### If SHIP

Replace the canonical skill:

```
cp <COMPRESSED_PATH> <SKILL_PATH>
```

Surface a one-paragraph summary to the user:

```
Compressed skill: <skill-name>
Size: <baseline-words> → <compressed-words> (<reduction-percent>% reduction)
Score: baseline <Bw>/<N>, compressed <Cw>/<N> across <T> fixtures × <trials> trials. Diff per trial: <diff>.
Moves applied: <list from compressor's summary>
[If applicable] Trial count: 1 (default; re-invoke with --trials 3 for robust signal if you want to verify).
```

Do NOT delete the workspace — leave it for the user's inspection. End the loop.

### If ITERATE

Spawn the iteration-diagnoser subagent. Read `references/subagent-prompt-iteration-diagnoser.md` and substitute:

- `{{AGGREGATE_PATH}}` = `<WORKSPACE>/iteration-1/aggregate.md`
- `{{BASELINE_SCORING_DIR}}` = `<WORKSPACE>/iteration-1/baseline/` (the trial-X subdirectories)
- `{{COMPRESSED_SCORING_DIR}}` = `<WORKSPACE>/iteration-1/compressed/`
- `{{BASELINE_SKILL_PATH}}` = `<SNAPSHOT_PATH>`
- `{{COMPRESSED_SKILL_PATH}}` = `<COMPRESSED_PATH>`
- `{{AUDIT_PATH}}` = `<WORKSPACE>/audit.md`

Dispatch ONE subagent: `subagent_type: general-purpose`, `model: sonnet`. The subagent writes a diagnosis to `<WORKSPACE>/iteration-1/diagnosis.md`.

Branch on the diagnoser's verdict:

#### SHIP (override)

Same as the SHIP path above. Note in the user summary: "Diagnoser overrode aggregate — regressions classified as variance, not structural."

#### PATCH

Apply the diagnoser's proposed edits to `<COMPRESSED_PATH>` via Edit tool calls (one per patch).

Run `bash scripts/snapshot-skill.sh <SKILL_DIR> 2` to write iteration-2 from the canonical (then overwrite skill-iter-2/SKILL.md with the patched compressed draft from skill-iter-1, since the patches went there). Actually, simpler: copy the patched draft directly to `<WORKSPACE>/skill-iter-2/SKILL.md` — the snapshot is unchanged across iterations.

For Phase 2 of iteration 2: only spawn COMPRESSED subagents (not baseline). Baseline scores from iteration 1 are reusable. Copy `<WORKSPACE>/iteration-1/baseline/` to `<WORKSPACE>/iteration-2/baseline/` so the aggregator finds them, then run the compressed subagents pointing at `<WORKSPACE>/skill-iter-2/SKILL.md` and writing to `<WORKSPACE>/iteration-2/compressed/trial-X/`.

Run aggregate on iteration-2. Re-evaluate the verdict. Cap at iteration 3 — if iteration 3 still does not SHIP, escalate to user as ABORT (see below).

#### ESCALATE_TRIALS

Same handling as the aggregate's ESCALATE_TRIALS verdict (see below).

#### ABORT

Surface to user:

```
Compress mode could not produce a draft that preserves quality on the corpus.
Diagnosis: <WORKSPACE>/iteration-<N>/diagnosis.md
Compressed drafts: <WORKSPACE>/skill-iter-<N>/SKILL.md
Snapshot baseline: <SNAPSHOT_PATH>
The skill may not currently be compressible without quality loss. Consider expanding the corpus first, or making targeted edits manually.
```

Do not commit. Leave everything in the workspace. End the loop.

### If ESCALATE_TRIALS

Surface to user:

```
Compress mode finished one trial; the diff is borderline (<diff> per trial).
Aggregate: <WORKSPACE>/iteration-1/aggregate.md
Re-invoke `/regression-testing-skills:compress <skill-name> --trials 3` for robust signal before deciding.
```

Do not commit. Leave everything in the workspace. End the loop.

## When to escalate to the user during the loop

The autonomous loop ASKS the user via AskUserQuestion only when:

- `<skill-name>` is missing or invalid (escalate at Step 0).
- The corpus has fewer than 4 entries (Step 0 abort with explanatory message).
- An active stash exists in `.claude/cache/regression-testing/stashes/` (Step 0 abort — do not interfere with an in-flight feedback cycle).
- The audit reports no compression candidates (Step 1 — ask whether to skip, proceed anyway, or show the audit).
- The auditor reports zero compression moves (Step 2 — abort with explanation).
- The compressor's draft is malformed or hits the same word count as canonical (Step 4 — re-dispatch once, then abort).
- The diagnoser's verdict is ABORT (Step 7 — surface the diagnosis).

In all other cases, run silently. The user only sees the final summary unless ABORT or ESCALATE_TRIALS.

## What NOT to do

- Do NOT touch the canonical SKILL.md until the SHIP verdict (or PATCH followed by SHIP after re-scoring). Until then, all edits go to `<WORKSPACE>/skill-iter-<N>/SKILL.md`.
- Do NOT delete the workspace at the end of the loop. Leave it for inspection. The user runs `git diff` on the skill if they want detail; the workspace explains how the diff was derived.
- Do NOT mix this loop's runs with the single-delta `/regression-testing-skills:learn` loop. The latter uses `.claude/cache/regression-testing/`; this one uses `<skill>-workspace/`. Cross-contamination is a setup defect — surface immediately if detected.
- Do NOT add corpus entries during this loop. Compression preserves the existing corpus; the single-delta loop grows it.
- Do NOT invoke the compressor on a skill being actively edited (working-tree is clean for the skill before invocation; if the skill has uncommitted changes, abort and tell the user).
