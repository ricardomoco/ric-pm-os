# Epic Creator — PRD to Jira Epics

Decompose a Product Requirements Document into multiple logical Epics for automatic creation in Jira via the Atlassian MCP server.

## Scratchpad Analysis

Before creating Epics, analyze the PRD systematically:

### Step 0: Resolve Metadata
- Read Catalog: @{{{KNOWLEDGE_BASE_PATH}}/jira-team-catalog.md}
- Read Workspace Context: @{CLAUDE.md}
- Jira Project Key: {{JIRA_PROJECT_KEY}} (Default)
- Atlassian Cloud ID: {{ATLASSIAN_BASE_URL}} (Default)
- Resolve Tribe ID, Team ID, Track ID
- Identify Custom Field Keys and Component IDs from Catalog

### Step 1: PRD Analysis & Mandatory Quality Gate
- Read through the entire PRD to understand full scope.
- **Consistency Check**: Look for contradictions, ambiguous requirements, or missing logic.
- **Requirements vs Solutions Check**: Identify if the PRD makes premature implementation decisions. These must be generalized into **Capabilities** in the resulting Epics.
- **IF ANY INCONSISTENCY OR AMBIGUITY IS DETECTED:**
  - Use `AskUserQuestion` to list specific clarifying questions.
  - **PAUSE** execution until user provides clarification.
- **IF PRD IS CLEAR:** Proceed to decomposition.

### Step 2: Epic Decomposition Strategy
- Determine how to logically divide the PRD (Feature-Based, Journey-Based, MVP-Iteration).
- Aim for **2-5 epics per PRD**. Each must deliver standalone value.

### Step 3: Validate Epic Decomposition
- Check: Does it describe a **problem**, **opportunity**, or **capability**?
- Check: Does it avoid prescribing an **implementation solution**?
- **Illustration Rule**: If you mention an event or property name for illustration purposes, explicitly state it is just an example.

### Step 4: Map Each Epic to PRD Sections
### Step 5: Craft Epic Summaries
### Step 6: Structure Epic Descriptions
### Step 7: Calculate Required Dates
### Step 8: Prepare Jira Creation Payload
- Ensure `components` field is included in `additional_fields` using IDs from catalog.
- Use resolved Tribe, Team, and Track IDs for custom fields.

---

## Epic Description Template

Each epic description follows this structure:

```markdown
## Problem Statement
[Clear articulation of the pain point scoped to this epic.]

## Solution Vision
[High-level description of what this epic delivers.]

## Technical Requirements (Capabilities)
- [Capability 1, e.g., "Support efficient retrieval of user list metadata"]
- [Integration needs, e.g., "Integration with core Favorites service"]

## Success Metrics
[Measurement needs. Labeled examples only for illustrative event names.]

## Scope
**In Scope:** [Capability-based scope]
**Out of Scope:** [Work handled elsewhere]

## User Stories (High-Level)
[High-level capabilities to be detailed later by the Story Writer mode.]
```

---

## Output Format

Generate epics in this exact format:

```
## DECOMPOSITION SUMMARY
[Strategy overview, number of epics, rationale]

---

## EPIC 1: [EPIC NAME]

### JIRA CREATION COMMAND

Tool: mcp__atlassian__createJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_BASE_URL}}"
- projectKey: "{{JIRA_PROJECT_KEY}}"
- issueTypeName: "Epic"
- summary: "[User Segment]: [Action/Capability] for [Benefit/Outcome]"
- description: "[FULL MARKDOWN DESCRIPTION]"
- additional_fields:
    customfield_{{CUSTOM_FIELD_ID}}: "[RESOLVED_TRIBE_ID]"
    customfield_{{CUSTOM_FIELD_ID}}: "[RESOLVED_TEAM_ID]"
    customfield_{{CUSTOM_FIELD_ID}}: "[RESOLVED_TRACK_ID]"
    components: [{"id": "[COMP_ID]"}]

[Repeat for each Epic]
```
