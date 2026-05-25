#!/usr/bin/env bash
# apply-customization.sh — executes the bulk find-replace + scaffolding for the get-started skill.
# Called by the get-started skill after the user has answered all questions.
# Idempotent: re-running with the same env vars produces the same result.

set -euo pipefail

# --- Resolve workspace root (the dir containing .claude/) ---
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$ROOT"

if [ ! -d ".claude/skills" ]; then
  echo "Error: expected to run from a PM OS workspace root (with .claude/skills/ present)." >&2
  echo "Current dir: $ROOT" >&2
  exit 1
fi

# --- Required env vars ---
: "${PM_OS_COMPANY:?Set PM_OS_COMPANY}"
: "${PM_OS_TEAM:?Set PM_OS_TEAM}"

# --- Optional env vars ---
PM_OS_PRODUCT="${PM_OS_PRODUCT:-{{PRODUCT}}}"
PM_OS_ATLASSIAN_BASE="${PM_OS_ATLASSIAN_BASE:-{{ATLASSIAN_BASE_URL}}}"
PM_OS_JIRA_KEY="${PM_OS_JIRA_KEY:-{{JIRA_PROJECT_KEY}}}"
PM_OS_CONFLUENCE_KEY="${PM_OS_CONFLUENCE_KEY:-{{CONFLUENCE_SPACE_KEY}}}"
PM_OS_ROLE="${PM_OS_ROLE:-Senior Product Manager}"
PM_OS_DOMAIN="${PM_OS_DOMAIN:-marketplace}"
PM_OS_STYLE="${PM_OS_STYLE:-terse}"
PM_OS_INTEGRATIONS="${PM_OS_INTEGRATIONS:-atlassian,granola,amplitude,slack,google_workspace,figma}"
PM_OS_SKILL_CATEGORIES="${PM_OS_SKILL_CATEGORIES:-writing,experiments,research,people,planning,tickets}"

echo "=== Applying PM OS customization ==="
echo "Company:       $PM_OS_COMPANY"
echo "Team:          $PM_OS_TEAM"
echo "Product:       $PM_OS_PRODUCT"
echo "Atlassian:     $PM_OS_ATLASSIAN_BASE"
echo "Jira key:      $PM_OS_JIRA_KEY"
echo "Confluence:    $PM_OS_CONFLUENCE_KEY"
echo "Integrations:  $PM_OS_INTEGRATIONS"
echo "Categories:    $PM_OS_SKILL_CATEGORIES"
echo ""

# --- 1. Bulk placeholder replacement ---
echo "[1/6] Replacing placeholders across all skills/commands/agents/hooks..."

# Escape user input for perl (the values may contain regex special chars)
esc() { printf '%s' "$1" | sed 's/[\/&]/\\&/g'; }

COMPANY_ESC=$(esc "$PM_OS_COMPANY")
TEAM_ESC=$(esc "$PM_OS_TEAM")
PRODUCT_ESC=$(esc "$PM_OS_PRODUCT")
ATLASSIAN_ESC=$(esc "$PM_OS_ATLASSIAN_BASE")
JIRA_ESC=$(esc "$PM_OS_JIRA_KEY")
CONFLUENCE_ESC=$(esc "$PM_OS_CONFLUENCE_KEY")

