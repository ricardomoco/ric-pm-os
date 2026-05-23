# Mode: Fulfil Existing Experiment

Populate or update an existing Jira Experiment ticket. Covers three situations: filling Setup on a ticket created outside this skill (all custom fields null), adding Results + Decision after a run, or amending either.

## Workflow

1. **Fetch the ticket.** Call `mcp__atlassian__getJiraIssue` with the provided key. Request the fields list from [../references/detailed-instructions.md § Field Extraction Logic](../references/detailed-instructions.md) plus `description`, `status`, and `parent`.
2. **Diff against the template.** For each structured custom field (`12807`, `12808`, `12809`, `12810`, `12816`, `12824`, plus Market / Platform / Funnel / Method / Business Impact / Scope), note whether it is `null` or populated.
3. **Read-before-overwrite guard.** Never overwrite a populated field unless the user explicitly asked to rewrite it. When a field is populated and the user's ask would change it, list the field + current content and confirm before editing.
4. **Gather supporting context.** Pull whatever is needed for the update:
   - For **Setup fulfilment**: the source PRD, Confluence page, or inline description. Same Quality Gate as create mode.
   - For **Results / Decision**: the Amplitude experiment (`mcp__Amplitude__get_from_url`), results notebook, dashboards, and any decision-option notes from the user. Use the Results & Decision template at [../assets/results-decision-template.md](../assets/results-decision-template.md).
5. **Build ADF payloads.** All textarea custom fields must be ADF objects — NOT markdown strings (the API rejects strings with "Operation value must be an Atlassian Document"). Use the helper pattern in [../references/adf-helpers.md](../references/adf-helpers.md).
6. **Where does Results go?** The {{COMPANY}} Experiment issue type does not have a dedicated Results custom field. Put the Results + Decision narrative in the `description` (which accepts markdown via `contentFormat: "markdown"`). Keep Setup content in the structured custom fields so the template renders correctly in Jira.
7. **Edit the ticket.** Call `mcp__atlassian__editJiraIssue` with the fields to write. Do not touch fields you are not explicitly updating.
8. **Post-update checklist.** Confirm with the user:
   - Any status transition needed ("Ready to Launch" → launched, "Closed" → with resolution).
   - Any follow-up tickets / experiments chained from this one (create separately — not part of the fulfil call).
   - Any stakeholder sign-off still pending.

## Jira Edit Call

```
Tool: mcp__atlassian__editJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_DOMAIN}}"
- issueIdOrKey: "{{JIRA_PROJECT_KEY}}-XXXXX"
- contentFormat: "markdown"  # affects description only
- fields:
    # Setup (ADF objects only — NOT strings)
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Context
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Hypothesis
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Primary Metric
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Secondary Metrics
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Success Criteria
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Additional Information

    # Select lists (option IDs)
    customfield_{{CUSTOM_FIELD_ID}}: [...]  # Market
    customfield_{{CUSTOM_FIELD_ID}}: [...]  # Platform
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Funnel Phase
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Method
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Business Impact
    customfield_{{CUSTOM_FIELD_ID}}: {...}  # Scope

    # Results + Decision (markdown string is fine in description)
    description: "## Hypothesis ... ## Context ... ## Results ... ## Decision ..."
```

## Quality Checklist (before submission)

- [ ] Every null field has either been populated or explicitly left null with a reason.
- [ ] No populated field was overwritten without confirmation.
- [ ] Results narrative has: Headline, Data cuts, Guardrails, Known limitations.
- [ ] Decision has: explicit option (e.g. Launch / Kill / Iterate), justification, why other options were rejected.
- [ ] Follow-up experiments / tickets noted (not auto-created).
- [ ] Status transition flagged for the user.
