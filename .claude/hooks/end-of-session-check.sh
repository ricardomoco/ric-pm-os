#!/bin/bash
# end-of-session-check.sh — Stop hook
# Surfaces hygiene state at session end: uncommitted PM artefacts, unrefined auto-logged stubs.
# Output goes to stderr so it shows in the terminal without re-entering the agent loop.

cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0

# Uncommitted files in projects/ (where PRDs and research live)
UNCOMMITTED_PROJECTS=0
if git rev-parse --git-dir >/dev/null 2>&1; then
  UNCOMMITTED_PROJECTS=$(git status --porcelain projects/ 2>/dev/null | wc -l | tr -d ' ')
fi

# Auto-logged stubs awaiting refinement
STUBS=0
if [ -f knowledge-base-reference.md ]; then
  STUBS=$(grep -c "\[auto-logged" knowledge-base-reference.md 2>/dev/null | tr -d ' ')
fi

# Audit log line count for today
JIRA_WRITES_TODAY=0
if [ -f .claude/audit/jira-writes.log ]; then
  TODAY=$(date +%Y-%m-%d)
  JIRA_WRITES_TODAY=$(grep -c "$TODAY" .claude/audit/jira-writes.log 2>/dev/null | tr -d ' ')
fi

# Only print if there's something to flag
if [ "$UNCOMMITTED_PROJECTS" != "0" ] || [ "$STUBS" != "0" ] || [ "$JIRA_WRITES_TODAY" != "0" ]; then
  echo "" >&2
  echo "──── end-of-session check ────" >&2
  [ "$UNCOMMITTED_PROJECTS" != "0" ] && echo "  · $UNCOMMITTED_PROJECTS uncommitted file(s) in projects/" >&2
  [ "$STUBS" != "0" ] && echo "  · $STUBS [auto-logged] stub(s) in knowledge-base-reference.md awaiting refinement" >&2
  [ "$JIRA_WRITES_TODAY" != "0" ] && echo "  · $JIRA_WRITES_TODAY Jira/Confluence write(s) audited today (.claude/audit/jira-writes.log)" >&2
  echo "──────────────────────────────" >&2
fi

exit 0
