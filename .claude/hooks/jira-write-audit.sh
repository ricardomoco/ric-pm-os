#!/bin/bash
# jira-write-audit.sh — PreToolUse hook
# Logs every Jira/Confluence write operation to .claude/audit/jira-writes.log.
# Non-blocking: always exits 0. Useful for end-of-week activity reports and dedup checks.

INPUT=$(cat)
AUDIT_DIR="$CLAUDE_PROJECT_DIR/.claude/audit"
LOG_FILE="$AUDIT_DIR/jira-writes.log"

mkdir -p "$AUDIT_DIR" 2>/dev/null
command -v jq >/dev/null 2>&1 || exit 0

# One JSON line per write: {ts, tool, input}
echo "$INPUT" | jq -c '{ts: now|todate, tool: .tool_name, input: .tool_input}' >> "$LOG_FILE" 2>/dev/null

exit 0
