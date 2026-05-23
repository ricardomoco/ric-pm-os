#!/usr/bin/env bash
# regression-test-trigger.sh
#
# PostToolUse hook on Edit|Write. Fires when an artifact under
# projects/ is modified. Pre-fix comes from a stash
# written by regression-test-stash.sh (PreToolUse). If a stash exists AND
# differs from the post-edit working tree AND the artifact maps to a known
# writing skill, injects additionalContext recommending the
# autonomous regression-testing-skills loop.
#
# Does NOT block the tool call. Always exits 0.
#
# Output format: JSON on stdout with hookSpecificOutput.additionalContext.
# When no nudge applies, exits silently with no output.

set -euo pipefail

input=$(cat)

# Extract the file path. PostToolUse may have either tool_input.file_path or
# tool_response.filePath; prefer the response since it's the canonical value.
file_path=$(printf '%s' "$input" | jq -r '.tool_response.filePath // .tool_input.file_path // empty')

[[ -z "$file_path" ]] && exit 0

# Normalize Windows backslash paths to forward slashes (cross-OS compatibility)
file_path="${file_path//\\//}"

# Only fire on artifacts under projects/
case "$file_path" in
  *projects/*) ;;
  *) exit 0 ;;
esac

# Skip the regression-testing-skills protocol's own scratch files
case "$file_path" in
  *SKILL-draft-optimized.md) exit 0 ;;
esac

# Infer the skill from the path. Order matters — most specific suffix first.
# Catch-all: any doc under projects/ that doesn't match
# a format-specific skill maps to pm-writing-standards, which governs all
# {{COMPANY}} prose regardless of artifact type.
skill=""
case "$file_path" in
  *post-experiment-report*|*experiment-report*) skill="post-experiment-report" ;;
  *one-pager*|*onepager*) skill="one-pager-creator" ;;
  *rfc-*.md|*-rfc.md) skill="rfc-writer" ;;
  */PRD/*|*-prd.md|*-prd-*.md) skill="prd-writer" ;;
  *key-learnings*) skill="research" ;;
  *) skill="pm-writing-standards" ;;
esac

# Verify the skill directory exists in this workspace
[[ ! -d ".claude/skills/$skill" ]] && exit 0

# Resolve the stash path written by the PreToolUse stash hook
stash_root=".claude/cache/regression-testing/stashes"
stash_path="$stash_root/${file_path#/}"

# No stash means either:
#   - The PreToolUse hook hasn't run (settings reload pending), OR
#   - The file was newly created by Write (no prior on-disk state), OR
#   - A previous loop run cleared the stash and this is the first edit of a
#     fresh feedback cycle (the PreToolUse hook for THIS edit should have
#     just stashed, so absence here is unexpected).
# In all cases, skip silently — the loop has nothing to compare against.
[[ ! -e "$stash_path" ]] && exit 0

# If the stash matches the working-tree version, no actual change happened
# (e.g., an Edit that hit `replace_all` with no matches). Skip.
if cmp -s "$stash_path" "$file_path" 2>/dev/null; then
  exit 0
fi

# Compose the additionalContext message
read -r -d '' message <<EOF || true
🔁 Regression-test trigger: an artifact under projects/ ($file_path) was just modified, and a pre-fix stash exists at $stash_path. If this edit was feedback-driven (the user pointed out something the $skill skill missed and you corrected it), invoke /regression-testing-skills:learn $skill autonomously before finishing this response.

The slash command will:
1. Use the stashed pre-fix and the working-tree post-fix as the regression-test inputs.
2. Auto-generate the delta via subagent.
3. Auto-propose an optimized SKILL.md draft via subagent.
4. A/B test current vs. proposed skill on the pre-fix.
5. Commit the optimization if B catches ≥ what A catches; otherwise revert.
6. Clear the stash at $stash_path so the next feedback cycle starts fresh.

Run silently; surface only the final summary to the user. Skip the loop only if this edit was not feedback-driven (e.g., the user is creating a new section unrelated to skill-rule violations) — in that case, also clear the stash manually so the next genuine feedback edit starts a fresh cycle.

See .claude/skills/regression-testing-skills/SKILL.md for the full protocol.
EOF

jq -n --arg msg "$message" '{
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: $msg
  }
}'

exit 0
