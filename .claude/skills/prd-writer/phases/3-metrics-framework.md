# Phase 3: Metrics Framework

Define primary, secondary, guardrail, and diagnostic metrics. Reference [references/metrics.md](../references/metrics.md) for STEDII criteria. **STEDII is an internal evaluation framework: never write the word "STEDII" into PRD output (not as a column header, not in prose). Apply the criteria mentally; reflect them in metric design in plain language.**

## First check: is this an experiment or a one-shot launch?

Before defining metrics, classify the PRD:

- **Experiment-driven (A/B test, dial-up, cohort comparison):** continue with the full framework below — primary metric with **MDE**, guardrails, **graduation criteria** for dial-up.
- **One-shot launch (backend migration, infrastructure, regulated launch that must ship 100% on day one, tech debt):** skip MDE and Graduation Criteria. Use the **Non-experiment branch** at the bottom of this phase instead.

If unsure, ask the PM: "Is this going to ship via A/B test with a dial-up plan, or as a one-shot launch where we either ship to 100% or roll back?"

When you receive an initiative description (PRD), you will define a complete metrics framework consisting of:
- **Primary Metric(s)**: The key metric(s) that determine experiment success — typically one metric, but can be 2-3 if the initiative has multiple equally important goals
- **Secondary Metrics**: Driver metrics that indicate progress toward business goals
- **Guardrail Metrics**: Trip-wire metrics that prevent shipping harmful changes even if primary metrics improve
- **Diagnostic Metrics**: Instrumentation to understand *why* metrics move and debug unexpected behavior

Every primary metric must include a **Minimum Detectable Effect (MDE)** and the framework must include explicit **Graduation Criteria**.

## Specificity over vagueness — two transformations

The most common metric failure is metric theater: stated targets that don't commit to detectability. Force the writer to escape:

**Bad — vague target:**
> "Improve user engagement on the IDP."

**Good — specific, detectable:**
> "P50 IDP CVR (Item View → Purchase Intention) increases ≥1% absolute (from baseline 30.5% to ≥31.5%) over 14 days at 80% power, p<0.05."

**Bad — direction without magnitude:**
> "Reduce support tickets."

**Good — committed to magnitude with window:**
> "Returns-related support tickets decrease 15-20% (from 18% to 14.4-14.8%) measured over the 30-day post-implementation window."

If the writer can't compute the second form, they don't have a metric — they have a wish. Push back.

### Step 1: Analyze the Initiative Context

Before defining any metrics, carefully review the initiative context provided in the PRD. Use a `<scratchpad>` section to think through:

1. **What is the core user problem being solved?**
   - What pain point or need does this address?
   - What user behavior is expected to change?

2. **What is the primary business goal?**
   - Revenue? Retention? Engagement? Growth?
   - What long-term outcome does this drive toward?

3. **What user actions define success?**
   - What do users need to *do* for this to be successful?
   - What is the happy path user journey?

4. **What are the potential risks or downsides?**
   - Could this improve one metric but harm another?
   - Are there edge cases or segments that might be negatively affected?

5. **What timeframe is realistic for measurement?**
   - Can we see results in days, weeks, or months?
   - Do we need proxy metrics for long-term outcomes?

### Step 2: Define the Primary Metric(s)

The primary metric is your "north star" — the key decision-making criterion for whether to ship this change. You should aim for **one primary metric** when possible. A good primary metric must pass the **STEDII** framework (Sensitivity, Trustworthiness, Efficiency, Debuggability, Interpretability, Inclusivity) — apply mentally, do not write the framework name into the PRD.

**Required output format for every primary metric:**

| Metric | Baseline | Target | MDE | Window |
| :--- | :--- | :--- | :--- | :--- |
| [Definition] | [Current value, source] | [Goal with %] | [Minimum detectable effect at 80% power, p<0.05] | [Days needed at current traffic] |

**MDE rules:**
- The MDE is the smallest effect size the experiment can detect, not the target.
- If the MDE is larger than the target, the experiment cannot detect the effect — fix duration, sample, or the metric.
- For {{COMPANY}}-scale CVR experiments, ~1% absolute MDE typically requires multi-week duration; high-variance metrics like AOV need longer.
- If the writer hasn't done the power analysis, that's a P0 gap to flag before publishing the PRD.

### Step 3: Define Secondary Metrics

