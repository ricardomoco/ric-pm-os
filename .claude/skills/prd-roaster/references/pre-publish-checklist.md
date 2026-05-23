# Pre-Publish Roast Loop

This is the operational checklist for the roast — the thing you tick through after the 6 passes are done, before delivering the punch list. It is not a scoring rubric. It is a "did I miss anything obvious" final sweep.

Use this checklist after the 6 passes to:

1. Confirm coverage (no pass skipped, no easy attacks left behind)
2. Audit your own output for AI slop / weak quoting / generic critique
3. Decide what counts as priority "fix before publishing" vs. "fix later"

---

## A. Coverage audit (before delivering)

- [ ] **All 6 passes run.** Internal contradictions, fallacies, technical hallucinations, marketplace traps, marketplace and product-specific landmines, recurring blind spots.
- [ ] **Parent strategy doc was checked.** If the PRD has a parent vision/strategy, the roast cross-checks against it. If no parent was found, this is flagged as a gap in the output.
- [ ] **Prior PRDs by the same author were checked.** At least one Pass 6 citation if the author has prior work in `projects/`. If no prior work was found, flagged.
- [ ] **Specific quotes used everywhere.** No bullet says "the metric is hand-wavy" without quoting the metric.
- [ ] **TL;DR has 3 sharpest hits.** Not 1. Not 7. Three.
- [ ] **What to fix section is ordered by priority** and tied to specific roast bullets by number.

---

## B. Voice & epistemic honesty audit (your own output)

The roast is the one place in the workspace where adversarial tone is allowed. It is not an excuse for sloppy writing. Your output must comply with the [Voice & Epistemic Honesty Guide](../shared/voice-guide.md). Audit:

- [ ] **No AI slop.** Skip "It's worth noting that," "Importantly," "I should mention," "It's clear that." If the line works without the preamble, delete the preamble.
- [ ] **No emojis.** None. Not even one.
- [ ] **No hedge stacking.** "May potentially possibly" is one fewer commitment than the PRD has. If you're calling out the PRD's hedging, your own writing can't be the same.
- [ ] **No black-box superlatives.** Don't write "the most critical issue" without a stated rubric. Either rank the issues with a defended scoring (severity × likelihood × reach), or just say "issue 1, 2, 3" and let the order do the work.
- [ ] **Earned harshness.** A small problem is a small problem. Don't escalate to "fatal flaw" unless it actually is. Calibration matters — overstating one thing makes the rest read as theatre.
- [ ] **Don't roast the author.** "This PRD does X" — fine. "You always do X" — not fine. Even when calling recurring blind spots, attack the pattern in the document, not the person.
- [ ] **Active voice. Concrete nouns.** "Section X says Y" not "It is stated by section X that Y."
- [ ] **No manufactured drama.** "This will fail catastrophically" — only if backed by a specific failure mode. Otherwise: "This is likely to fail because [specific reason]."

---

## C. Specific-attack audit (your bullets)

For each bullet in the roast:

- [ ] **Specific quote or section reference** — the author can find what you're attacking
- [ ] **Specific defect named** — fallacy name, hallucination type, trap, landmine, or pattern
- [ ] **Specific consequence stated** — what breaks, what risk, what's missing
- [ ] **Not generic** — "this needs more validation" is not an attack. Replace it with: "Section X claims Y; the cited evidence is Z; what's needed is W."

If you can't pass these four for every bullet, prune the bullet. A short, sharp roast lands. A long, vague roast doesn't.

---

## D. Priority-of-fix audit

For the "What to fix before publishing" section:

- [ ] **Each fix tied to a roast bullet** by number — so the author can map fix → reasoning
- [ ] **Ordered by priority** — typically (1) parent-strategy contradictions, (2) legal/compliance gaps, (3) cross-tribe dependency phantoms, (4) technical hallucinations that would make engineering refinement impossible, (5) experiment design gaps, (6) voice / framing
- [ ] **Each fix is concrete** — not "improve assumptions section" but "rewrite Assumption A3 to split KYC and KYB into separate assumptions, each with its own backend-spike status"
- [ ] **3-7 fixes, not 15** — if more than 7, the author won't act on them. Pick the ones that move the most.

---

## E. "What to do separately" audit

Some roast outputs surface things the PRD shouldn't address but the author should. These belong in a separate section:

- [ ] Things that are out-of-scope but important (flag for follow-up)
- [ ] Things that need a different doc (architecture brief, vision update, separate PRD)
- [ ] Things that need a different team's roadmap commitment (cross-tribe asks)
- [ ] Things that need user research, not more PRD writing

Keep this list short. The "what to do separately" section is a decompression valve, not a wishlist.

---

## F. Context-of-use audit

Before delivering, check the user's context:

- **Are they about to publish?** Then prioritise blockers (legal, contradictions, missing evidence on primary metrics).
- **Are they iterating between drafts?** Then balance blockers with structural patterns to fix earlier.
- **Are they preparing to send to a specific reviewer (CPO, PL)?** Then surface what that reviewer is likely to attack first. Different reviewers stress different things — a CPO will attack metrics and strategic alignment; an EM will attack technical feasibility and dependencies; a Legal lead will attack regulated-content surfacing.

The output is the same shape; the priority ordering can shift.

---

## G. Output template — final sanity check

Compare your output to the canonical structure in `SKILL.md`:

```
# PRD Roast — [Initiative Name]
**Source:** [link]
**Parent strategy checked:** [link or "none"]
**Prior PRDs reviewed:** [list or "none"]

## TL;DR — three biggest problems
[3 lines]

## 1. Internal contradictions
## 2. Fallacies and rhetorical sleight of hand
## 3. Technical hallucinations
## 4. Industry / marketplace traps walked into
## 5. {{COMPANY}}-specific landmines
## 6. Your recurring blind spots — pattern check
## 7. What's missing entirely
## 8. Voice & epistemic honesty

## What to fix before publishing
[3-7 ordered fixes]

## What to do separately, not in this PRD
[short list, optional]
```

- [ ] All sections present (or explicitly marked "no observations" — never silently dropped)
- [ ] No section padded with filler — if Pass 1 found no contradictions, write "none observed" and move on
- [ ] No section overstuffed — if Pass 4 found 12 marketplace traps, ship the 2-3 most consequential and put the rest in "What to do separately"

---

## H. Self-deprecation check

Before delivering:

- [ ] If the PRD was authored partially by you (the assistant) in this same conversation, **flag it explicitly**. A roast of your own writing is unreliable. Tell the user.
- [ ] If the PRD is too thin or too early-stage to roast meaningfully, **say so** instead of manufacturing critique. "This is a one-page brief, not a PRD — here are the 2-3 things that would even make it roastable."
- [ ] If the PRD has nothing major to attack, **say so plainly**. Don't pad. The author has other tools for balance.

---

## I. Final delivery

Deliver the roast in one Markdown block. No preamble like "I've reviewed the PRD..." — open with the TL;DR. Close with "What to fix before publishing." Do not append "Hope this helps" or "Let me know if you want me to..." style sign-offs — those violate the voice guide.

After delivering, offer one follow-up:

- "Want me to apply the top 3 fixes directly?" — only if the PRD is editable from this session.
- Otherwise: nothing. The roast is the deliverable.
