---
description: Autonomously learn from feedback applied to a {{COMPANY}} skill's output — generates the delta, proposes a skill optimization, A/B tests it, and commits if it passes
argument-hint: <skill-name> (optional; auto-inferred if omitted)
---

You are running the **regression-testing-skills** protocol autonomously. The user invoked `/regression-testing-skills:learn $ARGUMENTS`.

**Read the skill at `.claude/skills/regression-testing-skills/SKILL.md` for the full protocol** — this slash command is the orchestration script that drives it end-to-end. Run silently to the user; surface only the final summary unless you hit a high-ambiguity case requiring escalation.

## Step 0 — Resolve the skill and artifact

`ARTIFACT_PATH` is always auto-discovered, regardless of whether `$ARGUMENTS` is provided. Discovery priority:

1. **Active stash** — list files under `.claude/cache/regression-testing/stashes/` (the mirrored path under `stashes/` IS the artifact path). If there is exactly one active stash, use the corresponding artifact. If there are multiple, pick the one with the most recent stash mtime.
2. **Most-recently modified docs file** — fall back to the most recent mtime under `projects/**/*.md` if no stash exists.

If discovery returns nothing, escalate via AskUserQuestion: ask the user for an explicit artifact path.

Then resolve the skill:

- **If `$ARGUMENTS` is provided**, treat it as the skill directory name (e.g., `post-experiment-report`) and use it. The skill name argument overrides the heuristic — useful when the artifact's path doesn't unambiguously identify its skill.
- **If `$ARGUMENTS` is empty**, apply the path-to-skill heuristic from the SKILL.md "Skill inference from path" table to `ARTIFACT_PATH`.

If the heuristic returns multiple matches with similar specificity, use AskUserQuestion to disambiguate. Otherwise proceed silently.

Resolve absolute paths once and reuse:

- `SKILL_DIR` = `.claude/skills/<skill-name>`
- `SKILL_PATH` = `<SKILL_DIR>/SKILL.md`
- `OPTIMIZED_DRAFT_PATH` = `<SKILL_DIR>/references/SKILL-draft-optimized.md`
- `PM_WRITING_STANDARDS_PATH` = `.claude/skills/pm-writing-standards/SKILL.md`
- `ARTIFACT_PATH` = absolute path of the artifact whose feedback drove this loop
- `CACHE_DIR` = `.claude/cache/regression-testing/<timestamp>` (create it with mkdir -p)
- `CORPUS_DIR` = `<SKILL_DIR>/regression-corpus`

For additional reference files: glob `<SKILL_DIR>/references/*.md`, exclude `SKILL-draft-optimized.md`, `subagent-prompt-*.md`, and `example-*.md`. The remaining files are the skill's persistent reference set.

## Step 1 — Capture pre-fix and post-fix

`POST_FIX_PATH` = `<CACHE_DIR>/postfix.md` — copy the current working-tree version of `ARTIFACT_PATH` here.

`PRE_FIX_PATH` = `<CACHE_DIR>/prefix.md` — copy from the PreToolUse stash at `.claude/cache/regression-testing/stashes/<ARTIFACT_PATH>`. The stash captures the state of the artifact before the first edit in this feedback cycle, written by `regression-test-stash.sh` on PreToolUse.

If the stash does not exist, the loop has no pre-fix to compare against. Two reasons this happens:

- The artifact was newly created by a Write to a path that didn't previously exist (no prior on-disk state to stash). Abort silently.
- The PreToolUse hook hasn't been activated yet (settings reload pending — the hook was added recently). Use AskUserQuestion to escalate per the rule in "Escalation rules" below; offer the three options enumerated there (skip, treat previous Edit-tool-input as pre-fix, refresh `/hooks`).

If `diff PRE_FIX_PATH POST_FIX_PATH` returns empty, abort silently — there's nothing to learn from.

`STASH_PATH` = the path to the stash file. Remember it; you'll clear it in Step 8.

## Step 2 — Auto-generate the delta

Read `.claude/skills/regression-testing-skills/references/subagent-prompt-delta-generator.md`. Substitute placeholders:

- `{{PRE_FIX_PATH}}`, `{{POST_FIX_PATH}}` from Step 1.
- `{{SKILL_PATH}}`, `{{PM_WRITING_STANDARDS_PATH}}` from Step 0.
- `{{ADDITIONAL_REFERENCES}}` — the persistent reference set from Step 0.

Spawn ONE subagent (`subagent_type: general-purpose`). Write its output verbatim to `<CACHE_DIR>/delta.md`. This is `DELTA_PATH`.

If the delta has zero items, abort — the post-fix added content but didn't correct anything.

## Step 3 — Auto-propose the optimized skill

Read `.claude/skills/regression-testing-skills/references/subagent-prompt-skill-edit-proposer.md`. Substitute placeholders:

- `{{SKILL_PATH}}`, `{{PM_WRITING_STANDARDS_PATH}}`, `{{ADDITIONAL_REFERENCES}}` as above.
- `{{DELTA_PATH}}` from Step 2.
- `{{OPTIMIZED_DRAFT_PATH}}` from Step 0.

