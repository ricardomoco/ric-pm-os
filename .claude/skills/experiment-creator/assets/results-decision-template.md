# Results & Decision Template

Use this in the Experiment ticket description (below the existing Setup content) after the experiment closes. Keep the Setup-phase narrative in the structured custom fields; this template lives in the description because there is no dedicated Results custom field on the {{COMPANY}} Experiment issue type.

```markdown
---

## Results

### Headline
[One-paragraph summary: did the primary metric move? Did any guardrail breach? What is the one thing a reader should take away?]

### Metric summary
| Metric | Type | Direction | Result | Significant? |
| --- | --- | --- | --- | --- |
| [primary] | Primary | larger-is-better | +/−X% | Yes / No |
| [guardrail 1] | Guardrail | smaller-is-worse | +/−X% | Yes / No |
| ... | | | | |

### Segmentation cuts
[Key cuts that explain the headline — e.g. by platform, by exposure depth, by cohort. Include only cuts that materially change the interpretation, not every breakdown run.]

### Behaviour of [treatment users / converters]
[Qualitative or derived observations — e.g. self-selection bias, time-to-convert differences, interaction patterns. Label anything that could be confounded.]

### Known measurement limitations
[Event-tracking gaps, iOS/Android parity issues, late exposures, lag, under-powered cuts. Be explicit so the decision isn't read as stronger than the data supports.]

---

## Decision: [Launch / Kill / Iterate / Hold]

[Two-sentence statement of the decision and what it means operationally.]

### Option evaluation

| Option | Description | Chosen? | Why / why not |
| --- | --- | --- | --- |
| A — [name] | [short description] | No | [reason] |
| B — [name] | [short description] | **Yes** | [reason] |
| C — [name] | [short description] | No | [reason] |

### Justification
1. [Risk assessment — business, guardrail, brand.]
2. [What the data supports — positively and as a null.]
3. [What launching unblocks — downstream work, CRM, other teams.]
4. [Who benefits today, even if marketplace-level lift is zero.]
5. [Post-decision monitoring / safety net.]

### Follow-up experiments chained from this decision
1. [Next test — hypothesis + lever + which metric it targets.]
2. [Next test.]
3. [Qualitative work — UR round, PMF deep-dive, etc.]

---

## Post-run status

- Status transition: [Ready to Launch → Launched / Closed with resolution]
- Results notebook: [link]
- Confluence summary (auto-generated on close): [link or TBD]
- Slack announcement (auto-posted on close): [channel + link or TBD]
```

## Guidance

- **No manufactured drama.** A null result is a valid finding. Write it as one.
- **No black-box superlatives.** "Transformative" / "breakthrough" without data behind it are banned per the Voice & Epistemic Honesty Guide.
- **Show which options you rejected and why.** Future readers should be able to reconstruct the decision without a meeting.
- **Separate observation from interpretation.** "List creators converted more slowly" is an observation. "Saved Items act as a consideration tool" is an interpretation — label it as such.
- **Be explicit about self-selection / confounders.** If a segment shows lift but the same pattern pre-dates the experiment, flag it.
