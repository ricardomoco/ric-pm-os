---
name: regression-testing-skills
description: Use when user feedback has been applied to an artifact a writing skill produced (post-experiment-report, prd-writer, rfc-writer, one-pager-creator, jira-ticket-writer, feedback-provider, research, etc.). Auto-detects the pre-fix and post-fix versions, generates the delta, proposes a skill optimization, A/B tests it, and commits if the test passes — autonomously, only escalating to the user for genuinely ambiguous decisions.
---

# Regression testing skills

## Quickstart (autonomous happy path)

The user gives feedback on something Claude produced. Without further instruction, Claude:

1. Detects the feedback-driven revision (artifact under `projects/**` was edited after a feedback message).
2. Captures the pre-fix (from the PreToolUse stash) and post-fix (working-tree version) of the artifact.
3. Spawns a delta-generator subagent that returns a structured delta.
4. Spawns a skill-edit-proposer subagent that writes an optimized SKILL.md draft addressing every delta item.
5. Samples up to 20 historical fixtures from the skill's `regression-corpus/` directory (empty on the first run). Spawns the canonical and optimized regression subagents in parallel; each reviews both the current pre-fix and the sampled corpus entries. Scores outputs against the current delta and each corpus entry's stored delta.
6. **If optimized ≥ canonical on the current delta AND no corpus regression:** commits the skill update, deletes the draft, promotes (pre-fix, delta) to `regression-corpus/`, surfaces a one-paragraph summary to the user. **If the optimized version regresses on the current delta:** runs ONE patch attempt, re-tests, commits if fixed. **If it regresses on a corpus entry:** aborts without patch attempt and leaves the draft for manual review.

The user only sees the summary. Steps 1-5 happen behind the scenes within a single turn — the PostToolUse trigger hook injects an `additionalContext` recommendation immediately after the feedback-driven edit, and Claude follows it before finishing the response.

The **canonical entry point** is the slash command **`/regression-testing-skills:learn <skill-name>`** (defined at `.claude/commands/regression-testing-skills/learn.md`). It drives the autonomous flow end-to-end. Manual invocation is supported but rarely needed once the PostToolUse trigger hook is configured.

## Why this exists

Each rule in a mature skill was added in response to a real failure. When user feedback exposes a new failure mode, that's free signal: someone just hand-corrected an artifact in a way the skill should have done autonomously next time. Capturing that signal as a skill update — automatically, on every feedback turn — is how the skill library compounds. The Iron Law from `superpowers:writing-skills` (NO SKILL EDIT WITHOUT A FAILING TEST FIRST) still applies; the autonomous loop just runs the test on the user's behalf.

## Trigger conditions

The protocol activates when ALL of:

- An artifact under `projects/**/*.md` was modified this turn (Edit or Write).
- A pre-fix stash exists for the artifact at `.claude/cache/regression-testing/stashes/<path>` — written automatically by the PreToolUse `regression-test-stash.sh` hook before the edit. The stash captures the state of the file just before the FIRST edit in this feedback cycle and persists across multiple edits in the same cycle. **No git commit is required.**
- The stashed pre-fix differs from the post-edit working tree (otherwise the edit was a no-op).
- The user's most recent message was in a feedback register — contains terms like "missed", "should have caught", "you didn't include", "this is wrong", "fix this", "we need to mention", "it should say", "the rule is", or similar correction patterns. Conservative pattern matching: when in doubt, do not trigger.
- The skill that produced the artifact is identifiable from the path (see "Skill inference from path" below).

If all hold, the autonomous loop fires. If the stash is missing (brand-new file just created by Write), the path doesn't map to a known skill, or the user's message looks like a fresh request rather than feedback — the loop is skipped silently. False positives waste subagent budget and produce noise; the bar for triggering is high.

### Why a stash, not git HEAD

Earlier versions of this protocol used `git show HEAD:<path>` as the pre-fix. That forced users to commit between every feedback round — otherwise the second feedback edit's pre-fix would still be the original draft, conflating two rounds of corrections. The stash mechanism removes the commit dependency: the PreToolUse hook stashes whatever is on disk before the first edit, and the slash command clears the stash after the loop runs. Subsequent edits within the same cycle leave the stash alone (the stash represents cycle-start, not edit-start).

