---
name: prd-roaster
description: Adversarially critique a PRD before it ships — challenge every assumption that doesn't hold up, expose logical fallacies, flag technical hallucinations, surface industry and product-specific landmines the author missed, and audit against the author's recurring blind spots. Use when the user says "roast this", "tear this apart", "stress-test before I publish", "what am I missing", "what would my toughest reviewer attack", "is this ready to ship", or hands over a PRD draft and asks for honest critique. Distinct from `assumption-identifier`, which produces a structured constructive inventory — this skill is offensive, not analytical.
---

# PRD Roaster

Attack the PRD on every front before someone else does.

This is not a structured assumption inventory (use `assumption-identifier` for that — see Routing below). This is an **adversarial critique** that names specific weaknesses, with line-level citations, in the tone of a senior PM who has seen this fail before. The output is a punch list, not a table.

## When to delegate vs. execute inline

**Inline execution (this skill in main context):** Short PRDs (<300 lines) pasted inline or read from a local file. The roast happens in your main thread.

**Delegate to `prd-roaster-runner` subagent:** Long PRDs (>300 lines), Confluence-hosted PRDs you'd need to fetch, or any case where the PRD body would meaningfully bloat main context. The subagent loads this same skill via its `skills: prd-roaster` frontmatter, runs all 6 passes in its own context, and returns only the punch list. Triggers verbatim quotes back to main context — but not the PRD itself.

## When to use vs. when not to

**Use this skill when:**
- The user hands over a PRD draft and says "roast this", "tear this apart", "stress-test it", "what am I missing"
- The user is preparing to publish or send the PRD up the chain (CPO, PL) and wants a hostile read first
- The user is doing a final pre-publish quality check
- The user is between drafts and wants to know what to fix before the next iteration
- The user explicitly asks for adversarial / contrarian / devil's-advocate critique

**Do NOT use this skill when:**
- The user wants to draft a PRD from scratch → route to `prd-writer`
- The user wants a structured assumption inventory → route to `assumption-identifier`
- The user wants to design a test for a known assumption → route to `experiment-creator` or `ur-survey-creator`
- The user wants you to *fix* the PRD, not critique it. Roasting names problems; fixing solves them. Don't blur the modes — ask which they want first if unclear.

## Routing relationship to other skills

| Skill | Mode | Output | When to use |
|---|---|---|---|
| `prd-writer` (Phase 4) | Constructive, while drafting | Inline assumptions/risks section | During PRD authoring |
| `assumption-identifier` | Constructive analysis | 15-25 row assumption table, journey-mapped | After draft, to plan validation |
| **`prd-roaster`** | **Adversarial critique** | **Punch list of attacks** | **Pre-publish, contrarian read** |

If during the roast you discover the PRD lacks any structured assumption analysis at all, **don't substitute by listing assumptions yourself** — flag it as a gap and recommend the user runs `assumption-identifier`. The roast names the absence; it doesn't fill it.

---

## Inputs you need

Before producing output, confirm you have:

1. **The PRD.** File path, Confluence URL, or pasted text. If a Confluence URL, fetch via `mcp__atlassian__getConfluencePage` and log to `knowledge-base-reference.md` per workspace policy.
2. **Parent strategy or vision document(s).** A roast that doesn't check the PRD against its own parent strategy is incomplete — much of the worst scope creep happens when the PRD silently overrides the vision. If the user hasn't named one, search `projects/` and `{{KNOWLEDGE_BASE_PATH}}/` for the most likely parent.
3. **The author's previous PRDs (if available).** Check `projects/` for prior PRDs by the same author. Pattern recognition across PRDs is one of the highest-value moves this skill makes.

If any of these are missing, **proceed with the roast but explicitly flag the gap** — don't pretend you checked.

---

## Method

The roast is a **6-pass attack**. Run all six. Don't skip any pass because the PRD "looks fine" — every pass surfaces a different failure class.

### Pass 1 — Internal contradiction sweep

Read the PRD end-to-end and flag where it contradicts itself. Common patterns:
- Assumption A says X, Requirement R5 implies not-X
- Metrics define success as Y, but Out-of-Scope excludes the lever that moves Y
- Risks acknowledge dependency D, but Milestones don't gate on D
- Edge case handling contradicts a stated assumption
- Open Questions list questions that are actually answered elsewhere in the doc (and vice versa)

Cite the specific lines or sections. Do not generalise.

### Pass 2 — Logical fallacies + rhetorical sleight of hand

