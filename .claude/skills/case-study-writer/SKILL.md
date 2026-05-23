---
name: case-study-writer
description: Draft or polish a longform portfolio case study about shipped work — typically a Wallapop initiative, a Spotify project, or an earlier role's deliverable. Use when the user wants to publish a case study on the portfolio site, restructure an existing case study, or convert internal Wallapop work into a public-safe write-up. Phase-routed (problem framing → the bet → evidence → the lesson → sanitization → polish) with a mandatory redaction protocol for metrics, names, and internal strategy. Default tone preset: Ricardo (honest + dry humour); never Verna for case studies.
metadata:
  type: writing-skill
---

# case-study-writer

Longform case study drafter for the portfolio site. Different from `blog-post-writer` in three load-bearing ways:

1. **Audience is evaluative.** Hiring managers, prospective advisory clients, and senior PM peers reading to *judge whether Ricardo's craft is real*. The writing is less performative than a blog post, more verifiable.
2. **Structure is fixed.** Problem → the bet → evidence → the lesson. The structure is the contract; deviations need a defensible reason.
3. **Redaction is non-negotiable.** Case studies draw on real Wallapop work. Internal strategy, undisclosed metrics, named colleagues, and individual research participants are off-limits. A sanitization gate runs before any publishing artefact leaves the skill.