## Skill inference from path

Heuristic mapping based on filename and parent directory:

| Path pattern | Skill |
|---|---|
| `projects/*/PRD/*.md`, `*-prd*.md`, `*-prd-*.md` | `prd-writer` |
| `projects/*/*-post-experiment-report*.md`, `*-experiment-report*.md` | `post-experiment-report` |
| `*-rfc.md`, `*-rfc-*.md` | `rfc-writer` |
| `*-one-pager*.md`, `*-onepager*.md` | `one-pager-creator` |
| `*-key-learnings*.md`, `*-research*.md` (under `research/`) | `research` |

If the path matches none, do not trigger. If it matches more than one, pick the most specific match (longer suffix wins).

## Autonomous protocol (what the slash command runs)

### Step 0 — Sanity check the trigger

If the protocol was invoked but the trigger conditions don't all hold, abort with a one-line explanation. Do not proceed on partial signal.

### Step 1 — Capture pre-fix and post-fix

- **Post-fix** = the current working-tree version of the artifact.
- **Pre-fix** = the stashed version at `.claude/cache/regression-testing/stashes/<artifact-path>`, copied to a working temp file under the run's cache dir for clean subagent inputs. If the stash does not exist, the loop has nothing to compare against; abort.

The stash path is remembered for the cleanup step at the end of the protocol — the slash command must delete the stash after the loop runs (commit OR revert) so the next feedback cycle starts fresh. (See "Step 8 — Cleanup" below.)

### Step 2 — Auto-generate the delta

Read the prompt template at `references/subagent-prompt-delta-generator.md`. Substitute placeholders. Spawn a single subagent. Capture its output (numbered delta entries) to a temp file under `.claude/cache/regression-testing/<timestamp>-delta.md`.

If the subagent returns zero delta items, abort: the user's feedback didn't change anything rule-relevant. This happens when the user adds new content that wasn't a correction.

### Step 3 — Auto-propose the optimized skill

Read the prompt template at `references/subagent-prompt-skill-edit-proposer.md`. Substitute placeholders, including the path of the delta file from Step 2. Spawn a single subagent. The subagent writes the optimized draft directly to `.claude/skills/<skill>/references/SKILL-draft-optimized.md`.

### Step 4 — Run the regression test

Read the prompt templates at `references/subagent-prompt-canonical.md` and `references/subagent-prompt-optimized.md`. Substitute placeholders. Dispatch BOTH subagents in a SINGLE message via the Agent tool with `subagent_type: general-purpose`.

### Step 5 — Score against the delta

Build a comparison table: rows are D1..Dn from the delta file, columns are Agent A (canonical) and Agent B (optimized). Mark each ✓/✗/partial.

### Step 6 — Decide and act (autonomous)

| Outcome | Action |
|---|---|
| **B catches every delta item that A caught, and additionally catches items A missed** | Commit. Replace canonical SKILL.md with the optimized draft. Delete the draft file. Surface a one-paragraph summary to the user (skill, score, what new rules were added). |
| **B catches at least everything A catches** | Commit (same as above). Bonus catches B made beyond the delta are noted in the summary as "extra rigor added." |
| **B misses any delta item A caught** | Run ONE patch attempt: spawn the skill-edit-proposer again with an additional input — the regression that occurred — and instruction to apply ONE more sharpening move on the missed rule. Re-spawn ONLY the optimized subagent. If the patch fixes the miss, commit. If not, abort the optimization, leave canonical SKILL.md untouched, leave the draft in place for human review, and surface the regression to the user. |
| **Both miss a delta item** | Pre-existing weakness in the skill — neither version catches it. Note in the summary, do not block the optimization, do not auto-add a new rule (the skill-edit-proposer was supposed to add one and didn't; that's a Step 3 limitation worth surfacing). |

### Step 7 — Surface a summary

The user only sees this. Format:

