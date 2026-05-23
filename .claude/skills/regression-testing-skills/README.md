# regression-testing-skills — architecture map

**This README is for the human maintainer of this skill.** For the protocol itself (when to apply, how to use, decision matrix), read [`SKILL.md`](SKILL.md). This file documents *how the skill is wired*, not *what it does*.

## What this skill does, in one sentence

When user feedback is applied to an artifact a writing skill produced, this skill autonomously runs a TDD loop that uses the feedback as ground truth, proposes an edit to the responsible skill, A/B tests the edit against the canonical version, and commits if the edit catches the feedback's signal.

## Directory map

```
.claude/
├── skills/regression-testing-skills/          ← this skill
│   ├── SKILL.md                               protocol — what the agent reads
│   ├── README.md                              this file — for the human maintainer
│   └── references/
│       ├── subagent-prompt-delta-generator.md       reads pre/post → outputs delta
│       ├── subagent-prompt-skill-edit-proposer.md   reads delta → writes optimized SKILL.md draft
│       ├── subagent-prompt-canonical.md             applies the canonical skill to the pre-fix (+ corpus)
│       └── subagent-prompt-optimized.md             applies the optimized draft to the pre-fix (+ corpus)
├── skills/<skill-name>/regression-corpus/     ← per-skill corpus; checked into git
│   └── <YYYY-MM-DD>-<slug>/
│       ├── prefix.md                          pre-fix from that feedback cycle
│       └── delta.md                           structured delta (ground truth for scoring)
├── commands/
│   └── regression-testing-skills/
│       ├── learn.md                           slash command — orchestrates the autonomous feedback-learning flow
│       └── compress.md                        slash command — orchestrates the periodic compression flow
├── hooks/
│   ├── regression-test-stash.sh               PreToolUse — stashes the pre-edit state
│   └── regression-test-trigger.sh             PostToolUse — emits the recommendation when applicable
└── settings.json                              wires the two hooks (Pre + Post) into the harness
```

External cache (created at runtime, not under version control):

```
.claude/cache/regression-testing/
├── stashes/<mirrored-artifact-path>           pre-fix snapshots, one per active feedback cycle
└── <timestamp>/                               per-run debug artifacts (delta, agent outputs)
```

## Data flow

```
User: feedback on docs/.../foo-post-experiment-report.md
     │
     ▼
Claude calls Edit on the artifact
     │
     ├─ PreToolUse  ────► regression-test-stash.sh
     │                       └─ if no stash exists: copy artifact → stashes/<path>
     │                       └─ if stash exists:    no-op (preserves cycle-start)
     │
     ├─ (Edit executes; artifact modified)
     │
     └─ PostToolUse ────► regression-test-trigger.sh
                             ├─ path matches projects/?
                             ├─ path → known skill (case statement)?
                             ├─ stash exists?
                             ├─ stash differs from working tree?
                             └─ if all yes: emit additionalContext recommending
                                /regression-testing-skills:learn <inferred-skill>
     │
     ▼
Claude reads additionalContext, judges feedback intent, invokes the slash command
     │
     ▼
.claude/commands/regression-testing-skills/learn.md drives:
     1. Capture pre-fix from stash, post-fix from working tree
     2. Spawn subagent with subagent-prompt-delta-generator.md       → delta.md
     3. Spawn subagent with subagent-prompt-skill-edit-proposer.md   → SKILL-draft-optimized.md
     4. Spawn TWO subagents in parallel:
          subagent-prompt-canonical.md  → agent-A.md
          subagent-prompt-optimized.md  → agent-B.md
     5. Score A vs B against delta
     6. Commit (replace SKILL.md, delete draft) OR
        Patch (one sharpening attempt, re-run B) OR
        Revert (leave canonical, leave draft for review)
     7. Surface one-paragraph summary to the user
     8. Clear stashes/<path> so the next cycle starts fresh
```

## Extending the skill

To add support for a new writing skill (e.g., a future `strategy-memo-writer`):

1. **`regression-test-trigger.sh`** — add a `case` arm matching the new artifact's path pattern, mapping to the skill directory name.
2. **`SKILL.md`** — add the skill name to the `description` frontmatter and to the "Skill inference from path" table. No other body changes; the protocol is skill-agnostic.
3. **No changes** to the stash hook, the subagent prompt templates, or the slash command — they're all skill-generic.

The four prompt templates use `{{...}}` placeholders the slash command substitutes at dispatch time. The substitution map lives in the slash command's Step 0; reference it when adding new placeholders.

## Caveats

- **Hook watcher.** Adding a new hook to `settings.json` mid-session may not be picked up by the running Claude Code instance until the user opens `/hooks` once or restarts the session. Pipe-test the hook script after writing it — if pipe tests pass but the hook doesn't fire on real edits, that's the watcher.
- **Feedback intent lives in the model, not the hook.** The PostToolUse hook can detect that an edit happened on a stashed artifact, but it cannot reliably classify "was this a feedback correction?" from a shell. The hook surfaces the option; Claude decides whether to act. A Write-only flow that creates a fresh artifact won't trigger the loop because there's no stash.
- **Stash represents cycle-start.** Multiple edits within a feedback cycle accumulate against the same stash — the loop tests the cumulative diff. The stash is cleared by the slash command after commit OR revert; the next genuine feedback edit starts a fresh cycle.
- **No git dependency.** Earlier versions of this skill used `git show HEAD:` for the pre-fix and forced a commit between every feedback round. The stash mechanism replaces that. Existing artifacts do not need to be tracked in git for the loop to fire.

## Pipe-test sanity check

To verify the wiring after any hook edit, from the repo root:

```bash
# Stash test — should create stash on first call, preserve on second
echo '{"tool_name":"Edit","tool_input":{"file_path":"<some-tracked-doc-path>"}}' \
  | bash .claude/hooks/regression-test-stash.sh

# Trigger test — should emit JSON if stash differs from working tree
echo '{"tool_name":"Edit","tool_input":{"file_path":"<same-path>"}}' \
  | bash .claude/hooks/regression-test-trigger.sh
```

A passing pipe test plus `jq -e '.hooks' .claude/settings.json` returning the expected matchers means the wiring is correct on disk. If real edits still don't trigger, the cause is the hook watcher (see Caveats).