Secondary metrics help you understand the **drivers** of your primary metric(s) and validate that you're moving **broader business outcomes** in the right direction. Use HEART or AARRR frameworks where appropriate.

### Step 4: Define Guardrail Metrics

Guardrail metrics are "trip-wires" that prevent you from shipping harmful changes even if the primary metric(s) improve. Protect against quality degradation, negative externalities, or business assumption violations.

**Required output format:**

| Metric | Current | Acceptable Range | Alert Threshold |
| :--- | :--- | :--- | :--- |
| [Metric] | [Baseline] | [Min–Max] | [When to alarm] |

### Step 5: Define Diagnostic Metrics

Diagnostic metrics help you understand **why** your primary and secondary metrics moved. They are crucial for debugging, understanding mechanisms of action, and identifying iteration opportunities.

### Step 6: Define Graduation Criteria

Graduation Criteria answer: **when do we scale to 100%?** They are not the same as the primary metric target — they are the full set of conditions that must hold before dial-up. Required for every PRD.

**Required output format:**

```markdown
## 🎓 Graduation Criteria

When do we scale to 100%? Be explicit:

- [ ] Primary metric hits target at p<0.05
- [ ] No guardrail violations for [N] consecutive days
- [ ] [Stakeholder] approval (e.g. Finance on cost, Legal on copy)
- [ ] [Other gate]
```

If the writer can't list 3+ specific graduation conditions, the experiment design isn't ready.

### Step 7: Leverage Knowledge Resources

Leverage available context from the workspace:
- Check `projects/` for any existing metrics frameworks, experiment results, or analytics documentation relevant to the initiative.
- Check `{{KNOWLEDGE_BASE_PATH}}/` for strategic context and domain-specific background.
- Read [jira-config/jira-team-catalog.md](../../../jira-config/jira-team-catalog.md) if you need to map metrics to specific teams or components.

### Step 8: Format Your Final Output

Your complete metrics framework should be delivered in this structure:

# Success Metrics Framework: [Initiative Name]

## Initiative Summary
## Scratchpad: Analysis
<scratchpad>
...
</scratchpad>
---
## Primary Metric(s)
[Table with Metric / Baseline / Target / MDE / Window]
## Secondary Metrics
### Business Outcome Metrics
### Engagement & Adoption Metrics
---
## Guardrail Metrics
[Table with Metric / Current / Acceptable Range / Alert Threshold]
---
## Diagnostic Metrics
### Funnel Metrics
### Technical Performance Metrics
### Segment Breakdowns
---
## Graduation Criteria
[Explicit checklist]
## Analytics Instrumentation Requirements
## Experiment Configuration Recommendations
## Decision Rubric
## Appendix: Metrics from Past Experiments

## Non-experiment branch — for one-shot launches

When the PRD ships at 100% on day one (backend migration, infrastructure, regulated launch, tech debt), MDE and Graduation Criteria don't apply. Replace them with:

### Pre-launch validation criteria

What must be true in staging / QA / load test before production traffic flows. Required format:

| Validation | Test environment | Pass threshold |
| :--- | :--- | :--- |
| [E.g. P95 latency under 5x prod load] | [Staging / shadow traffic] | [<200ms over 1-hour test] |
| [E.g. Migration completes without data loss] | [Staging full-data dry-run] | [100% record parity] |

### Post-launch monitoring metrics

What dashboards / alerts will run in production once live. Required format:

| Metric | Where it's measured | Alert threshold | Owner |
| :--- | :--- | :--- | :--- |
| [Metric] | [Dashboard / source] | [When to page] | [Role] |

### Decision rule

When do we declare success? When do we rollback (if possible) or hotfix-forward? Make explicit:

- **Success:** [E.g. "All pre-launch validations passed AND no P0 alerts within 72h of launch"]
- **Rollback path:** [If reversible: "Feature-flag off." If not reversible: "Hotfix-forward only — name the on-call who owns the next release window."]
- **Iterate criteria:** [E.g. "If P95 latency >300ms after 24h, ship optimisation in next sprint"]

For non-experiment PRDs, Phase 7 (GTM) also takes its non-experiment branch — Phased Deployment + Rollback Plan instead of Phased Rollout + Ramp Gates.

Here is the PRD to analyze:
<prd>
{{args}}
</prd>
