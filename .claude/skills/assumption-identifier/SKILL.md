---
name: assumption-identifier
description: Extensively identify hidden assumptions in a PRD or feature brief using Teresa Torres' methodology — mapped to the user journey and prioritized by criticality and evidence. Use whenever the user asks to stress-test a PRD, surface hidden assumptions, map what needs to be true, de-risk a feature before build, or prepare assumptions for validation — even if they don't say the word "assumption" (e.g. "what could go wrong with this spec", "help me pressure-test this plan", "what are we betting on here", "what needs to be true for this to work").
---

# Assumption Identifier

Surface the hidden beliefs baked into a proposed solution so they can be tested *before* they break the launch.

This skill applies [Teresa Torres' assumption testing framework](https://www.producttalk.org/assumption-testing/) with one extension: every assumption is anchored to a specific **stage of the user journey** (assuming the feature is already live). That anchoring forces story-mapping thinking and stops assumptions from floating at the abstract "users will want this" level.

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the topic and any Confluence/Jira references the user provided (the PRD or feature brief, parent initiative, related research). Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as direct input to the **Blind spots** section of your output — the assumptions hiding in what's not yet documented. Skip only if the user has already supplied a kb-grounder synthesis, or the PRD is fully pasted inline.

## When to use vs. when not to

**Use this skill when:**
- The user hands over a PRD, brief, or feature description and wants assumptions surfaced
- The user says "stress-test", "de-risk", "what could go wrong", "what are we assuming"
- The user is preparing inputs for a validation plan, research brief, or experiment

**Do NOT use this skill when:**
- The user is drafting a PRD from scratch → route to `prd-writer` (phase 4 covers assumptions inline)
- The user already has a tested assumption and wants to design the test → route to `ur-survey-creator` or `experiment-creator`

---

## Inputs you need

Before producing output, confirm you have:

1. **The PRD or feature description.** Could be a file path, Confluence URL, pasted text, or inline description. If too thin (e.g. a one-line feature idea), ask 2–3 specific clarifying questions instead of guessing.
2. **Target user / segment.** If the PRD doesn't specify, ask — journey mapping is meaningless without knowing whose journey.
3. **The journey stages.** Default template: Awareness → Discovery → Evaluation → Action → Post-Action. But **adapt these stages to the specific feature.** For a Saved Items feature the journey might be: Create List → Add Items → Organize → Return to List → Act on List. For a checkout feature: Review Cart → Enter Payment → Confirm → Post-Purchase. State the stages you chose at the top of the output so the user can correct them.

If the PRD is a Confluence page, fetch it via the Atlassian MCP (`mcp__atlassian__getConfluencePage`) and log it in `knowledge-base-reference.md` per the workspace protocol.

---

## Method

### Step 1 — Read the PRD closely and extract the bets

Before writing any assumption, internally answer:

- What is the **hypothesis**? (What we believe will happen if we build this.)
- What **user behavior** does the feature depend on at each journey stage?
- What does the PRD state as **fact** vs. what is **belief**? Evidence cited vs. claims made without citation?
- What **must be true** for each requirement to deliver value?
- What's **not mentioned** that probably matters? (Ethics, accessibility, edge segments, cross-tribe dependencies.)

This is where hidden assumptions hide — in the gap between what's explicit and what's load-bearing but unstated.

### Step 2 — Walk the journey stage by stage

For each stage of the adapted journey, ask: *what needs to be true for the user to reach the next stage successfully?* That question usually surfaces 2–5 assumptions per stage across different types.

A good comprehensive analysis of a real PRD produces **15–25 assumptions**. Fewer than 12 is a signal you stopped too early.

### Step 3 — Classify each assumption by type

Five types, from [references/assumption-types.md](references/assumption-types.md):

1. **Desirability** — users *want* this and will do what's needed to get value
2. **Viability** — this is good *for the business*
3. **Feasibility** — we *can build* and operate this
4. **Usability** — users *can successfully use* the solution
5. **Ethical** — the solution does not cause harm (privacy, fairness, accessibility, misuse)

Classification is ambiguous at the edges (Torres acknowledges this). Don't agonize — the point of the types is coverage, making sure you don't over-index on desirability and miss viability or ethical blind spots.

### Step 4 — Score importance and evidence

For each assumption:

- **Importance** (High / Medium / Low): how central is this to the success of the initiative? High = if wrong, the initiative fails or significantly underperforms. Low = peripheral or easily corrected.
- **Evidence** (High / Medium / Low): how much validation already exists? High = multiple sources converge (data + research + past experiments). Low = intuition, stakeholder opinion, or best-practice reasoning with no direct evidence.

**Be honest about evidence.** A common failure mode is inflating evidence because the PRD *sounds* confident. If the PRD says "users want this" but cites nothing, evidence is Low.

### Step 5 — Derive risk level

Use David Bland's 2×2 (Torres cites this as her prioritization lens):

| Evidence ↓ / Importance → | High | Medium | Low |
|---|---|---|---|
| **High** | Safe | Safe | Safe |
| **Medium** | **Risky** | Safe | Safe |
| **Low** | **Risky** | **Risky** | Safe |

Risky assumptions are the ones to test *before or during* build. Safe assumptions can be monitored post-launch.

### Step 6 — Recommend a test

For each risky assumption, suggest one concrete validation method. Match method to type:

- **Desirability** → user interviews (5–8), fake door, concierge, landing page test, pre-launch survey
- **Usability** → prototype testing (5–8 users), first-click test, cognitive walkthrough, accessibility audit
- **Feasibility** → technical spike, proof of concept, load test, architecture review
- **Viability** → A/B test, cohort analysis, financial model, operational pilot
- **Ethical** → privacy impact assessment, fairness analysis across segments, red-team exercise, diverse-user research

Be specific: method + sample/duration + what would count as disconfirmation.

---

## Output format

Produce a single Markdown document with this structure. Do not deviate.

### Header

```
# Assumption Analysis — [Initiative Name]

**PRD source:** [link or file path]
**Target users:** [from PRD]
**Primary hypothesis:** [1-sentence restatement]
**Journey stages used:** Stage 1 → Stage 2 → … → Stage N
```

### Riskiest assumptions (top of document)

A short callout listing the **5 assumptions that could kill the initiative if wrong** — pulled from the table below, with a one-line "why this matters" for each. This is the BLUF. If the PM reads only this section, they should walk away knowing what to test next week.

### Full assumption table

One table, all assumptions, sorted by Risk (Risky first) then Journey Stage. Columns:

| # | Assumption (We believe…) | Type | Journey Stage | PRD Source | Importance | Evidence | Risk | Suggested Test |
|---|---|---|---|---|---|---|---|---|

- **Assumption**: phrased as "We believe [user / the business / our system] will [specific behavior or outcome] because [reason]." Specific and testable. Not "users will love this."
- **Type**: D / V / F / U / E (use single letter to keep the table readable)
- **Journey Stage**: the stage name from the adapted journey
- **PRD Source**: section reference so the reader can audit — e.g. "Metrics §2" or "Scope — in-scope item 3"
- **Importance / Evidence**: H / M / L
- **Risk**: Risky / Safe
- **Suggested Test**: method + sample size or duration, short form (e.g. "Fake-door test, 2 weeks, 5% traffic")

### Coverage summary

A short block showing distribution across types and risk levels. Call out imbalances — e.g. "10 desirability assumptions, 0 ethical. Potential blind spot around accessibility and segment fairness."

### Blind spots

A separate bullet list of things the PRD doesn't discuss but probably should. This is where you flag missing ethical considerations, unexamined cross-tribe dependencies, absent accessibility mentions, or assumptions about user segments the research didn't cover.

### Recommended next steps

3–5 concrete actions for the next 1–2 weeks. Bullet form, each tied to specific assumption numbers. Example: "Run 6 user interviews with heavy-Favorites users to test #3, #7, #11 (2 weeks)."

---

## Writing standards for the output

Follow the [Voice & Epistemic Honesty Guide](../shared/voice-guide.md):

- **Earned confidence.** If evidence in the PRD is low, say so plainly. Don't soften it to "some evidence exists."
- **No black-box superlatives.** "The riskiest" is fine *because you're applying a stated rubric*. "The most critical blocker" without a rubric is not.
- **Separate observation from interpretation.** The PRD's claims are observations. Your risk scoring is interpretation. Never fuse them.
- **Active voice, concrete nouns.** "The ML model ranks sellers by CVR-correlated behaviors" not "Sellers are ranked by behaviors that are correlated with CVR."
- **No fluff.** Skip filler like "It's worth noting that." State the assumption. Move on.

---

## Common failure modes — check your own output

Before delivering, audit for these:

1. **Every assumption is "users will love this."** → You only produced Desirability assumptions. Force yourself to write at least 2 of each type.
2. **Assumptions are too vague to test.** → "Users will use the feature" is not testable. Push for "40%+ of users exposed to the onboarding tooltip will create their first list within 7 days."
3. **Evidence rating matches the PRD's tone.** → You're inflating. The PRD sounds confident because the PM wrote it to sound confident. Rate evidence by what's *cited*, not by how the prose feels.
4. **No ethical or accessibility assumptions.** → Almost every feature has at least one. If you wrote zero, you stopped too early.
5. **Every assumption lives in the "Evaluation" stage.** → You didn't actually map the journey. Re-walk the stages and surface assumptions at Awareness, Discovery, Action, Post-Action too.
6. **Journey stages are generic and ignore the feature.** → "Awareness / Evaluation / Action" applied to a backend performance feature is lazy. Adapt to the actual feature's user touchpoints.

---

## Quality checklist

Before you return the output, verify:

- [ ] Journey stages are **adapted** to this specific feature (not generic)
- [ ] **15–25** assumptions identified (fewer = surface-level analysis)
- [ ] All **5 types** represented (no dominance by one type)
- [ ] Each assumption is phrased **"We believe X will Y"** and is specific enough to test
- [ ] **PRD section traceability** for every assumption
- [ ] Risk rating applies the importance × evidence matrix **consistently**
- [ ] **Riskiest 5** summary at the top with "why this matters"
- [ ] **Blind spots** section surfaces what the PRD *doesn't* discuss
- [ ] **Next steps** tie back to specific assumption numbers
