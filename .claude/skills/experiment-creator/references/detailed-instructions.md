# Detailed Instructions for Experiment Creator

## Dynamic Field Resolution

Resolve Jira IDs using this priority:
1. **PRD Header/Content** — identify Tribe, Team, Market, Platform, Funnel Phase.
2. **Jira Catalog** — map names to IDs using `jira-config/jira-team-catalog.md`.
3. **Workspace Defaults** — use personal defaults from `jira-config/user-defaults.md` if not found in PRD.

**Hardcoded defaults (always apply):**
- Assignee: {{PM_NAME}} (`{{ASSIGNEE_ACCOUNT_ID}}`)
- Track: Delivery (`12299`)
- Method: A/B test (`12538`) — override only if PRD explicitly specifies otherwise

---

## Required-at-creation fields

{{COMPANY}} Jira workflow enforces two date fields on creation for Epics and Experiments. Omitting either returns a 400 with `Field 'X' is required`.

| Field | Jira ID | Format | Notes |
|---|---|---|---|
| Start date | `customfield_{{CUSTOM_FIELD_ID}}` | `YYYY-MM-DD` | Default to today's date if the PRD is silent. |
| Due date   | `duedate`           | `YYYY-MM-DD` | Default to end of the current quarter if the PRD is silent. |

Both must go inside `additional_fields` on `createJiraIssue`.

---

## Edit-only experiment fields (hidden from the create-screen metadata)

`getJiraIssueTypeMetaWithFields` only returns the Create-screen field list. The Experiment issue type has three additional fields that only appear on the Edit screen — so they are invisible to the metadata call but MUST be populated on fulfil.

| Field | Jira ID | Type | Value source |
|---|---|---|---|
| **Exp Start** | `customfield_{{CUSTOM_FIELD_ID}}` | `date` (`YYYY-MM-DD` string) | Amplitude `experimentStartDate` |
| **Exp End**   | `customfield_{{CUSTOM_FIELD_ID}}` | `date` (`YYYY-MM-DD` string) | Amplitude `experimentEndDate` |
| **Target Population** | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | Amplitude `analysisParams.exposureTarget` + audience filters + split + statistical method |

**Transactional rollback gotcha:** If any field in an `editJiraIssue` payload fails validation, Jira rolls back the ENTIRE edit — even the fields that passed. When sending a mixed payload (e.g. `customfield_{{CUSTOM_FIELD_ID}}` as ADF next to two date strings), a wrong type on the textarea will silently null out the dates you thought you set. Send date-only fields in a separate call from ADF-textarea fields, or verify each field individually after the call.

---

## Post-run fields (Results & Decision)

These are the fields that complete an experiment ticket after it closes. All hidden from the create metadata; populate in fulfil-existing mode.

| Field | Jira ID | Type | What to write |
|---|---|---|---|
| **Results** | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | Headline, adoption / data cuts, guardrail read, known measurement limitations. Source from the Amplitude results notebook. |
| **Learnings** | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | What the data taught us — mechanism, bottleneck, confounders, caveats. Separate observation from interpretation. |
| **Next steps** | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | The decision (Launch / Kill / Iterate / Hold), follow-up experiment chain, pre-requisites, why-not-alternatives. |
| **Decision** | `customfield_{{CUSTOM_FIELD_ID}}` | single select | Known option IDs: `12521` = Scale / Rollout, `12523` = Kill. Probe for Iterate / Hold via JQL on closed experiments if needed. |
| **Results reviewed by analyst / researcher / specialist and reliable?** | `customfield_{{CUSTOM_FIELD_ID}}` | single select | `12689` = Yes. Probe for No if needed. |
| **Decision follows defined Success Criteria?** | `customfield_{{CUSTOM_FIELD_ID}}` | single select | `12691` = Yes. Use Yes if the documented Success Criteria included an explicit Inconclusive / null path that the chosen decision follows. |

**Probing pattern for option IDs:** run `searchJiraIssuesUsingJql` with `project = {{JIRA_PROJECT_KEY}} AND issuetype = Experiment AND "[Field Name]" is not EMPTY ORDER BY updated DESC` and request the custom field — the returned option IDs are reusable across tickets.

---

## Automation triggers to be aware of

Two text fields on the Experiment issue type contain automation reminders (not intended for Claude to edit):

- `customfield_{{CUSTOM_FIELD_ID}}` — reminder that a summary is auto-posted to `#{{COMPANY_SLACK_PREFIX}}-experiments` on experiment start.
- `customfield_{{CUSTOM_FIELD_ID}}` — reminder that on close, a page is auto-created in the Experimentation Learnings Repository AND another Slack summary is posted, based on the Results & Decisions fields.

Implication: make sure Results / Learnings / Next steps / Decision are correct BEFORE transitioning to Closed — the Slack + Confluence posts read directly from them.

---

## Quality Gate (Step 2 — mandatory before field extraction)

Flag and ask the user before proceeding if any of the following are missing:
- A clear, falsifiable hypothesis
- An unambiguous and measurable primary metric
- A description of control and variant/treatment states (if absent, infer from the solution description and state the inference explicitly)

Also check: no contradictions between hypothesis and success criteria.

---

## Field Extraction Logic