find .claude templates style-guide \
  -type f \( -name "*.md" -o -name "*.sh" -o -name "*.py" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" \) \
  -not -path "*/node_modules/*" \
  -not -path "*/.git/*" \
  -not -path "*/_archived/*" \
  -not -path "*/templates/*" \
  -not -path "*/get-started/*" \
  -exec sed -i.bak \
    -e "s/{{COMPANY}}/$COMPANY_ESC/g" \
    -e "s/{{TEAM}}/$TEAM_ESC/g" \
    -e "s/{{PRODUCT}}/$PRODUCT_ESC/g" \
    -e "s|{{ATLASSIAN_BASE_URL}}|$ATLASSIAN_ESC|g" \
    -e "s/{{JIRA_PROJECT_KEY}}/$JIRA_ESC/g" \
    -e "s/{{CONFLUENCE_SPACE_KEY}}/$CONFLUENCE_ESC/g" \
    {} \;

# Clean up .bak backups created by sed -i.bak
find .claude templates style-guide -type f -name "*.bak" -delete 2>/dev/null || true

echo "    Placeholders replaced."

# --- 2. Copy CLAUDE.md template to workspace root ---
echo "[2/6] Setting up CLAUDE.md at workspace root..."

if [ ! -f CLAUDE.md ]; then
  cp templates/CLAUDE.md.template CLAUDE.md
  # Apply the same substitutions to the freshly copied file
  sed -i.bak \
    -e "s/{{COMPANY}}/$COMPANY_ESC/g" \
    -e "s/{{TEAM}}/$TEAM_ESC/g" \
    -e "s/{{PRODUCT}}/$PRODUCT_ESC/g" \
    -e "s|{{ATLASSIAN_BASE_URL}}|$ATLASSIAN_ESC|g" \
    -e "s/{{JIRA_PROJECT_KEY}}/$JIRA_ESC/g" \
    -e "s/{{CONFLUENCE_SPACE_KEY}}/$CONFLUENCE_ESC/g" \
    CLAUDE.md
  rm -f CLAUDE.md.bak
  echo "    CLAUDE.md created."
else
  echo "    CLAUDE.md already exists — left untouched (delete manually to regenerate)."
fi

# --- 3. Copy settings.json template and trim un-selected MCP servers ---
echo "[3/6] Configuring .claude/settings.json..."

if [ ! -f .claude/settings.json ]; then
  cp templates/settings.json.template .claude/settings.json
  echo "    settings.json created. MCP servers and permissions need manual review (see SECURITY.md)."
  echo "    Un-selected integrations ($PM_OS_INTEGRATIONS) — remove their mcpServers entries manually if you don't want them prompting."
else
  echo "    settings.json already exists — left untouched."
fi

# --- 4. Scaffold expected directories ---
echo "[4/6] Scaffolding workspace directories..."

mkdir -p projects research meetings
[ -f knowledge-base-reference.md ] || echo "# Knowledge Base References

Auto-populated by the log-external-resource hook. Refine the [auto-logged] stubs into meaningful summaries.
" > knowledge-base-reference.md

echo "    Created: projects/, research/, meetings/, knowledge-base-reference.md"

# --- 5. Mark hooks executable ---
echo "[5/6] Marking hooks executable..."

chmod +x .claude/hooks/*.sh 2>/dev/null || true
chmod +x .claude/hooks/*.py 2>/dev/null || true

echo "    Done."

# --- 6. Archive un-selected skill categories ---
echo "[6/6] Archiving un-selected skill categories..."

mkdir -p .claude/skills/_archived

# Map categories → skill folders
archive_if_unchecked() {
  local category="$1"
  shift
  if [[ ! "$PM_OS_SKILL_CATEGORIES" =~ "$category" ]]; then
    for skill in "$@"; do
      if [ -d ".claude/skills/$skill" ]; then
        mv ".claude/skills/$skill" ".claude/skills/_archived/$skill"
        echo "    Archived: $skill"
      fi
    done
  fi
}

archive_if_unchecked "writing" prd-writer prd-editor prd-roaster prd-accessibility-requirements one-pager-creator product-vision
archive_if_unchecked "experiments" experiment-creator post-experiment-report
archive_if_unchecked "research" research-synthesizer ur-survey-creator
archive_if_unchecked "planning" planning
archive_if_unchecked "tickets" jira-ticket-writer bug-ticket-creator

# pm-writing-standards, success-metrics, assumption-identifier, product-discovery-coach,
# prompt-optimizer, get-started, shared
# are always kept regardless of category selection — they are foundational.

echo ""
echo "=== Setup complete ==="
echo ""
echo "Files customized:    $(find .claude templates style-guide -type f | wc -l | tr -d ' ')"
echo "Skills active:       $(ls .claude/skills/ 2>/dev/null | grep -v _archived | grep -v get-started | grep -v shared | wc -l | tr -d ' ')"
ARCHIVED_COUNT=$(ls .claude/skills/_archived/ 2>/dev/null | wc -l | tr -d ' ')
echo "Skills archived:     $ARCHIVED_COUNT"
echo "Hooks executable:    $(find .claude/hooks -maxdepth 1 -type f -executable | wc -l | tr -d ' ')"
echo ""
echo "Try these next:"
echo "  1. Start a new Claude Code session in this directory."
echo "  2. The session-brief hook will surface your goals.md and recent activity."
echo "  3. Try: \"draft a PRD for <a feature you're working on>\""
echo "  4. Verify nothing sensitive will be committed:  git status  &&  git check-ignore -v goals.md projects/ meetings/"
echo ""
echo "Re-run this setup any time by typing \"get me started\" again."
