# Metrics Framework

## STEDII Criteria (internal-only — never write "STEDII" into PRD output)

STEDII is the internal mental framework the agent applies when evaluating metric quality. **The literal word "STEDII" must not appear in any generated PRD** — not as a column header, not in prose, not in metric definitions. Apply the criteria mentally; the PRD reflects the resulting metric design (sensitivity, trustworthiness, efficiency, etc.) in plain language without naming the framework.

When defining metrics, they must meet the STEDII criteria:

- **Sensitivity**: Can detect 2-5% changes.
- **Trustworthiness**: Moves in the right direction for good changes.
- **Efficiency**: Measurable within 1-2 weeks.
- **Debuggability**: We can understand why it moves.
- **Interpretability**: The team can easily understand it.
- **Inclusivity**: Represents all users equally.

## 4-Tier Metrics Framework

Every PRD should define metrics across these four categories:

1. **Primary Metric(s)**: The main decision-making criterion. What is the single most important number this project aims to move?
2. **Secondary Metrics**: Driver metrics for business outcomes. These help tell the story of *how* we're achieving the primary goal.
3. **Guardrail Metrics**: Trip-wires preventing harmful changes. These ensure we aren't "robbing Peter to pay Paul" (e.g., increasing conversion at the cost of retention).
4. **Diagnostic Metrics**: Used for understanding movements and user behavior at a more granular level.

## MDE — Minimum Detectable Effect (required for primary metrics)

STEDII tells you whether the metric is *good*. MDE tells you whether the experiment can *detect* the effect you care about.

Every primary metric must commit to:

| Metric | Baseline | Target | MDE | Window |
| :--- | :--- | :--- | :--- | :--- |
| [Definition] | [Current value] | [Target with %] | [Min effect detectable at 80% power, p<0.05] | [Days needed at current traffic] |

**Rules:**

- The MDE is the smallest effect size the experiment can detect, not the target.
- If the MDE is larger than the target, the experiment cannot detect the effect — fix duration, sample, or change the metric.
- For {{COMPANY}}-scale CVR experiments, ~1% absolute MDE typically requires multi-week duration; high-variance metrics like AOV need longer.
- If no power analysis exists, that's a P0 gap to flag before publishing the PRD.

## Graduation Criteria (required)

Targets define what "good" looks like. Graduation Criteria define when "good enough to scale to 100%."

Required format:

```markdown
## Graduation Criteria

When do we scale to 100%? Be explicit:

- [ ] Primary metric hits target at p<0.05
- [ ] No guardrail violations for [N] consecutive days
- [ ] [Stakeholder] approval (e.g. Finance on cost, Legal on copy)
- [ ] [Other gate]
```

If the writer can't list 3+ specific graduation conditions, the experiment design isn't ready.

## Non-experiment PRDs

Some PRDs aren't experiments — backend migrations, infrastructure work, tech debt, one-shot launches with no rollback option, regulated launches that must ship 100% on day one.

For these, replace MDE + Graduation Criteria with:

- **Pre-launch validation criteria** — what must be true in staging / QA / load test before production traffic
- **Post-launch monitoring metrics** — what dashboards / alerts will run in production
- **Decision rule** — when do we declare success / rollback (often not possible) / iterate

The skill should ask "is this an A/B test or a one-shot launch?" before requiring MDE.
