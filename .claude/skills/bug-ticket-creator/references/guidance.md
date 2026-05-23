# Bug Reporting Guidance

## Summary Writing
The summary should be **informative, concise, and distinctive**. 
- **MANDATORY**: Include the impacted platform in square brackets at the beginning of the title.
- **Good**: `[iOS] Item cards not clickable in Featured Items slider for Cars`
- **Good**: `[Android] Distance slider unresponsive when dragged from right side in Location filter`
- **Bad**: `Item card bug`

## Essential Information
Ensure the report captures:
- **Environment**: 
    - For **Mobile Apps** (iOS/Android), you MUST include: **Device Model**, **OS Version**, and **App Version**.
    - For Web, include: Browser name/version and OS.
- **Context**: User data, item URL, specific prerequisites.
- **Evidence**: Screenshots, videos, Amplitude links, or logs.
- **Timestamp**: Exact date and time the issue occurred.

## Payload Compatibility & Formatting
To ensure the bug report is rendered correctly across all Jira views:
- **Avoid Headers**: DO NOT use `#` Markdown headers in the `description` or custom fields. Use `*BOLD TEXT*` for section labels instead.
- **ADF vs. Markdown**: Some Jira custom fields (like `customfield_{{CUSTOM_FIELD_ID}}`) strictly require **Atlassian Document Format (ADF)** JSON. If a `Bad Request` occurs with a "must be an Atlassian Document" error, you must convert the content to an ADF structure before retrying.
- **Project Specifics**: For the `{{JIRA_PROJECT_KEY}}` project, prefer a clean, vertical layout with bullet points for readability on mobile devices.