Spawn ONE subagent. It writes the optimized draft to `OPTIMIZED_DRAFT_PATH` directly. After it completes, verify the file exists and has frontmatter matching the canonical (or with sharpened description if the proposer changed it).

## Step 3.5 — Sample the regression corpus

List valid entries under `CORPUS_DIR`:

```bash
ls -d <CORPUS_DIR>/*/ 2>/dev/null | shuf | head -20
```

For each directory returned, verify both `<dir>/prefix.md` and `<dir>/delta.md` exist. Discard directories where either is absent. The surviving pairs are `CORPUS_ENTRIES` — a list of `{slug, corpus_prefix_path, corpus_delta_path}` tuples where `slug` is the directory name.

If `CORPUS_DIR` does not exist or yields no valid entries, set `CORPUS_ENTRIES = []` and continue — this is the first run for this skill.

Construct `{{CORPUS_SAMPLE}}` for substitution into the Step 4 agent prompts:
- If empty: the string `"None."`
- Otherwise: a numbered list, one line per entry — `"Corpus entry N (<slug>): prefix at <corpus_prefix_path>, delta at <corpus_delta_path>"`

## Step 4 — Run the regression test (parallel)

Read both:

- `.claude/skills/regression-testing-skills/references/subagent-prompt-canonical.md`
- `.claude/skills/regression-testing-skills/references/subagent-prompt-optimized.md`

Substitute placeholders in each (paths from Step 0 + 1; `{{POST_FIX_PATH}}` is supplied so subagents know what to avoid; `{{CORPUS_SAMPLE}}` from Step 3.5 so agents also review historical fixtures).

Dispatch BOTH subagents in a SINGLE message via the Agent tool. Capture each output to `<CACHE_DIR>/agent-A.md` and `<CACHE_DIR>/agent-B.md`.

## Step 5 — Score

**Current artifact.** For each delta item D1..Dn from `DELTA_PATH`, check whether agent A's output and agent B's output flag the same violation (semantic match on the rule citation; quoted excerpt may vary). Mark each ✓ / ✗ / partial.

Tally:

- `A_caught` = number of ✓ in column A.
- `B_caught` = number of ✓ in column B.
- `bonus_A`, `bonus_B` = items each agent flagged that are NOT in the delta. Note but do not score.

**Corpus entries.** For each corpus entry E in `CORPUS_ENTRIES`, read its `corpus_delta_path`. For each delta item in that file, check whether agent A's `## Corpus: <slug>` section and agent B's `## Corpus: <slug>` section each flag a matching violation. Mark each ✓ / ✗ / partial.

Tally:

- `A_corpus` = (caught_count, total_corpus_delta_items) across all sampled entries combined.
- `B_corpus` = (caught_count, total_corpus_delta_items) across all sampled entries combined.

## Step 6 — Decide and act

Evaluate current-artifact delta first, then corpus. A commit requires passing both gates.

| Condition | Action |
|---|---|
| For every D# where A is ✓, B is also ✓ (B ≥ A on the delta) AND B_corpus ≥ A_corpus on every corpus entry | **Commit.** Replace `SKILL_PATH` with the contents of `OPTIMIZED_DRAFT_PATH`. Delete `OPTIMIZED_DRAFT_PATH`. Keep any new sibling reference files the proposer created. Proceed to Step 7. |
| There exists a D# where A is ✓ and B is ✗ (current-artifact regression) | **Patch attempt.** Read the failed delta item. Spawn the skill-edit-proposer again with an additional instruction: "The previous draft at `<OPTIMIZED_DRAFT_PATH>` regressed on D# (cite). Apply ONE additional sharpening move to that rule per the playbook in `subagent-prompt-skill-edit-proposer.md`. Overwrite `OPTIMIZED_DRAFT_PATH`." After it completes, re-spawn ONLY the optimized subagent (read the optimized prompt template again, same placeholders, same `{{CORPUS_SAMPLE}}`). Re-score B against both the current delta and corpus. If the previously-missed item is now ✓ AND no new regression appeared in either current or corpus, **commit**. If still missing or new regression appeared, **abort**: leave canonical untouched, leave the draft in place, surface the regression in Step 7. |
| B regresses on a corpus entry (A ✓, B ✗ on a historical delta item) | **Abort.** No patch attempt — the patch loop targets the current artifact, not historical cases; patching blindly for historical fixtures risks new regressions. Leave canonical untouched, leave draft for manual review. Surface the corpus regression in Step 7. |
| Both agents miss a D# (current or corpus) | Pre-existing weakness. Note in summary. Do not block the optimization. |

## Step 7 — Surface the summary

Output to the user (chat message, not file):

