# Mode: Create New Experiment

Create a new Jira Experiment issue from a PRD, Confluence page, notes, or inline context.

## Workflow

1. **Parse Arguments & Fetch Context.** Extract Epic ID from args if present. Fetch the source document (Confluence URL, local file path, Jira ticket, or inline text). If no context is provided, use `AskUserQuestion` and pause until provided.
2. **Quality Gate.** Validate that the context contains (or allows inferring) a clear hypothesis, an unambiguous primary metric, and described control/variant states. Flag gaps and ask for clarification — do NOT invent content.
3. **Extract Fields.** Infer all experiment fields using [../references/detailed-instructions.md](../references/detailed-instructions.md). Pay attention to the **Required-at-creation fields** checklist — missing Start date or Due date returns a 400.
4. **Build ADF Payloads.** All textarea custom fields (`12807`, `12808`, `12809`, `12810`, `12816`, `12824`) must be ADF objects. Use the helper pattern in [../references/adf-helpers.md](../references/adf-helpers.md) — never hand-write markdown inside ADF nodes.
5. **Create the Issue.** Call `mcp__atlassian__createJiraIssue` with all resolved fields. Use the Setup-phase `customfield_{{CUSTOM_FIELD_ID}}` template from [../assets/experiment-additional-info-template.md](../assets/experiment-additional-info-template.md).
6. **Post-Creation Summary.** Output the ticket key/link and flag any fields requiring engineering or data input (experiment keys, segmentation, min app versions). If any inferred fields were low-confidence, flag them explicitly for review.

## Jira Issue Creation

```
Tool: mcp__atlassian__createJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_DOMAIN}}"
- projectKey: "{{JIRA_PROJECT_KEY}}"
- issueTypeName: "Experiment"
- parent: "[EPIC_ID — omit entirely if not provided in args]"
- summary: "Experiment: [concise description]"
- assignee_account_id: "{{ASSIGNEE_ACCOUNT_ID}}"
- contentFormat: "markdown"  # description only
- description: "[Markdown string — OK for description field]"
- additional_fields:
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TRIBE_OPTION_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[TEAM_OPTION_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "12299"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "12516"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "12538"}
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[12540=Yes | 12541=No]"}
    customfield_{{CUSTOM_FIELD_ID}}: [{"id": "..."}, ...]
    customfield_{{CUSTOM_FIELD_ID}}: [{"id": "..."}, ...]
    customfield_{{CUSTOM_FIELD_ID}}: {"id": "[FUNNEL_PHASE_ID]"}
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Context
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Hypothesis
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Primary Metric
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Secondary Metrics
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Success Criteria
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]  # Additional Information (Setup template)
    customfield_{{CUSTOM_FIELD_ID}}: "YYYY-MM-DD"  # Start date — REQUIRED
    duedate: "YYYY-MM-DD"             # Due date — REQUIRED
```

## Quality Checklist (before submission)

- [ ] Hypothesis is falsifiable and tied to the primary metric.
- [ ] Primary metric has definition, direction, and MDE.
- [ ] Secondary metrics are labelled `[Supporting]` or `[Guardrail]`.
- [ ] Success Criteria lists explicit pass / fail / inconclusive thresholds.
- [ ] Setup template (Additional Information) covers Control, Variant A, Keys, Segmentation, Min App Versions.
- [ ] Start date and Due date set.
- [ ] No information invented beyond the input.
