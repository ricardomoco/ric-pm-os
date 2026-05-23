#!/bin/bash
# log-external-resource.sh — PostToolUse hook
# Auto-appends a stub line to knowledge-base-reference.md when an external resource is fetched.
# The model refines the [auto-logged] summary later. Best-effort: never blocks, never errors out.

INPUT=$(cat)
KB_FILE="$CLAUDE_PROJECT_DIR/knowledge-base-reference.md"

# Bail out silently if KB file missing or jq unavailable
[ -f "$KB_FILE" ] || exit 0
command -v jq >/dev/null 2>&1 || exit 0

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)

URL=""
TITLE=""
KIND=""

case "$TOOL_NAME" in
  *getConfluencePage*)
    PAGE_ID=$(echo "$INPUT" | jq -r '.tool_input.pageId // .tool_input.id // empty' 2>/dev/null)
    TITLE=$(echo "$INPUT" | jq -r '.tool_response.title // .tool_response.metadata.title // empty' 2>/dev/null)
    [ -n "$PAGE_ID" ] && URL="{{ATLASSIAN_BASE_URL}}/wiki/spaces/_/pages/$PAGE_ID"
    KIND="Confluence"
    ;;
  *getJiraIssue|*getJiraIssue\ *)
    ISSUE_KEY=$(echo "$INPUT" | jq -r '.tool_input.issueIdOrKey // empty' 2>/dev/null)
    TITLE=$(echo "$INPUT" | jq -r '.tool_response.fields.summary // empty' 2>/dev/null)
    [ -n "$ISSUE_KEY" ] && URL="{{ATLASSIAN_BASE_URL}}/browse/$ISSUE_KEY"
    KIND="Jira $ISSUE_KEY"
    ;;
  *get_drive_file_content*)
    FILE_ID=$(echo "$INPUT" | jq -r '.tool_input.file_id // empty' 2>/dev/null)
    TITLE=$(echo "$INPUT" | jq -r '.tool_response.name // empty' 2>/dev/null)
    [ -n "$FILE_ID" ] && URL="https://drive.google.com/file/d/$FILE_ID"
    KIND="Drive"
    ;;
  *get_meeting_transcript*)
    MEETING_ID=$(echo "$INPUT" | jq -r '.tool_input.meeting_id // empty' 2>/dev/null)
    TITLE=$(echo "$INPUT" | jq -r '.tool_response.title // .tool_response.meeting_title // empty' 2>/dev/null)
    [ -n "$MEETING_ID" ] && URL="https://notes.granola.ai/d/$MEETING_ID"
    KIND="Granola"
    ;;
  WebFetch)
    URL=$(echo "$INPUT" | jq -r '.tool_input.url // empty' 2>/dev/null)
    TITLE="$URL"
    KIND="Web"
    ;;
  *)
    exit 0
    ;;
esac

# Skip if no URL could be extracted
[ -z "$URL" ] && exit 0

# Skip if already logged (substring match)
if grep -qF "$URL" "$KB_FILE" 2>/dev/null; then
  exit 0
fi

# Fall back title to URL if response didn't carry one
[ -z "$TITLE" ] && TITLE="$URL"

# Append stub line; sentinel "[auto-logged" lets the model and the janitor find these later
echo "* [$TITLE]($URL): [auto-logged $KIND — refine summary on next edit]" >> "$KB_FILE"

exit 0
