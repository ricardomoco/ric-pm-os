# Post-Experiment Report — Detailed Instructions

Follow these stages in order. Do not skip ahead even if the input looks complete — stage 4 (stress-test) is the highest-value step and catches the majority of issues.

---

## Stage 1 — Ingest

### Fetch the experiment ticket

```
mcp__atlassian__getJiraIssue
- cloudId: {{ATLASSIAN_DOMAIN}}
- issueIdOrKey: <experiment key>
- fields: [
    "summary", "description", "status", "parent", "issuetype",
    "customfield_{{CUSTOM_FIELD_ID}}",  # Context
    "customfield_{{CUSTOM_FIELD_ID}}",  # Hypothesis
    "customfield_{{CUSTOM_FIELD_ID}}",  # Primary Metric
    "customfield_{{CUSTOM_FIELD_ID}}",  # Success Criteria
    "customfield_{{CUSTOM_FIELD_ID}}",  # Experiment Additional Information (Setup)
    "customfield_{{CUSTOM_FIELD_ID}}",  # Secondary Metrics
    "customfield_{{CUSTOM_FIELD_ID}}",  # Exp Start
    "customfield_{{CUSTOM_FIELD_ID}}",  # Exp End
    "customfield_{{CUSTOM_FIELD_ID}}",  # Target Population
    "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}",
    "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}",
    "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}",  # Results/Learnings/Next steps (null on entry)
    "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}", "customfield_{{CUSTOM_FIELD_ID}}"   # Decision + flags
  ]
- responseContentFormat: "markdown"
```

If `customfield_{{CUSTOM_FIELD_ID}}` (Hypothesis), `customfield_{{CUSTOM_FIELD_ID}}` (Success Criteria), or `customfield_{{CUSTOM_FIELD_ID}}` (Primary Metric) is null, STOP and ask the user to fill them via the `experiment-creator` (fulfil-existing) skill first. You cannot write a defensible post-launch narrative against a null setup.

### Fetch the results sources

| Source | Tool | Notes |
|---|---|---|
| Amplitude experiment config | `mcp__Amplitude__get_from_url` | Confirms run window, variants, metrics, exposure target |
| Amplitude notebook | `mcp__Amplitude__get_from_url` | Primary results narrative — authored by the analyst |
| Amplitude chart / dashboard | `mcp__Amplitude__get_from_url` | Pull specific metric reads when the notebook references them |
| Confluence analysis page | `mcp__atlassian__getConfluencePage` | PM-authored write-up, if any |
| Raw notes / Granola | Inline in user message or `mcp__granola__query_granola_meetings` | Lower-reliability source — flag anything not corroborated by Amplitude |

Log every external resource fetched to `knowledge-base-reference.md` per CLAUDE.md protocol (read → append → write → verify).

---

## Stage 2 — Validate Setup

Confirm the following are present and coherent before you write the narrative. If any check fails, ask the user:

| Check | Source | Failure mode |
|---|---|---|
| Hypothesis is falsifiable and tied to the primary metric | `customfield_{{CUSTOM_FIELD_ID}}` | Vague hypothesis ("improve engagement") cannot be confirmed/disconfirmed |
| Primary metric has direction + threshold | `customfield_{{CUSTOM_FIELD_ID}}` + `customfield_{{CUSTOM_FIELD_ID}}` | No threshold = no way to evaluate the result |
| Success Criteria lists explicit pass / inconclusive / fail states | `customfield_{{CUSTOM_FIELD_ID}}` | Binary pass/fail schema forces a launch decision that the data can't support |
| Guardrails are named and have clear degradation thresholds | `customfield_{{CUSTOM_FIELD_ID}}` | Launching against an unspecified guardrail = hidden risk |
| Run window ended | `customfield_{{CUSTOM_FIELD_ID}}` vs today | Writing a "final" report mid-run is a red flag — confirm explicitly |

---

## Stage 3 — Synthesise Observations

Build two separate lists:

- **Observations (data facts):** "Primary funnel moved +0.2%, p=0.47", "0.8% of exposed users created a list", "List creators converted 3.1 days slower on average". No interpretation.
- **Interpretations (theories):** "Self-selection bias explains the creator CVR uplift", "Discoverability is the bottleneck". Each labelled explicitly as a hypothesis.

This separation is enforced by the [CSO review checklist](../assets/cso-review-checklist.md) at Stage 4 and 6. Keeping them split from the start makes the review trivial.

---

## Stage 4 — Stress-test the decision (CRITICAL STAGE)

Run through the [CSO Review Checklist](../assets/cso-review-checklist.md) and also the following narrative-inconsistency probes. For every flag you find, write a one-line concern.

### Decision-vs-Success-Criteria coherence

- Does the documented Success Criteria have an explicit path for the observed outcome? (Pass / Inconclusive / Fail)
- If the decision is **Launch** and the primary metric did not cross the Pass threshold, is the Success Criteria's Inconclusive path documented and does the decision follow it?
- If the decision is **Rollback** and no guardrail was breached, what is the principled reason to kill the variant?

### Guardrail contradictions

- For every guardrail in `customfield_{{CUSTOM_FIELD_ID}}`, is there evidence it held or breached?
- If a guardrail moved directionally wrong but is not statistically significant, is the decision sensitive to the ship-stopper threshold?

### Self-selection / confounders

- If the narrative cites CVR uplift among a subset (e.g. "users who saw the feature converted at X%"), is there a baseline comparison against matched non-exposed users? If not, flag self-selection.
- If the segment CVR pattern pre-dates the experiment window, flag it as pre-existing behaviour, not a causal effect.