Use [`references/fallacies.md`](references/fallacies.md) as the lookup. Common in PRDs:
- False dichotomy ("either we ship X or competitor wins")
- Motte-and-bailey claims of "we have data" backed by one weak proxy
- Begging the question ("the trust badge will increase trust")
- Survivorship bias ("eBay does this, so we should")
- Single-cause attribution
- Anchoring on a stakeholder request as if it were a user need
- Sunk-cost reasoning ("we've already invested in X")
- Streetlight effect (measuring what's easy, not what matters)

Quote the exact phrase and name the fallacy.

### Pass 3 — Technical hallucination audit

Use [`references/technical-hallucinations.md`](references/technical-hallucinations.md). PMs hand-wave technical complexity in predictable ways. Look for:
- "The API just exposes that" without checking the field exists
- "ML can do this" without scoping training data, latency, infra
- "Real-time" claims without latency budget
- Cold-start problems ignored
- Refresh cadences hand-waved
- Feature-store / data-product capabilities assumed
- Confidence intervals or sample sizes missing on impact claims

For each, name the specific claim and what concrete question it dodged.

### Pass 4 — Industry & marketplace traps

Use [`references/marketplace-traps.md`](references/marketplace-traps.md). {{COMPANY}} is C2C with PRO sellers — the trap surface is well-known:
- Supply/demand asymmetry (helps buyers, kills supply — or vice versa)
- Two-sided incentive misalignment
- Trust-signal proliferation / badge cannibalisation
- Power-law user distribution (median user vs top 1% sellers)
- Liquidity vs quality tradeoffs
- Categorical heterogeneity (treating cars like books)
- Cross-side externalities (seller features affect buyer trust and vice versa)
- AI-generated content displacing authentic seller voice

Name which trap the PRD walks into and why.

### Pass 5 — Industry landmines

Use [`references/industry-landmines.md`](references/industry-landmines.md). Cross-tribe dependencies and historical patterns:
- PRO badge / Top Profile / Verified — competing concepts collision
- [example PSP] relationship (PSP, regulated, KYC/KYB)
- DSA compliance pressure
- Artisans tribe ownership (PRO, business detection, DSA KYB)
- Bumpers tribe (ad placement vs. trust signals)
- T&S (reviews, fraud, [example PSP] reliability)
- MMP (seller profile data)
- {{SELLER_TEAM}} (upload flow, catalogue, attributes)
- iOS lag pattern (features ship Android-first, iOS catches up)
- Joint-ownership phantoms (work declared joint but only one team staffed)

Name which landmine the PRD steps on.

### Pass 6 — Author pattern recognition

Use [`references/your-recurring-blind-spots.md`](references/your-recurring-blind-spots.md). This is the highest-value pass — the patterns the author repeats across PRDs. Examples (seeded from observed patterns):
- Pulling Phase 2-3 capabilities from a parent vision into a near-term commitment
- Treating "infrastructure exists in backend" as "data is consumable on the surface"
- Joint-ownership violations (work declared joint with another team, then PRD only lists one author)
- Conflating concepts that the underlying systems actually treat as distinct
- Optimistic timelines on cross-tribe dependencies
- Reframing scope without checking against the parent strategy doc
- Underestimating legal/compliance angle until prompted

If you spot a pattern repeating from prior PRDs, cite both — it's much harder for the author to dismiss.

**This file should be updated as new patterns emerge.** When you finish a roast and notice a pattern not yet documented, propose adding it.

---

## Output format

A single Markdown punch list. No tables (this is the differentiation from `assumption-identifier`). No softening. No "great PRD overall" framing.

Structure:

```markdown
# PRD Roast — [Initiative Name]

**Source:** [PRD link]
**Parent strategy checked:** [link or "none — flagged as gap"]
**Prior PRDs reviewed for pattern recognition:** [list, or "none"]

---

## TL;DR — the three biggest problems

Three sharpest hits. One line each. If the author reads only this, they should know what to fix first.

---

## 1. Internal contradictions

- **[Specific section/line]** — [exact quote or paraphrase]. Contradicts [other section]: [exact quote]. Pick one.
- ...

## 2. Fallacies and rhetorical sleight of hand

- **[Section, exact phrase]** — [name the fallacy]. [Why it doesn't hold.]
- ...

## 3. Technical hallucinations

- **[Claim, exact phrase]** — dodges [specific technical question]. [What evidence would be needed to make this claim.]
- ...

## 4. Industry / marketplace traps walked into

- **[Trap name]** — [where in the PRD] — [why this hits it].
- ...

## 5. Industry landmines

- **[Landmine]** — [where in the PRD] — [the specific cross-tribe coordination or historical context the PRD ignored].
- ...

## 6. Your recurring blind spots — pattern check

- **[Pattern name]** — Last seen in [prior PRD]. This PRD does the same thing in [section]: [quote]. [Why it's the same pattern.]
- ...

## 7. What's missing entirely

Things the PRD doesn't discuss but should: ethical, accessibility, edge segments, legal, GTM, dependencies without owners, etc.

## 8. Voice & epistemic honesty

Specific lines that violate the [Voice & Epistemic Honesty Guide](../shared/voice-guide.md): black-box superlatives, manufactured drama, hedge-stacking, AI slop, observation/interpretation fusion. Quote the lines.

---

## What to fix before publishing

Three to seven concrete edits, in priority order. Each tied to a specific roast bullet above by number.

## What to do separately, not in this PRD

Things the author may want to keep but should not be in this document — flag what should move to a separate brief, an appendix, a follow-up PRD, or out of scope.
```

---

## Tone and writing standards

This skill is the one place in the workspace where the writing is **adversarial, not constructive**. Calibrate:

- **Be specific, not generic.** "The metric is hand-wavy" is useless. "Section 'Metrics' defines success as 'AOV uplift' but the experiment design has no power analysis for AOV — at current {{COMPANY}} daily transaction volume, detecting +2% AOV requires X transactions over Y days and the PRD doesn't show that math" is useful.
- **Quote the exact line.** Roasts only land when the author can find what you're attacking. Use blockquotes or "Section X says: '...'" format.
- **Earned harshness.** Match the strength of the critique to the strength of the evidence. Don't hedge a real problem ("this might be a small concern") and don't overstate a small one ("this is a fatal flaw").
- **No AI slop.** Skip "It's worth noting that", "Importantly", "I should mention", any hedge-stack. State the attack. Move on.
- **No emojis. No bullet point preambles ("Here are the issues:"). Open with the punch.**
- **Don't roast the author. Roast the document.** Even when citing recurring blind spots, attack the pattern, not the person. ("This PRD does the same thing the LQI proposal did" — fine. "You always do this" — not fine.)
- **Apply the [Voice & Epistemic Honesty Guide](../shared/voice-guide.md) to your own output.** A roast that violates the same standards it audits is worthless.

---

## Common failure modes — check your own output before delivering

1. **Generic critique.** "This needs more validation" — useless. Name the specific claim, the specific validation that's missing, and what would qualify as evidence.
2. **You only ran 2-3 of the 6 passes.** Re-run all six even on PRDs that "look fine." Pass 6 (recurring blind spots) is the most commonly skipped and the highest-value.
3. **You softened the critique because the PRD's prose is confident.** PMs write PRDs to sound confident. Confidence in the prose is not evidence. Rate the underlying claims, not the tone.
4. **You substituted assumption inventory for roasting.** If you find the PRD has weak assumptions, name the weakness — don't write the assumption table for them. Route to `assumption-identifier`.
5. **You missed the parent strategy contradiction.** If the PRD pulls Phase 2-3 capabilities from a vision into a near-term commitment, that is the most important thing in the roast. Always check against the parent strategy doc.
6. **No specific quotes.** If you can't quote the line you're attacking, you're not roasting — you're vibe-checking. Re-read the doc.
7. **You wrote a "balanced" review.** This is not a balanced review. It is an adversarial critique. The user has other tools for balance. If the PRD has nothing to attack, say so explicitly — don't manufacture critique to fill space, but also don't pad with positives.

---

## Quality checklist

Before delivering, verify:

- [ ] All **6 passes** run, none skipped
- [ ] Parent strategy / vision doc **checked** for scope-creep / contradiction (or gap explicitly flagged)
- [ ] At least one **author-pattern citation** if prior PRDs are accessible
- [ ] Every attack has a **specific quote or section reference**
- [ ] **TL;DR top 3** sharpest hits, one line each
- [ ] **What to fix** section ordered by priority and tied to roast bullets
- [ ] No AI slop, no manufactured balance, no emojis
- [ ] Voice guide compliance — including in your own writing

---

## Updating the references over time

The reference files are not static. After each roast:

- If you used a fallacy, hallucination pattern, marketplace trap, or {{COMPANY}} landmine that wasn't in the references, **propose adding it**.
- If you spotted a new author blind-spot pattern that's already showed up twice, **propose adding it to `your-recurring-blind-spots.md`** with the two citations.
- The skill gets sharper with use. Stale references mean generic roasts.
