# Mode: Stories Only

Create user stories from the provided context, linked to a parent Epic if one was provided.

## Workflow

### 1. Analyze Requirements
Extract functional requirements, edge cases, and tracking needs from the input.
- If a parent Epic was provided, fetch it with `mcp__atlassian__getJiraIssue` and use its summary/description as additional context.

### 2. Draft User Stories
Follow INVEST principles. Use the [user-story-template.md](../assets/user-story-template.md) for each story.

**Story naming**: `[STACK] Brief action-oriented description`

**INVEST validation**:
- **Independent**: No blocking dependencies within the story
- **Negotiable**: Leave implementation flexibility
- **Valuable**: Clear user or business value
- **Estimable**: Scope clear enough for estimation
- **Small**: Fits within one sprint
- **Testable**: Specific, observable outcomes in AC

### 3. Define Acceptance Criteria
Use Gherkin syntax (Given/When/Then) for all AC.

### 4. Map to Stacks
Create stack-specific tickets (Android, iOS, Web, Backend) using correct Component IDs from [jira-config/jira-team-catalog.md](../../../../jira-config/jira-team-catalog.md).

### 5. Link to Parent
- If the user provided an existing Epic, create all Stories with `parent: "EPIC_ID"`.
- If no Epic was provided, create Stories without a parent (or optionally group under a new Epic if >5 stories — confirm with user first).

### 6. Data/Analytics Story
Create ONE `[DATA]` story per logical grouping for tracking instrumentation.

### 7. Validate
Cross-reference against the [detailed-instructions.md](../references/detailed-instructions.md) quality checklist:
- All requirements covered
- All AC use Given-When-Then
- Stack-specific considerations addressed
- Correct Jira Field and Component IDs applied
- No information invented beyond the input

### Jira Creation

```
Tool: mcp__atlassian__createJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_BASE_URL}}"
- projectKey: "{{JIRA_PROJECT_KEY}}"
- issueTypeName: "Story"
- parent: "[EPIC_ID if provided]"
- summary: "[STACK] ..."
- description: "[Story content from template]"
- additional_fields:
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TRIBE_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TEAM_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TRACK_ID]"}
    components: [{"id": "[COMP_ID]"}]
```
