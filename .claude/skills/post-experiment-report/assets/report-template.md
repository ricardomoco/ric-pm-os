# Post-Launch Report Template

Preserves the structure of the retired `experiment:results-generator` command. Use for both the Confluence page body and (with minor ADF conversion) the Jira Results / Learnings / Next steps textareas.

## Inputs you need filled in before writing

| Placeholder | Source |
|---|---|
| `{EXPERIMENT_OVERVIEW}` | `customfield_{{CUSTOM_FIELD_ID}}` (Context) on the Jira ticket |
| `{HYPOTHESIS}` | `customfield_{{CUSTOM_FIELD_ID}}` (Hypothesis) |
| `{TREATMENTS}` | `customfield_{{CUSTOM_FIELD_ID}}` (Experiment Additional Information → Control + Variant A) |
| `{DURATION_DAYS}` | computed from `customfield_{{CUSTOM_FIELD_ID}}` → `customfield_{{CUSTOM_FIELD_ID}}` |
| `{START_DATE}` | `customfield_{{CUSTOM_FIELD_ID}}` (Exp Start) |
| `{END_DATE}` | `customfield_{{CUSTOM_FIELD_ID}}` (Exp End) |
| `{LAUNCH_DECISION}` | user input (Launch / Rollback / Iterate / Hold) + variant reference |
| `{LAUNCH_CRITERIA_PRE_EXPERIMENT}` | `customfield_{{CUSTOM_FIELD_ID}}` (Success Criteria) |
| `{LAUNCH_CRITERIA_IMPACT}` | observed read of the primary metric vs Success Criteria |
| `{GUARDRAIL_METRICS_SUMMARY}` | observed read of every guardrail in `customfield_{{CUSTOM_FIELD_ID}}` |
| `{ADDITIONAL_EFFECTS_SUMMARY}` | observed movement on secondary metrics that were not part of the Pass condition |
| `{PROPOSED_NEXT_STEPS}` | user input + notebook suggestions |
| `{DURABLE_LEARNINGS_CONTENT}` | synthesised from Stage 3 observations and Stage 6 interpretations |

If a required input is missing (`{EXPERIMENT_OVERVIEW}`, `{HYPOTHESIS}`, `{LAUNCH_DECISION}`, `{LAUNCH_CRITERIA_PRE_EXPERIMENT}`, `{LAUNCH_CRITERIA_IMPACT}`, `{GUARDRAIL_METRICS_SUMMARY}`), stop and ask. Do not invent.

---

## Structure (Markdown — convert to Confluence ADF on publish)

```markdown
# Results

After running the experiment for {DURATION_DAYS} days ({START_DATE} through {END_DATE}), we have decided {LAUNCH_DECISION}. {Enumerate each treatment and what it changed vs. control, referring to TREATMENTS.}

{Compare LAUNCH_CRITERIA_PRE_EXPERIMENT with LAUNCH_CRITERIA_IMPACT and LAUNCH_DECISION. State explicitly whether the decision aligns with the pre-experiment criteria or follows a documented Inconclusive path.}

{Based on HYPOTHESIS and LAUNCH_CRITERIA_IMPACT, explain how the experiment confirmed or disconfirmed the hypothesis. If the decision is to launch despite a null primary metric, explain the principled reason (e.g. bounded guardrail risk + discoverability bottleneck).}

{Summarise GUARDRAIL_METRICS_SUMMARY. State "all guardrails were met" or name each guardrail that moved and by how much.}

## Additional effects

{If ADDITIONAL_EFFECTS_SUMMARY is non-empty, list the notable effects. Example:}

- Transaction accepted frequency +1.68%
- Search to intermediated transaction accepted +0.63%

{If none, write: "No other significant effects were observed."}

## Known measurement limitations

{From Stage 2–3 validation. E.g. "iOS event coverage gaps prevented a full cross-platform read of the section-to-creation funnel". Always include a line if any limitation exists — readers judge the decision's confidence by this section.}

# Next steps

{Use PROPOSED_NEXT_STEPS as a bulleted list. Each item should have an owner, the hypothesis it tests, and the metric it targets. Example:}

- **Discoverability: snackbar + deep-link on first Favorite** — tests whether a contextual nudge at the "Favorite created" moment increases section entry (metric: section_view rate).
- **IA change: Tab order** — tests whether re-ordering navigation tabs shifts adoption without harming the discovery surface (metric: tab adoption rate, guardrail: PDP CVR).
- **PMF qualitative deep-dive** — UR round targeting exposed non-adopters + creators to disambiguate "didn't find it" from "didn't want it".

# Durable learnings

{Prose, not bullets. Use DURABLE_LEARNINGS_CONTENT. Highlight insights, unexpected findings, and new learning opportunities beyond the immediate hypothesis. Label interpretations as hypotheses. Example:}

We hypothesise that the feature is acting as a consideration / shortlisting surface rather than a purchase trigger — adopters converted more slowly than non-adopters, which fits a shortlisting use case and implies the feature's value should show up in downstream metrics on a longer horizon than a 5-week A/B can catch. Separately, the 6x gap between exposed adoption and exposed-and-saw adoption suggests discoverability is the bottleneck, not the feature's value — this framing should shape the next experiment's lever choice.

# Report metadata

| Field | Value |
|---|---|
| Experiment ticket | [Jira link] |
| Analyst | [name] |
| Report author | [PM name] |
| Decision | {LAUNCH_DECISION} |
| Source data | [Amplitude notebook / dashboard links] |
| Date published | YYYY-MM-DD |
```

---

## Voice rules (apply to every paragraph)

- Active voice. First person plural ("we launched", "we observed", "we hypothesise").
- Separate observation from interpretation — interpretations get `We hypothesise that...` or `This suggests...`, not bare causal claims.
- No superlatives without data. "Transformative" / "breakthrough" are banned unless the metric movement literally supports them.
- Scope every claim to the data. "The model maintains data quality for the tested attributes under these conditions" — not "The model is sound".
- Define every non-obvious concept on first use.

## Confluence page title format

`[Experiment Results] <feature name> — <decision>`

Examples:
- `[Experiment Results] [example feature] MVP — Launch (Option B)`
- `[Experiment Results] Similar Items IDP Slider — Launch`
- `[Experiment Results] Reserved-items hiding in search — Rollback`
