#!/usr/bin/env bash
# regression-test-stash.sh
#
# PreToolUse hook on Edit|Write. Stashes the current on-disk content of an
# artifact under projects/ to .claude/cache/regression-
# testing/stashes/<mirrored-path> BEFORE the tool modifies it. The stash
# captures the state just before the first edit in a feedback cycle and is
# preserved across multiple edits within the same cycle (only written if no
# stash exists for that path). The stash is cleared by the slash command
# after the autonomous loop runs.
#
# This decouples the regression-test pre-fix from git HEAD — users no longer
# need to commit between feedback rounds for the loop to trigger.
#
# Does NOT block the tool call. Always exits 0.

set -euo pipefail

input=$(cat)
tool_name=$(printf '%s' "$input" | jq -r '.tool_name // empty')
file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')

# Bail silently on missing fields
[[ -z "$tool_name" || -z "$file_path" ]] && exit 0

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

# For Write: there's no pre-state on disk if the file is new, and overwriting
# an existing file is rare/explicit enough that we still stash it (so a Write
# that overwrites a file behaves like an Edit for stash purposes).
# For Edit: always relevant — stash the current content as pre-state.

# Resolve the stash path. Mirror the original path under stashes/.
stash_root=".claude/cache/regression-testing/stashes"
stash_path="$stash_root/${file_path#/}"

# If a stash already exists for this file, leave it alone — preserves the
# state of the cycle's FIRST edit across subsequent edits in the same cycle.
if [[ -e "$stash_path" ]]; then
  exit 0
fi

# Source file must exist for there to be a pre-state. (For brand-new Writes,
# the file does not exist yet on disk.)
if [[ ! -e "$file_path" ]]; then
  exit 0
fi

# Create the parent directory and copy the current content as the stash.
mkdir -p "$(dirname "$stash_path")"
cp "$file_path" "$stash_path"

exit 0