```
Auto-improved skill: <skill-name>
Score: A=<X>/<n>, B=<Y>/<n>. <Committed | Reverted>.
Delta items addressed: <list of D# summaries>.
New rules added: <count> (in <section names>).
Bonus catches: <count> (rules B caught beyond the delta).
[If reverted] Regression on: <which delta item>. Draft left at: <path>. Manual review needed.
```

Keep it terse. The user can run `git diff` on the skill if they want the full change.

### Step 8 — Cleanup

Delete the stash file at the path remembered in Step 1, regardless of whether the loop committed or reverted. This is mandatory: if the stash isn't cleared, the next Edit's PreToolUse hook will see an existing stash for that path and won't overwrite it (the stash hook preserves cycle-start state by design), so the next loop run would compare against stale state from this cycle instead of starting fresh.

The per-run cache directory under `.claude/cache/regression-testing/<timestamp>/` is left in place as debug material; the user may delete it manually. The optimized draft is already deleted on commit (Step 6) and left in place on revert (Step 6) for human review.

## When to escalate to the user (high ambiguity)

The autonomous loop ASKS the user via AskUserQuestion only when:

- **Path infers to multiple skills** with similar specificity. Ask which skill the artifact came from.
- **Pre-fix stash is missing AND the PreToolUse hook hasn't been activated yet** (settings reload pending — the hook was added recently but the running Claude Code instance hasn't picked it up). Ask via AskUserQuestion whether to skip this run, treat the previous Edit-tool-input as the pre-fix, or refresh `/hooks` and re-trigger. (Note: if the stash is missing because the artifact was created via a Write to a path that didn't previously exist on disk, that's a silent skip per the failure-modes section below — not an escalation.)
- **Delta is empty** but the artifact was substantively modified. Ask whether the modification was content addition (skip) or rule-driven correction the delta-generator missed (run again with a hint).
- **Patch attempt fails AND the delta-generator output looked questionable.** Ask whether to restart with a different delta or abort.

In all other cases, run silently. Auto mode is the default; user input is the exception.

## Manual mode (fallback)

For cases the autonomous trigger misses, or for testing speculative skill edits with no real feedback yet, the slash command can be invoked manually:

`/regression-testing-skills:learn <skill-name>`

Without other arguments, the slash command attempts auto-discovery: it scans `.claude/cache/regression-testing/stashes/` for active stashes (each stash represents an in-flight feedback cycle), then falls back to the most recently modified docs file under `projects/` if no stash exists. If discovery fails, it asks the user for explicit pre-fix and post-fix paths.

## Convention: directory layout per skill

```
.claude/skills/<skill-name>/
  SKILL.md                                    canonical version
  references/
    SKILL-draft-optimized.md                  ephemeral; deleted after commit
    <other-references>.md                     persistent (rubrics, checklists, examples)
  regression-corpus/
    <YYYY-MM-DD>-<slug>/
      prefix.md                               pre-fix snapshot (input to the regression test)
      delta.md                                structured delta (ground truth for scoring)
```

The `regression-corpus/` directory grows by one entry per successful commit. It is checked into git alongside the skill — it is durable signal, not a cache. Up to 20 entries are sampled on every subsequent run to verify the new optimization doesn't regress on historical failure modes.

The autonomous loop expects the optimized draft at `references/SKILL-draft-optimized.md`. After commit, the draft is deleted. Sibling reference files the optimization introduces (new rubrics, checklists) are kept.

## What NOT to do

- Do NOT commit if the optimized version regresses on any delta item, even by one. The patch loop runs once; if it doesn't close the gap, abort.
- Do NOT pass skill text inline to subagents. Always read from disk by path.
- Do NOT re-run the canonical subagent after seeing the delta. It runs once, in parallel with the optimized subagent, before any scoring.
- Do NOT trigger on every artifact edit. Trigger conditions exist to keep the bar high; trust them.
- Do NOT silently overwrite a canonical skill when the regression test fails. Always leave the canonical untouched on regression and tell the user.
- Do NOT keep multiple SKILL-draft-optimized.md files around. One draft per skill at a time; deleted after commit.

## Failure modes the loop self-recognizes

