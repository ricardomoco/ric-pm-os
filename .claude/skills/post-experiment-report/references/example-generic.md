# Quick Filter on PDP: Post-Experiment Report

> **Status:** Launched  
> **Decision date:** 2026-04-30  
> **Experiment ticket:** [{{JIRA_PROJECT_KEY}}-NNN]({{ATLASSIAN_BASE_URL}}/browse/{{JIRA_PROJECT_KEY}}-NNN)  
> **Amplitude dashboard:** [Quick Filter experiment](https://app.amplitude.com/{{AMPLITUDE_ORG}}/dashboard/example)

This is a synthetic example post-experiment report used as a structural reference by the `post-experiment-report` skill. It demonstrates the shape, voice, and discipline the skill enforces — not a real result.

---

## Results

We tested a Quick Filter chip row on the product detail page (PDP) that surfaces the three most-selected attribute filters for items in the buyer's current category. Baseline used the existing inline filter list (a vertical list of 12+ attributes). Variant A replaced the list with three horizontally-scrolling chips, plus a "More" button that expanded the legacy view.

After 21 days (2026-04-09 through 2026-04-29) we have decided to roll out Variant A. The decision unblocks the Phase 2 capability in the [example feature] vision (per-category default chip selection) which was gated on this rollout.

We met our primary metric: PDP-to-add-to-cart rose +3.2% (8.4% in Variant vs 8.14% in Baseline, p=0.012, MDE was +2.5%). Our two guardrails held: PDP-to-bounce moved -0.4pp (not significant) and time-on-PDP dropped -1.8s median (expected from the more compact UI). The hypothesis that surfacing the most-likely-used filters would shorten the path from PDP to purchase was confirmed.

A secondary signal flagged for follow-up: chip-tap rate was 24% in Variant A — high, but the "More" button click-through was 18%, suggesting one of the three chips is the wrong default for a meaningful slice of users. We will instrument per-category chip-tap distribution in the first week of rollout.

---

## Next steps

- Roll out to 100% over 7 days, starting with the lowest-volume categories to bound risk.
- Add per-category chip-tap instrumentation before week 2 (owner: [Data Analyst]).
- Open a Phase 2 ticket for ML-driven default chip selection per category, dependent on 4 weeks of post-rollout data.
- Update the PDP design system documentation to reflect the chip pattern as the canonical filter surface.

## What we'd do differently

- We ran this experiment with the global default of three chips. In hindsight, an arm with two chips and an arm with four would have given us the convexity data for the Phase 2 ML default-selection work without an extra experiment cycle.
- The MDE we set (+2.5%) was tight given our traffic. A wider MDE would have allowed an earlier read.

---

## Why this example exists

This is the structural reference the `post-experiment-report` skill aims for:

1. **Status, dates, links in the front matter** — a reader can click into the source ticket, dashboard, and the underlying analysis without scrolling.
2. **One-paragraph results block** — what we tested, what we decided, why.
3. **Earned-confidence prose** — every metric is quoted with its delta, its baseline, its significance.
4. **Hypothesis status named** — "confirmed" / "not confirmed" / "partially confirmed", not buried.
5. **Secondary signals not buried** — anything that warrants follow-up is named with an owner.
6. **Next steps are concrete and dated** — not "we should look at this".
7. **"What we'd do differently" closes the loop** — explicit lessons, not generic platitudes.
