#!/bin/bash
# precompact-archive.sh — PreCompact hook
# Archives the full transcript before compaction summarises older history away.
# Best-effort: never blocks compaction.

INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)

[ -z "$TRANSCRIPT_PATH" ] && exit 0
[ -f "$TRANSCRIPT_PATH" ] || exit 0

ARCHIVE_DIR="$CLAUDE_PROJECT_DIR/.claude/transcript-archive"
mkdir -p "$ARCHIVE_DIR" 2>/dev/null

TRIGGER=$(echo "$INPUT" | jq -r '.trigger // "unknown"' 2>/dev/null)
TS=$(date +%Y%m%d-%H%M%S)

cp "$TRANSCRIPT_PATH" "$ARCHIVE_DIR/${TS}-${TRIGGER}.jsonl" 2>/dev/null

exit 0