- **Empty delta**: the user's edit added content but didn't correct anything. Skip.
- **Path doesn't map to a skill**: heuristic returns no match. Skip.
- **Pre-fix stash missing**: artifact was created via Write to a path that didn't previously exist (no prior on-disk state to stash) OR the PreToolUse hook hasn't been activated yet. Skip silently for the Write-to-new-path case (it's a no-op, not an escalation); for the hook-not-activated case, escalate via AskUserQuestion (see "When to escalate" above) offering skip / use-Edit-tool-input / refresh `/hooks` as options.
- **Multiple matching skills**: ambiguous mapping. Ask the user.
- **Subagent regression**: optimized misses a delta item canonical caught. Run patch, then abort if patch fails.
- **Pre-existing weakness**: both versions miss a delta item. Flag in summary; don't block.
- **Delta-generator returns non-rule corrections**: cosmetic changes leak into delta. The skill-edit-proposer skips them by checking against documented rules. Failures here surface as "no documented rule" entries the proposer notes for human review.

## Compression mode (periodic — every few months or when A/B pass rates drop)

The single-delta loop above adds rules. Over time, rules accrete: cross-cutting lists, axiom bodies, and final-pass checklists each restate the same rule, multi-example actions proliferate, pointer-style entries lose their target bodies. The skill bloats. Eventually the model applying the skill gets diluted attention and A/B test pass rates start dropping on the same corpus that used to score 100%.

Compression mode addresses this. Invoked as `/regression-testing-skills:compress <skill-name>` (optional `--trials N` flag, default 1). The slash command at `.claude/commands/regression-testing-skills/compress.md` orchestrates the loop end-to-end. Detailed phase-by-phase workflow lives in `references/compression-mode.md`.

**When to invoke:** the skill is over 6,000 words AND showing structural redundancy (the audit script flags it), OR recent feedback iterations are seeing flat or declining A/B pass rates, OR the user explicitly asks to "compress", "tighten", "deduplicate", or "audit" a skill.

**When NOT to invoke:** the skill has fewer than 4 corpus entries (insufficient regression evidence), an active single-delta feedback cycle is in flight (workspace conflict), or the skill was compressed within the last 30 days.

**What it produces:** a compressed SKILL.md draft, A/B-tested against the canonical version on the existing `regression-corpus/` entries. Auto-commits on parity (within ±1 delta per trial); attempts ONE iteration if the compressed draft regresses; aborts and surfaces to the user if the regression cannot be patched.

The bash scripts at `scripts/audit-skill.sh`, `scripts/snapshot-skill.sh`, and `scripts/aggregate-trial-scores.sh` handle the mechanical phases (audit, snapshot, score aggregation). The LLM phases use the prompt templates at `references/subagent-prompt-skill-auditor.md`, `references/subagent-prompt-skill-compressor.md`, `references/subagent-prompt-corpus-scorer.md`, and `references/subagent-prompt-iteration-diagnoser.md` — each template specifies the recommended model (Sonnet for auditor / scorer / diagnoser; Opus for compressor only). Token cost for the ship-on-trial-1 path is roughly 700-900k, against ~3M for the manual run that established the protocol.

## Worked example (post-experiment-report, 2026-04-30 — manual run, before autonomous loop existed)

- **Pre-fix:** `projects/search/2026-04-30-example-experiment-postlaunch.md`
- **Post-fix:** `projects/search/2026-04-30-example-experiment-postlaunch.md`
- **Delta** (hand-written then): 15 issues — variant-scope overclaim, internal scaffolding, section discipline, synthesized launch rationale, frame reaffirmation, rollout-execution Next Step, topic-label bullets, personal-name owners, parallel iOS bullets, "Unblock X", prescriptive paraphrase, named-PRD reference, missing sub-headers, etc.
- **First run:** Agent A 14/15, Agent B 13/15. Regression: B missed the section-discipline rule.
- **Patch:** sharpened section-discipline phrasing in the optimized draft (moved into Red Flags, made language directive).
- **Second run:** Agent B 14/15. Regression closed.
- **Decision:** committed.

The autonomous loop reproduces this end-to-end, replacing the manual delta-writing and manual draft-writing with subagent calls. The patch loop is mechanical (apply ONE sharpening move on the missed rule); the commit gate is unchanged (B ≥ A on every delta item).