**Mandatory pre-flight:**
- Load `pm-os-public/.claude/skills/shared/post-style-guide.md` — universal voice rules apply.
- Default tone preset: `ricardo`. **Verna preset is not available for case studies** — case studies are evidence-led, not opinion-led.
- For Wallapop work specifically, invoke `kb-grounder` to pull verbatim grounding from public sources (press releases, blog posts, conference talks, Wallapop's own newsroom) BEFORE drafting. Anything that isn't already public goes through the sanitization gate.

---

## Phase 0 — Intake

Ask these in one batched message. Do not draft until every answer is given.

1. **Which initiative is this case study about?** (Slug, project name, or one-line description.)
2. **Is there an existing scaffold for this case study?** (If yes — e.g., already in `personal/portfolio/src/data/caseStudies.js` — load it and treat it as Phase 1's first draft. If no, start from scratch.)
3. **What's the headline outcome?** (One sentence stating the result. Examples: *"Replatformed the listing detail page; 80% Time-to-Full-Load reduction on Android."* / *"Shipped the item-to-item similarity ML model; +2.8% CVR contribution."* The headline outcome anchors the whole piece.)
4. **What's the generalizable lesson?** (One sentence stating what a reader who didn't ship this work can take away. Case studies without a transferable lesson are résumé entries, not case studies. If the user can't state the lesson, the case study isn't ready — coach them to find it before drafting.)
5. **What's the public-safety surface?** (Which metrics are already disclosed? Which colleagues can be named with permission? Which internal strategy details must be redacted?)
6. **Target length?** (Default: 2,000–3,500 words. Shorter than that, the case study isn't doing enough work; longer, the reader bounces.)

---

## Phase 1 — Problem framing

Output of this phase: **the "Problem" section of the case study**, 200–400 words.

The Problem section must:
- **Name the specific user problem, not the business problem.** "Buyers couldn't evaluate sellers' credibility" beats "we needed to increase conversion." Business outcomes go in Phase 3 (Evidence), not here.
- **Be measurable.** State the friction in observable terms — what users were doing wrong, where they were dropping, what they were saying in research.
- **Acknowledge prior attempts.** What had the team or industry already tried? Why didn't it work?
- **Avoid the hero setup.** Don't frame the problem as "and then I arrived." The problem existed before and after the case study's author.

### 1.1 Source the framing from grounding

Pull the framing from research transcripts, prior PRDs, or public Wallapop posts. Do NOT invent the user-quote that opens the section. If a verbatim quote is going to appear, it must be confirmed against the source via `kb-grounder` or the user.

### 1.2 Stop and wait

Output the Problem section. Wait for the user to confirm it's accurate before proceeding.

---

## Phase 2 — The bet

Output of this phase: **the "The bet" section**, 300–500 words.

This section explains *what was decided* and *why*. It is the most useful section for evaluating PM judgment — recruiters and advisory prospects read this section closest.

### 2.1 State the bet plainly

One sentence describing the chosen approach. Examples:
- *"Replatform the listing detail page off the legacy service stack onto a thinner, cache-friendly backend, and absorb a Q3 of engineering capacity to do it."*
- *"Ship an item-to-item ML similarity model as a 'similar items' shelf on the listing detail page — bet that buyers wanted *alternatives*, not *recommendations*."*

### 2.2 Defend the bet against the alternatives the team considered

This is where PM craft shows. Name 1–3 alternatives the team actually considered and why they were rejected. Vague alternatives (e.g., "we could have done nothing") are filler — name the specific competing proposals.

### 2.3 State what would have made the bet wrong

The honest version: a paragraph naming the conditions under which the bet would have failed. Examples:
- *"If buyers preferred recommendations over alternatives, the shelf would have cannibalized the seller's primary listing instead of supplementing it. The pre-launch research suggested the opposite, but the bet wasn't safe."*

Case studies that don't name failure conditions read as backfill. The reader notices.

### 2.4 Acknowledge what wasn't decided alone

PM work is rarely individual. Name (with permission) or anonymize ("the staff engineer on the team") the people whose judgment shaped the bet. The credit isn't a politeness — it's a credibility signal. Sole-author case studies read as inflated.

### 2.5 Stop and wait

Output the section. Wait for confirmation before Phase 3.

---

## Phase 3 — Evidence

Output of this phase: **the "What happened" section**, 400–700 words, anchored on real metrics with full context.

### 3.1 Lead with the headline outcome

One sentence stating the result. Match the Phase 0 headline. Then immediately complicate it.

Example pattern (Ricardo default voice):
> *"The replatform reduced Time-to-Full-Load on Android by 80% at the median. That's the headline. The honest version is: the 80% was the median; the p95 dropped 31%, and the bottom decile barely moved. The seven percent of users on entry-level Android devices — the buyers we most needed to reach — were where the real work remained."*

### 3.2 Numbers carry units and context

Every metric in this section must include:
- Unit (% change, absolute value, currency).
- Funnel step or user segment it refers to.
- Time window (the experiment period, the post-launch month, the YoY comparison).
- Baseline (what the number was before).
- Confidence (statistical or qualitative).

If any of those are missing, ASK the user — don't fill in plausible-sounding values. Wrong numbers in a case study are unrecoverable for the brand.

### 3.3 Surface what didn't go to plan

Every initiative has surprises. Name 1–2 that the team had to react to. Examples:
- A metric that moved the wrong direction.
- A user segment that responded differently than expected.
- A technical limitation discovered post-launch.

### 3.4 Show the artefact

Link or reference the public-facing artefact that resulted: a press mention, a Wallapop newsroom post, a conference talk, an App Store review trend, a screenshot of the shipped UI. The reader should be able to *see* the shipped thing.

If no public artefact exists, the case study has a redaction risk — flag for Phase 4.

### 3.5 Stop and wait

Output the section. Wait for confirmation before Phase 4.

---

## Phase 4 — The lesson

Output of this phase: **the "What I'd take to the next initiative" section**, 250–500 words.

### 4.1 State the transferable lesson plainly

One sentence. The lesson is what a reader can apply to their own work. Examples:
- *"Replatforming projects where the user-visible benefit is performance need a UX hook the user can feel inside the first three sessions, not just a metric the team can defend internally."*
- *"ML recommendations on commerce surfaces are bets about what the user wants the surface to be (a discovery tool vs. a decision tool). Pick before you ship; the model can't pick for you."*

### 4.2 State what does NOT transfer

This is the section that separates a case study from a LinkedIn post. Explicitly call out the conditions of *your* shipping context that don't apply elsewhere:
- Headcount and cross-functional ratio.
- Company stage (post-product-market-fit marketplace vs. early-stage SaaS).
- Data maturity (Wallapop has analytics infrastructure many companies don't).
- Cultural prior (Wallapop's risk tolerance, leadership philosophy).

Without this, the lesson reads as overclaiming.

### 4.3 Connect to the four taste muscles (when relevant)

If the case study demonstrates one of the four taste muscles from the brand thesis (`brand/brand-guideline.md` §1), name which one in a short sentence. Patterns:
- *"This is the product-lens muscle at work — noticing where existing solutions skipped the user segment, not where they failed to optimize."*
- *"This was a systems-thinking call — the local optimum (faster page load) wasn't the global optimum (faster decision-making) until we threaded the seller-trust signals back into the layout."*

Don't bolt this on if it doesn't fit the case study. The connection has to be real.

---

## Phase 5 — Sanitization gate

**Run before Phase 6 (Polish). No exceptions.**

Output of this phase: a **redaction report** listing every potentially-sensitive item and the resolution.

### 5.1 The four-pass redaction check

Pass 1 — **Undisclosed metrics.** Every number in the draft is checked against the "publicly disclosed" list from Phase 0. Any metric not on that list is flagged. Resolutions: cite a public source, get permission from Wallapop, round to a published range, or remove.

Pass 2 — **Named colleagues.** Every named person is checked. Resolutions: confirm permission, anonymize ("the staff engineer on the team," "the design lead"), or remove. Default to anonymization if no explicit permission.

Pass 3 — **Internal strategy.** Specific roadmap items, undisclosed product bets, internal organizational details. Resolutions: generalize, defer to a public source, or remove.

Pass 4 — **User research.** Any verbatim user quote, participant detail (cohort, age, role), or research method specifics. Resolutions: confirm consent, anonymize the participant beyond recognition, or remove the quote.

### 5.2 Output the redaction report

Present the user with a table:
| Item | Source | Risk | Proposed resolution |
|---|---|---|---|
| "+12.4% CVR" | Wallapop external blog post, 2026-02 | Low (publicly disclosed) | Keep, add citation |
| Designer name "Sam" | Internal | Medium | Anonymize: "the design lead" |
| Specific Amplitude p-value | Internal | High | Remove |
| ... | ... | ... | ... |

The user signs off on the report before Phase 6.

### 5.3 When in doubt, remove

The brand cannot recover from a leak. Removing a borderline detail costs less than reaching out to a former colleague to negotiate post-publish. Default conservatively.

---

## Phase 6 — Polish

Output of this phase: **the final case study draft**, ready to ship.

### 6.1 Anti-slop sweep

Same as `blog-post-writer` Phase 4.1. Run §2 of `post-style-guide.md` against the draft.

### 6.2 Structure check

- Problem section sets up an evaluable user problem.
- The bet section names alternatives and failure conditions.
- Evidence section has units, context, time windows, baselines.
- Lesson section names what doesn't transfer.
- Sanitization gate signed off.

### 6.3 Voice check (Ricardo default)

- Measured-observational tone, not punchy.
- One personal aside max, used as evidence.
- Dry humour through accuracy, not performance.
- Skeptical of own claims (counterargument surfaced before reader does).

### 6.4 Data-shape output for the portfolio site

The case studies on the site live in `personal/portfolio/src/data/caseStudies.js`. The case study should slot into the existing schema. Pattern (matching the schema seen in the `personal-os` entry already in the file):

```js
{
  slug: 'listing-replatform',  // URL slug for /case-studies/:slug
  title: 'Replatforming the listing detail page',
  kicker: 'AI-era marketplace craft',
  summary: '...',  // 1-2 sentence pitch
  tags: ['Performance', 'Platform migration', 'Mobile-first'],
  video: '/videos/replatform-demo.mp4',  // optional
  videoCaption: '...',  // optional
  sections: [
    { heading: 'The problem', body: ['...', '...'] },
    { heading: 'The bet', body: ['...'], list: [...] },
    { heading: 'What happened', body: ['...'] },
    { heading: 'What I\'d take next', body: ['...'] },
  ],
}
```

Output the case study in this shape. Confirm with the user whether to add directly to `caseStudies.js` or stage it as a separate file for review.

### 6.5 Final-pass checklist

- [ ] Sanitization gate signed off; redaction report attached to the case study's working folder.
- [ ] Headline outcome stated in the first 80 words.
- [ ] Alternatives named in the "Bet" section.
- [ ] Failure conditions named.
- [ ] Metrics have units, context, time window, baseline.
- [ ] At least one acknowledged surprise.
- [ ] Lesson section includes "what doesn't transfer."
- [ ] No undisclosed colleagues named.
- [ ] No undisclosed metrics.
- [ ] No verbatim user quote without consent.
- [ ] Connects to one of the four taste muscles, if applicable (don't force).
- [ ] Length 2,000–3,500 words.
- [ ] Tone preset is Ricardo throughout; no Verna drift.

---

## Exit criteria

The skill is done when the case study is:
- Drafted through all six phases.
- Sanitization-gate signed.
- Slotted into the portfolio site data file (or staged).
- A pointer logged to `knowledge-base-reference.md` for any external sources cited.

**The redaction report is preserved**, not deleted. It's part of the working artefact; future case studies can reuse the resolutions.
