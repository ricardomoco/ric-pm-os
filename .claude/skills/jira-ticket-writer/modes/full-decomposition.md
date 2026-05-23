# Mode: Full Decomposition (Epics + Stories)

Decompose a PRD or large feature into logical Epics, then create Stories under each Epic.

## Phase 1: Epic Decomposition

### 1. Decomposition Strategy
Determine how to logically divide the work. Strategies:
- **Feature-Based**: Each epic covers a distinct feature area
- **Journey-Based**: Each epic covers a user journey stage
- **MVP-Iteration**: First epic is MVP, subsequent epics are iterations

Aim for **2–5 Epics**. Each must deliver standalone value.

### 2. Core Philosophy
- Epics define **capabilities** (what the system must do), NOT **implementation solutions** (how to build it).
- Ground all requirements in the problem space and user value.
- If the PRD makes premature implementation decisions, generalize them into **capabilities**.

### 3. Quality Gate
Before creating Epics, validate:
- **Consistency**: No contradictions or ambiguous requirements
- **Requirements vs Solutions**: No premature implementation decisions
- If issues found, ask the user for clarification before proceeding.

### 4. Epic Structure
Each Epic description follows this template:

```markdown
## Problem Statement
[Pain point scoped to this epic]

## Solution Vision
[High-level description of what this epic delivers]

## Technical Requirements (Capabilities)
- [Capability 1 — what, not how]
- [Integration needs]

## Success Metrics
[Measurement needs. Label examples as illustrative only.]

## Scope
**In Scope:** [Capability-based scope]
**Out of Scope:** [Work handled elsewhere]

## User Stories (High-Level)
[Capabilities to be detailed as Stories below]
```

### 5. Epic Summary Format
`[User Segment]: [Action/Capability] for [Benefit/Outcome]`

### 6. Create Epics in Jira

```
Tool: mcp__atlassian__createJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_BASE_URL}}"
- projectKey: "{{JIRA_PROJECT_KEY}}"
- issueTypeName: "Epic"
- summary: "[User Segment]: [Action/Capability] for [Benefit/Outcome]"
- description: "[Epic description from template above]"
- additional_fields:
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TRIBE_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TEAM_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TRACK_ID]"}
    components: [{"id": "[COMP_ID]"}]
```

## Phase 2: Story Creation (per Epic)

After all Epics are created, decompose each into Stories.

For each Epic:
1. **Extract requirements** scoped to that Epic.
2. **Draft Stories** following INVEST principles and the [user-story-template.md](../assets/user-story-template.md).
3. **Define AC** using Gherkin syntax (Given/When/Then).
4. **Map to Stacks** — Android, iOS, Web, Backend using Component IDs from [jira-config/jira-team-catalog.md](../../../../jira-config/jira-team-catalog.md).
5. **Link each Story** to its parent Epic via `parent: "EPIC_ID"`.
6. **Create ONE `[DATA]` story per Epic** for tracking instrumentation.

## Phase 3: Validate

Cross-reference against the [detailed-instructions.md](../references/detailed-instructions.md) quality checklist:
- All PRD requirements covered across all Epics
- No gaps between Epics (every requirement mapped to exactly one Epic)
- All AC use Given-When-Then
- Stack-specific considerations addressed
- Correct Jira Field and Component IDs applied
- No information invented beyond the input