### Summary
Format: `Experiment: [concise description of what is being tested and expected outcome]`
Examples:
- `Experiment: location in F2F example_feature increases CVR`
- `Experiment: semantic search in second section`

### Context (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
- Problem statement scoped to this experiment.
- Why this experiment: prior evidence or signals that motivated it.
- Source: PRD Problem Statement, Assumptions, and Prior Research sections.

### Hypothesis (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
- Standard format: "By [doing X to users in variant], we expect [metric] to [increase/decrease/remain stable] because [rationale]."
- Derive directly from the PRD hypothesis section. If absent, construct from solution vision + expected outcomes.
- Must be falsifiable and tied to the primary metric.

### Primary Metric (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
- Single metric that determines pass/fail of the experiment.
- Source: PRD Success Metrics → Primary.
- State the metric name, definition, and attribution window if available.

### Secondary Metrics (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
- Supporting and guardrail metrics. Label each clearly:
  - `[Supporting]` — provide additional signal but don't determine pass/fail.
  - `[Guardrail]` — must not degrade; degradation = ship-stopper regardless of primary.
- Source: PRD Success Metrics → Secondary and Guardrail sections.

### Success Criteria (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
- Explicit pass/fail thresholds.
- Example: "Primary metric: statistically significant lift (p<0.05). Guardrail: no significant decrease in Shipping CVR."
- Source: PRD success thresholds or derive from metric definitions.

### Method (`customfield_{{CUSTOM_FIELD_ID}}`) — single select
- Default: A/B test (`12538`).
- Override only if PRD explicitly specifies a different method (Concept test, Usability testing, etc.).
- Use the correct option ID from the catalog.

### Do we expect Impact on Business Metrics? (`customfield_{{CUSTOM_FIELD_ID}}`) — single select
- `Yes` (`12540`) if the primary metric is a business or conversion metric (CVR, TRX, revenue).
- `No` (`12541`) if this is a quality/technical/learning experiment with no direct business metric impact.

### Market (`customfield_{{CUSTOM_FIELD_ID}}`) — multi-select
| Market | Option ID |
|--------|-----------|
| ES     | 12626     |
| IT     | 12627     |
| PT     | 12628     |

- Infer from PRD scope section.
- If PRD says "all markets" or is silent, default to all three.

### Platform (`customfield_{{CUSTOM_FIELD_ID}}`) — multi-select
| Platform | Option ID |
|----------|-----------|
| Web      | 12640     |
| Android  | 12641     |
| iOS      | 12642     |
| Backend  | 12796     |

- Infer from PRD scope and stacks involved.

### Funnel Phase (`customfield_{{CUSTOM_FIELD_ID}}`) — single select
| Phase        | Option ID | When to use |
|--------------|-----------|-------------|
| Acquisition  | 12630     | New user acquisition |
| Activation   | 12631     | First-time user actions or onboarding |
| Engagement   | 12798     | Discovery, browsing, search, or listing evaluation |
| Retention    | 12632     | Repeat usage or habit formation |
| Monetization | 12633     | Purchase, transaction, or payment |

- If ambiguous, default to Engagement (`12798`) and flag it.

### Experiment Additional Information (`customfield_{{CUSTOM_FIELD_ID}}`) — ADF textarea
Use the template from [../assets/experiment-additional-info-template.md](../assets/experiment-additional-info-template.md).
- For the experiment key slug: derive a snake_case slug from the feature name (e.g., `example_feature_v1`, `semantic_search_v2`).

---

## Jira Issue Creation

```
Tool: mcp__atlassian__createJiraIssue
Parameters:
- cloudId: "{{ATLASSIAN_BASE_URL}}"
- projectKey: "{{JIRA_PROJECT_KEY}}"
- issueTypeName: "Experiment"
- parent: "[EPIC_ID — omit entirely if not provided in args]"
- summary: "Experiment: [description]"
- assignee_account_id: "{{ASSIGNEE_ACCOUNT_ID}}"
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
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
    customfield_{{CUSTOM_FIELD_ID}}: [ADF object]
```

> **CRITICAL:** All textarea custom fields (`customfield_{{CUSTOM_FIELD_ID}}`, `12808`, `12809`, `12810`, `12816`, `12824`) must be passed as ADF objects: `{"type": "doc", "version": 1, "content": [...]}`. Passing a plain string will return a 400 Bad Request error.
>
> **CRITICAL — No raw markup in ADF:** Never write markdown (`##`, `**`, `- `), wiki markup (`h2.`, `{code}`), or any text-based formatting as literal text inside ADF nodes. Use proper ADF node types instead. A heading must be `{"type": "heading", "attrs": {"level": 2}, "content": [...]}`, NOT a paragraph containing the text `"h2 Title"`. Bold must use `"marks": [{"type": "strong"}]`, NOT `"**text**"`. Same for italic (`em` mark), code (`code` mark), links (`link` mark), and lists (`bulletList`/`orderedList` nodes). The ADF renderer displays raw markup as literal text — it does not interpret it.

---

## Post-Creation Summary

After creating the ticket, output:
- Ticket key and link
- Summary of what was inferred vs. what still needs engineering/data input:
  - Experiment keys (control/variant slugs)
  - Segmentation (trigger event, audience filters, split %)
  - Min app versions
- Any fields where inference was uncertain — flag explicitly so they can be reviewed before the experiment goes live.
