# Assumptions and Risk Classification

## Risk Classification Logic

When documenting assumptions, classify them by risk level to prioritize validation efforts.

| Category | Definition | Action |
| :--- | :--- | :--- |
| **Risky** | Low evidence + High importance, OR Low evidence + Medium importance with significant downside. | **High priority for validation.** Must be addressed before major development. |
| **Non-Risky** | High evidence regardless of importance, OR Low importance + Low evidence. | **Monitor.** No immediate validation required. |

## Assumption Types

Consider assumptions across these categories:

- **Desirability**: Do users want this? Does it solve a real problem?
- **Viability**: Does this work for the business? Is it sustainable?
- **Feasibility**: Can we build this? (Technical, platform, legal constraints)
- **Usability**: Can users figure out how to use it?
- **Ethical**: Does this have any negative impact on society, bias, or safety?

## Risk Matrix — required output format for the §Risks section

When populating the Risks section of the PRD, use a matrix that includes a **Detection** column. Risks without detection are decoration — they don't tell the team how to know the risk has materialised.

**Required format (one matrix per risk category — User / Platform & Legal / Business):**

| Risk | Likelihood | Impact | Detection | Mitigation |
| :--- | :--- | :--- | :--- | :--- |
| [Specific risk] | L/M/H | L/M/H | [Metric / threshold / signal that flags it] | [Concrete action when detected] |

The Detection column is the discipline. Examples of acceptable detection signals:

- "User feedback <3.0/5.0 OR adoption <15% over 7 days"
- "P95 latency >500ms for 3 consecutive minutes"
- "False positive rate >3% over 24 hours"
- "Customer support ticket volume rises >20% week-over-week"

Vague entries like "monitor and adjust" or "be ready to roll back" are not detection — they're hopes. Push back.

## Specificity test

**Bad — risk without detection:**
> "Suggestions might be irrelevant. Mitigation: monitor and iterate."

**Good — risk with detection trigger and committed action:**
> "Risk: irrelevant AI suggestions degrade trust. Likelihood: M. Impact: H. Detection: user feedback <3.0/5.0 OR suggestion adoption <15% over 7 days. Mitigation: kill switch + model retrain queued at next sprint boundary."

## Relationship to `/assumption-identifier` skill

The `/assumption-identifier` skill produces a deeper, journey-mapped, 15-25-item assumption inventory using Teresa Torres' methodology. Use it for stress-testing a draft.

The §Assumptions section of the PRD itself can be lighter — typically the 5-10 most material assumptions, each with the Type / Importance / Evidence / Risk fields. If the PRD's Assumptions section needs more rigor, route to `/assumption-identifier`.