```
🔁 Auto-improved skill: <skill-name>
   Score: A=<A_caught>/<n>, B=<B_caught>/<n>. <Committed | Reverted>.
   Corpus: B=<B_corpus_caught>/<total_corpus_items> across <N> sampled entries. <No regressions | ⚠ Regression on <slug> D#: <description>>
   Delta items addressed:
     - D1: <one-line summary>
     - D2: ...
   New rules/sharpenings: <count> in <section names>.
   Bonus catches by B: <bonus_B count>.
   <if reverted due to current-artifact regression:>
   ⚠ Regression on D#: <description>. Patch loop did not close it.
      Optimized draft left at: <OPTIMIZED_DRAFT_PATH> for manual review.
      Canonical SKILL.md unchanged.
   <if reverted due to corpus regression:>
   ⚠ Corpus regression on <slug> D#: <description>.
      Optimized draft left at: <OPTIMIZED_DRAFT_PATH> for manual review.
      Canonical SKILL.md unchanged.
```

Keep it terse. The user can `git diff` the skill if they want detail. Do not include the full delta or full subagent outputs — those are in `<CACHE_DIR>` for debugging.

## Step 8 — Cleanup and corpus promotion

**Always clear the stash** at `STASH_PATH` (delete the file). Whether the loop committed or reverted, the feedback cycle is over and the next user-driven edit should start a fresh cycle. If the stash isn't cleared, the next Edit's PreToolUse hook sees an existing stash and won't overwrite it, so the next loop run would compare against stale state.

**On commit only — promote to corpus:**

```bash
CORPUS_SLUG="<YYYY-MM-DD>-<ARTIFACT_PATH basename without extension>"
mkdir -p "<CORPUS_DIR>/<CORPUS_SLUG>"
cp "<PRE_FIX_PATH>" "<CORPUS_DIR>/<CORPUS_SLUG>/prefix.md"
cp "<DELTA_PATH>" "<CORPUS_DIR>/<CORPUS_SLUG>/delta.md"
```

Use today's date for the `YYYY-MM-DD` prefix. The slug is derived from `ARTIFACT_PATH`: take the last path component and strip the `.md` extension (e.g., `2026-04-30-example-experiment-postlaunch.md` → `2026-04-30-example-experiment-postlaunch`). `CORPUS_DIR` is under the skill directory, not under `.claude/cache/` — it is durable and checked into git.

On revert: do NOT promote. A failed optimization earns no corpus entry.

Leave `<CACHE_DIR>` (the per-run timestamped subdirectory under `.claude/cache/regression-testing/`) in place — these are debug artifacts the user may inspect. Do not delete other regression test runs' caches. The user is responsible for cleaning the cache root manually when they no longer need the debug history.

If committed: `OPTIMIZED_DRAFT_PATH` is already deleted in Step 6.
If reverted: `OPTIMIZED_DRAFT_PATH` stays for the user to review.

## Escalation rules (when to break autonomy)

Use AskUserQuestion only in these cases:

1. **Path-to-skill ambiguous in Step 0** with multiple equally-specific matches.
2. **Pre-fix stash missing in Step 1 because the PreToolUse hook hasn't been activated yet** (settings reload pending — the hook was added recently). Ask whether to skip this run, treat the previous Edit-tool-input as the pre-fix, or open `/hooks` to refresh and try again. (Note: if the stash is missing because the artifact was created via Write to a path that didn't previously exist, that's a silent abort per Step 1, not an escalation.)
3. **Patch attempt fails AND the delta-generator output looks suspect** (e.g., contains many `<no documented rule>` entries — suggests the corrections were not rule-driven). Ask whether to abort or restart with a hint.

In every other case, run silently.

## Failure-mode self-recognition

The slash command is responsible for recognizing each of these and handling them per the rules above:

- Empty delta → abort silently.
- Path doesn't map → abort with note.
- Pre-fix stash missing → for a Write of a brand-new file, abort silently (no escalation); for a hook-not-yet-active case, escalate via AskUserQuestion per "Escalation rules" item 2 (skip / use-Edit-tool-input / refresh `/hooks`).
- Multiple matching skills → escalate.
- Current-artifact subagent regression → patch loop, then abort if patch fails.
- Corpus regression → abort immediately, no patch attempt, leave draft for review.
- Pre-existing weakness (both agents miss) → flag in summary, don't block.
- Subagent invented a rule citation → the proposer rejects "no documented rule" entries by design; surfaces them as candidates for human review in the summary.

## What NOT to do

- Do NOT run any subagent more than the protocol prescribes (delta-generator: 1; skill-edit-proposer: 1, or 2 if patch loop runs; canonical: 1; optimized: 1, or 2 if patch loop runs). Burning subagent budget on retries that aren't in the protocol creates noise.
- Do NOT auto-commit when the regression test fails. The Iron Law applies — no skill edit without a passing test.
- Do NOT pass artifact text inline to the subagents. Always read from the cached pre-fix/post-fix paths.
- Do NOT skip Step 5 (scoring). The decision matrix depends on it.
- Do NOT update the user mid-flow with progress reports. The summary at the end is the only user-visible output unless escalation is needed.
