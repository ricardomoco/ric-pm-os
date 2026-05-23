# Detailed Instructions for Jira Ticket Writing

## Required Jira Fields for All Issue Types

When creating any Jira issue (Story, Epic, Task), you MUST include these required custom fields in `additional_fields`. Omitting them causes a 400 Bad Request error.

| Field | Jira Field ID | How to Resolve |
|-------|---------------|----------------|
| **Tribe** | `customfield_{{CUSTOM_FIELD_ID}}` | From PRD header, or fallback to `jira-config/user-defaults.md` |
| **Topic Team** | `customfield_{{CUSTOM_FIELD_ID}}` | From PRD header, or fallback to `jira-config/user-defaults.md` |
| **Track** | `customfield_{{CUSTOM_FIELD_ID}}` | From PRD header, or fallback to `jira-config/user-defaults.md`. **Required for Epics, Stories, Experiments.** |

**Example `additional_fields` for {{PM_NAME}} (default):**
```json
{
  "customfield_{{CUSTOM_FIELD_ID}}": {"id": "12621"},
  "customfield_{{CUSTOM_FIELD_ID}}": {"id": "16629"},
  "customfield_{{CUSTOM_FIELD_ID}}": {"id": "12299"}
}
```

Refer to [jira-config/jira-team-catalog.md](../../../jira-config/jira-team-catalog.md) for all valid option IDs.

---

## Systematic Analysis (Scratchpad)
Before generating tickets, perform this analysis:
1. **Extract Requirements**: Identify functional requirements, edge cases, and analytics needs.
2. **Map to Stacks**: Determine applicability for Android, iOS, Web, and Backend.
3. **Validate INVEST**: Ensure stories are Independent, Negotiable, Valuable, Estimable, Small, and Testable.
4. **Identify Gaps**: Flag missing information as "[TBD]".

## INVEST Principles Validation
- **Independent**: Avoid blocking dependencies within the story.
- **Negotiable**: Leave implementation flexibility for the team.
- **Valuable**: Deliver clear user or business value.
- **Estimable**: Keep scope clear enough for estimation.
- **Small**: Fit within one sprint.
- **Testable**: Use specific, observable outcomes in AC.

## Acceptance Criteria Best Practices (Gherkin)
- **Given**: Initial context (state, preconditions).
- **When**: The action or event.
- **Then**: The expected measurable outcome.

## Stack-Specific Guidance
- **Android/iOS**: Material Design/HIG compliance, mobile-specific permissions, push notifications, deep links.
- **Web**: Responsive design, browser compatibility, WCAG accessibility.
- **Backend**: API endpoints, data models, validation logic, performance, migrations.

## Quality Checklist
- [ ] All PRD requirements covered.
- [ ] Tracking/analytics ticket included.
- [ ] All AC use Given-When-Then.
- [ ] Stack-specific considerations addressed.
- [ ] Correct Jira Field and Component IDs applied.
- [ ] No new info invented beyond PRD.