### Sample size / power

- Was the exposure target hit? If not, the null result may be under-powered — the decision should acknowledge this.
- Were any segments too small to read (e.g. iOS when there's a tracking gap)?

### Stakeholder exposure

- Legal / compliance — did the experiment touch data handling, consent, or a regulated surface?
- Finance — does the decision materially shift revenue or cost?
- CRM / marketing — does launching unblock or block a scheduled campaign?
- Engineering / tech debt — does the launched variant lock in architecture the team flagged as risky?

### Narrative consistency

- Does the Hypothesis field's "validated if" condition match the Launch decision? (E.g. Hypothesis said "validated if adoption ≥10%", observed 0.8% → decision is Launch; this is an inconsistency worth a line in the report, NOT a bug to hide.)
- Does the "why now" in the Context still hold? Was the experiment scheduled for a GTM window that has moved?
- Are follow-up experiments named in Next steps achievable on the teams that would own them?

### Present flags to the user

```
I found these flags in the launch/rollback narrative — please resolve before I publish:

1. [Flag name] — [one-line description]. Options: [a / b / c]. Your call?
2. ...
```

Do not resolve any of these yourself. Ask and wait.

---

## Stage 5 — Build the narrative

Use the [Post-launch Report Template](../assets/report-template.md) verbatim for structure. Key constraints:

- **Results section** — lead with a summary paragraph that states the decision and how the primary metric + guardrails landed relative to Success Criteria. Then the metric table. Then segmentation cuts. Then known measurement limitations.
- **Next steps** — bulleted. Each item has an owner, the hypothesis it tests, and the metric it targets.
- **Durable learnings** — prose, not bullets. What transfers to future experiments beyond this feature.
- **Voice** — follow the [Voice & Epistemic Honesty Guide](../../shared/voice-guide.md). Active voice. First person plural. No superlatives without data. Label interpretations as hypotheses.

Apply the CSO self-review pass before finalising (Stage 6).

---

## Stage 6 — CSO self-review

Before you output the narrative, read it back against the [CSO Review Checklist](../assets/cso-review-checklist.md) as if you are {{COMPANY}} Chief Science Officer. Rewrite any sentence that:

- States a hypothesis as fact.
- Uses "critical / key / sound / transformative" without data.
- Implies causation from correlation.
- Uses a concept not defined earlier in the report.

The final report must be defensible to a reader who was not in the experiment room.

---

## Stage 7 — Publish to Confluence

Follow [confluence-publishing.md](confluence-publishing.md). Key steps in order:

1. Identify the parent Epic from the experiment ticket (`parent.key`).
2. Look up the Confluence page(s) linked to that Epic — the PRD or initiative brief.
3. Search in {{TEAM}} space (key `ES`) for the initiative page. Confirm the target with the user before creating the child page.
4. Create the report as a child of the initiative page.
5. Title format: `[Experiment Results] <feature name> — <decision>` (e.g. `[Experiment Results] [example feature] MVP — Launch (Option B)`).
6. Log the URL in `knowledge-base-reference.md`.

---

## Stage 8 — Fulfil the Jira Experiment ticket

All textarea fields must be ADF objects — use the helper pattern at [../../experiment-creator/references/adf-helpers.md](../../experiment-creator/references/adf-helpers.md). Never pass markdown strings to these fields.

| Field | Jira ID | Type | Content |
|---|---|---|---|
| Results | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | Headline + metric table + segmentation cuts + guardrails + measurement limitations. Link to Confluence report. |
| Learnings | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | Durable learnings in bullet form. Each labelled interpretation vs observation. |
| Next steps | `customfield_{{CUSTOM_FIELD_ID}}` | ADF textarea | Decision statement + follow-up experiments + pre-requisites + why-not-alternatives. |
| Decision | `customfield_{{CUSTOM_FIELD_ID}}` | select | `Scale / Rollout` (id `12521`), `Kill` (id `12523`). Probe for Iterate / Hold via JQL if needed. |
| Results reviewed by analyst? | `customfield_{{CUSTOM_FIELD_ID}}` | select | `Yes` = `12689`, `No` = find via JQL. |
| Decision follows Success Criteria? | `customfield_{{CUSTOM_FIELD_ID}}` | select | `Yes` = `12691`. Set Yes only if the documented Success Criteria has a path for the observed outcome AND the decision follows it. |

### Transactional rollback warning

If any field in an `editJiraIssue` payload fails validation, Jira rolls back the ENTIRE edit. Send ADF textareas and select fields in separate calls, or verify every field individually after the call. If a call fails, treat all fields in that call as unsaved until re-confirmed.

---

## Stage 9 — Post-update summary

Return a compact checklist to the user:

```
Experiment closed: {{JIRA_PROJECT_KEY}}-XXXXX
├── Confluence report: [title] — [URL]
├── Jira fields populated:
│   ├── Results ✓
│   ├── Learnings ✓
│   ├── Next steps ✓
│   ├── Decision: <Scale / Rollout | Kill | ...>
│   ├── Results reviewed: Yes
│   └── Decision follows Success Criteria: <Yes | No (with reason)>
├── Flags resolved by user: <N>
├── Flags still open: <N — listed below>
└── Manual next steps:
    - Transition ticket to Closed
    - Confirm Slack auto-post in #{{COMPANY_SLACK_PREFIX}}-experiments
    - Verify auto-generated page in Experimentation Learnings Repository
```
