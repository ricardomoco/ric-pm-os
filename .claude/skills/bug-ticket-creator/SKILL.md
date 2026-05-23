---
name: bug-ticket-creator
description: Convert bug observations and context into structured, technically accurate Jira bug tickets. Use when you need to report a functional error, layout issue, or data inconsistency to engineering teams.
---

# Bug Ticket Creator

Expert guidance for transforming user observations and technical evidence into actionable Jira bug reports.

## Core Principles
- **Zero Invention:** NEVER invent data, metrics, specific values (e.g., distance steps), or user quotes. If information is missing from the evidence or user input, you MUST ask for clarification or search the documentation.
- **Evidence-First:** Repro steps and results must be derived directly from the provided media (screenshots/videos) or explicit user statements.
- **Evidence Field Tracking:** If the user provides any form of testing evidence (e.g., screenshots, videos, or links to such evidence), you MUST mark the `Testing evidence` field as `Evidence added` in the Jira payload.
- **Undefined Assignee:** The ticket MUST be created as "Undefined" (unassigned) by default. NEVER assign the ticket to the reporter or any other user unless specifically instructed by the user.

## Workflow

1.  **Identify Reporter**: Fetch the `default_user` from memory and print "Bug Reporter: [User Name]".
2.  **Analyze Evidence First**: If the user provides screenshots or videos, use vision tools to analyze them **before** drafting repro steps. Identify visual inconsistencies, error messages, or specific UI states.
3.  **Gather & Verify Bug Context**: 
    - Use the headers in [bug-description-template.md](assets/bug-description-template.md) as a guide.
    - **CRITICAL:** For **Mobile App bugs**, you MUST gather and include: **Device Model**, **OS Version**, and **App Version**. If any of these are missing from the user's report or evidence, ask for them.
    - **CRITICAL:** If the bug involves specific discrete values (e.g., slider steps, dropdown options), VERIFY them in the documentation or ask the user. DO NOT guess based on "common patterns."
    - **Never assume repro steps if evidence is available.**
4.  **Resolve Jira Mapping & Validate Metadata**:
    - Consult [jira-config/jira-team-catalog.md](../../../jira-config/jira-team-catalog.md) to map the target Tribe, Team, and **Platform Components** (e.g., _iOS, _Android, _Web) to their numeric IDs.
    - If the target team is unclear, fallback to the reporter's defaults in [jira-config/user-defaults.md](../../../jira-config/user-defaults.md).
    - **CRITICAL:** Call `getJiraIssueTypeMetaWithFields` for the target Project and 'Bug' (ID: 1) issue type. Verify which fields (including `components` and custom fields) are mandatory and available to ensure the final payload is complete.
5.  **Inject Bug Mappings**: Load mandatory numeric IDs for the following fields from [bug-field-mappings.md](references/bug-field-mappings.md):
    - **Issue Type**: Bug (1)
    - **Discovered in environment**: Production (10542)
    - **Fix Type**: Regular (12486)
    - **Origin**: Internally reported (12951)
    - **Testing evidence**: `Evidence added` (16589) IF evidence is provided.
6.  **Draft Ticket & Technical Payload**: 
    - Populate the [bug-description-template.md](assets/bug-description-template.md) with the gathered information. 
    - **FORMATTING MANDATE**: DO NOT use `#` headers. Use `*BOLD TEXT*` or `**Bold Text**` for section labels to ensure compatibility with all Jira views.
    - **SUMMARY MANDATE**: The summary (title) MUST include the impacted platform in square brackets at the beginning (e.g., `[Android] ...`).
    - **HIGH-SIGNAL MANDATE:** Delete any optional headers or bullet points (e.g., User/Data, Logs, Occurrence) that are not populated with specific, actionable information. DO NOT leave placeholders.
    - **MANDATORY:** Prepare the full technical payload (Tribe, Team, Component, etc.) for the `createJiraIssue` tool. Ensure the summary is distinctive as per [guidance.md](references/guidance.md). **The assignee MUST remain empty (Undefined).**
    - **MANDATORY:** If evidence (screenshots/videos) was provided, include the `Testing evidence` field in the payload as `Evidence added`.
7.  **Deterministic Validation Check**: 
    - Before asking for confirmation, you MUST run the validation script:
        1.  Save the `createJiraIssue` technical payload as a JSON file in a temporary location.
        2.  Run `python scripts/validate_bug_payload.py [payload_file]`.
        3.  If the script returns an error, you MUST fix the specific issues identified and re-run the validation. **A successful validation (`VALIDATION_SUCCESS`) is mandatory before proceeding.**
8.  **Final Validation & Confirmation**: 
    - Display the complete, structured bug report (Summary and Description) and **all technical metadata** (Tribe, Team, Components, Field IDs) to the user.
    - **CRITICAL:** Explicitly ask the user for confirmation (e.g., "Do you want me to create this Jira issue now?") BEFORE calling the `createJiraIssue` tool.
    - **ADF SELF-CORRECTION**: If the initial creation fails with an "Atlassian Document Format (ADF)" error for a specific field, you MUST convert the Markdown string into a standard ADF JSON structure and retry.
    - Proactively advise the user to manually attach media if the Jira tool does not support direct attachments.

## Reference Materials
- [Bug Field Mappings](references/bug-field-mappings.md): Mandatory numeric IDs for bug-specific fields.
- [Reporting Guidance](references/guidance.md): Best practices for summaries and evidence collection.
- [Description Template](assets/bug-description-template.md): The standard Markdown schema for bug submissions.
- [Global Jira Catalog](../../../jira-config/jira-team-catalog.md): Source of truth for Field and Option IDs.
- [Global User Defaults](../../../jira-config/user-defaults.md): Fallback Jira mappings per PM.
