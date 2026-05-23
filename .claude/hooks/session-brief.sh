#!/bin/bash
# session-brief.sh — runs on SessionStart; stdout is injected into Claude's context
# Stays best-effort: any failure produces an empty section rather than blocking session start.

cd "$CLAUDE_PROJECT_DIR" 2>/dev/null || exit 0

echo "## Session Brief — $(date +%Y-%m-%d) ($(date +%A))"
echo ""

# --- Active quarterly goals ---
if [ -f your team goals doc ]; then
  echo "### Active Q-Goals"
  grep -E "^Goal [0-9]+:" your team goals doc 2>/dev/null | head -10
  echo ""
fi

# --- Recent commits ---
if git rev-parse --git-dir >/dev/null 2>&1; then
  echo "### Recent commits"
  git log --oneline -5 2>/dev/null
  echo ""
fi

# --- Recently touched project files (top 5, by mtime) ---
if [ -d projects ]; then
  echo "### Recently touched in projects/"
  find projects -type f -name "*.md" \
    -not -path "*/.venv/*" \
    -not -path "*/node_modules/*" \
    -not -path "*/.DS_Store" \
    -exec stat -f "%m %N" {} \; 2>/dev/null \
    | sort -rn \
    | head -5 \
    | awk '{$1=""; sub(/^ /,""); print "- "$0}'
  echo ""
fi

# --- Working tree status ---
if git rev-parse --git-dir >/dev/null 2>&1; then
  DIRTY=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [ -n "$DIRTY" ] && [ "$DIRTY" != "0" ]; then
    echo "### Working tree"
    echo "- $DIRTY uncommitted file(s). Run \`git status\` for details."
    echo ""
  fi
fi

exit 0
