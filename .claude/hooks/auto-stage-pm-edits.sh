#!/bin/bash
# auto-stage-pm-edits.sh — PostToolUse hook (Edit|Write)
# Auto-stages PM artefact edits (projects/**/*.md, knowledge-base-reference.md) so review is one
# `git diff --cached` away. Excludes settings files and anything outside the project root.
# Best-effort: never blocks, never errors out.

INPUT=$(cat)

command -v jq >/dev/null 2>&1 || exit 0
[ -n "$CLAUDE_PROJECT_DIR" ] || exit 0

FP=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
[ -n "$FP" ] || exit 0

# Resolve to absolute path; bail if outside the project root
case "$FP" in
  /*) ABS="$FP" ;;
  *)  ABS="$CLAUDE_PROJECT_DIR/$FP" ;;
esac
case "$ABS" in
  "$CLAUDE_PROJECT_DIR"/*) ;;
  *) exit 0 ;;
esac

# Compute path relative to project root
REL="${ABS#$CLAUDE_PROJECT_DIR/}"

# Hard exclusions — never auto-stage these even if they match below
case "$REL" in
  .claude/settings*.json) exit 0 ;;
  .claude/*) exit 0 ;;
esac

# Allowlist — only stage PM artefact edits
case "$REL" in
  projects/*.md|projects/*/*.md|projects/*/*/*.md|projects/*/*/*/*.md) ;;
  knowledge-base-reference.md) ;;
  *) exit 0 ;;
esac

# Stage silently — git refuses gitignored paths and that's fine
( cd "$CLAUDE_PROJECT_DIR" && git add -- "$REL" ) >/dev/null 2>&1

exit 0
