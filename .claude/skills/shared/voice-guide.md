# Voice & Epistemic Honesty Guide

Rules that govern tone, confidence calibration, and intellectual honesty across ALL written output — PRDs, vision docs, Jira tickets, Confluence pages, Slack messages, research summaries.

These rules exist to prevent "AI slop": prose that sounds authoritative but smuggles in unverified claims, manufactured drama, or black-box assertions.

---

## Rules

### 1. Earned Confidence

The strength of an assertion must match the strength of its evidence.

| Evidence level | Appropriate voice |
|---|---|
| Hard data (metrics, analytics, A/B results) | Definitive: "Pogo-sticking accounts for 38% of session exits." |
| Qualitative research (user interviews, usability tests) | Grounded: "In 8 of 12 interviews, buyers described returning to the grid multiple times before committing." |
| Informed judgment (pattern recognition, PM conviction) | Signaled: "Based on [X], we believe..." or "Our hypothesis is..." |
| No evidence | Flagged: `[TBD — needs data]` or `[assumption — not yet validated]` |

Never present a judgment call as an established fact. Conviction is expected in PM writing — hiding the fact that it's conviction is not.

### 2. No Black-Box Superlatives

Never write "the single biggest," "the most critical," "the primary driver," or any ranking claim without a cited source.

**Bad:** "Pogo-sticking is the single biggest source of evaluation friction in the buyer journey."
**Better:** "Pogo-sticking is a major source of evaluation friction — [X]% of buyers exit after visiting 3+ item detail pages without converting `[source: Amplitude cohort, Q1 2026]`."
**Also acceptable:** "We believe pogo-sticking is the largest friction point, based on [session data / research finding]. This needs validation."

If you don't have the ranking data, either:
- Drop the superlative and use "a major" / "a significant"
- Mark it: `[assumed — needs ranking data]`

### 3. Separate Observation from Interpretation

Describe observable behavior first. State the interpretation separately. Never fuse them into one authoritative sentence.

**Bad:** "This is the 'pogo-stick loop,' and it is the single biggest source of evaluation friction in the buyer journey."
**Good:** "Buyers tap into a listing, scroll, decide it's not right, return to the grid, and repeat — often for dozens of items. We call this the 'pogo-stick loop.' If our hypothesis is correct that this loop drives the majority of evaluation drop-off, reducing it becomes the highest-leverage intervention."

The separation makes the reasoning auditable. A reader can agree with the observation but challenge the interpretation.

### 4. No Manufactured Drama

The emotional weight of a problem statement must come from real data or real user quotes — not from rhetorical escalation.

**Signals you're manufacturing drama:**
- Stacking adjectives to inflate severity ("frustrating, time-consuming, and fundamentally broken")
- Using catastrophic framing without data ("buyers are abandoning {{COMPANY}} because of this")
- Describing a user journey in exhausting detail to make it *sound* painful rather than *proving* it's painful
- Inventing a narrative arc where the data only supports a data point

**What to do instead:** Let the data carry the weight. "62% of sessions include 4+ pogo-sticks before a buyer messages a seller" is more compelling than three paragraphs of dramatized friction.

### 5. Show Your Reasoning

When making a judgment call — which is expected and necessary in vision docs, PRDs, and strategy work — signal it explicitly.

**Patterns to use:**
- "Based on [X research / data], we believe..."
- "Our hypothesis is..."
- "The evidence suggests... though we haven't validated [Y]"
- "This is a conviction bet — the data is directional, not conclusive"

**Patterns to avoid:**
- Declarative statements with no attribution: "This is the core problem."
- Passive authority: "It is widely understood that..." / "It is clear that..."
- Smuggled assumptions: Burying an unverified claim inside a factual sentence

---

## How This Relates to Other Writing Rules

These rules complement — not replace — the Writing Standards in CLAUDE.md:

- **"No Weasel Words"** still applies: avoid vague hedging ("might," "some," "possibly") that weakens writing without adding honesty. The alternative to weasel words is **precise confidence calibration**, not **assertive overconfidence**. Say exactly how confident you are and why — don't hedge vaguely, and don't overclaim.
- **"Strong Verbs"** still applies: direct, active prose is compatible with intellectual honesty.
- **"BLUF"** still applies: lead with the key insight, but make sure it's an honest one.

---

## Quick Self-Check Before Finalizing Any Document

1. Can every superlative ("biggest," "most," "primary") be traced to a data source?
2. Are observations and interpretations clearly separated?
3. Would a skeptical stakeholder accept the confidence level, or would they ask "where's the data for that?"
4. Does the emotional tone match the evidence, or has rhetoric been used to inflate it?
5. Are judgment calls signaled as such?

If any answer is "no," revise before delivering.
