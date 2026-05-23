---
name: pm-writing-standards
description: Required sub-skill for any PM writing task (PRDs, RFCs, post-experiment reports, one-pagers, Jira tickets, feedback memos, Confluence pages, strategy memos). Mandates style guide pre-flight, enforces cross-cutting rules during drafting, and runs the final-pass checklist before declaring done.
---

# Writing at {{COMPANY}}

Required sub-skill for all {{COMPANY}} prose artefacts. Run the pre-flight before drafting, apply the four Axioms during drafting, and run the final-pass scan before declaring done.

## Pre-flight

1. Read the four Axioms below; they are the canonical rules.
2. If a format-specific style guide exists for this artefact type, read it (glob `style-guide/*.md`).
3. If any acronym or {{COMPANY}}-specific term is unclear, check `{{KNOWLEDGE_BASE_PATH}}/GLOSSARY.md` before surfacing ignorance to the user.
4. For deliverable artefacts (PRDs, RFCs, post-experiment reports, design specs, one-pagers), place under `projects/<domain>/`. If placement is ambiguous, use AskUserQuestion before scaffolding.

## Quick reference: highest-frequency violations

These ACTIONs fire most often. Apply during drafting, not only at the final pass. Each item points to the Axiom that holds the rule body and example.

- **No em-dashes (—) in prose.** [Axiom 2]
- **No coined hyphenated compounds or metaphorical noun phrases.** "the filter" beats "the hard-filter mechanism". [Axiom 3]
- **Active voice with named actor.** "The filter is active on ~14% of Spain searches" beats "Reach is bounded by ~14% of searches". [Axiom 3]
- **One idea per sentence.** Max one subordinate clause; split when more. Colon-chained mechanism explanations are multi-idea. [Axiom 1]
- **3-4 sentence paragraphs.** Recommendation rationales especially. [Axiom 2]
- **No weasel words** (might, could, possibly, TBD). [Axiom 3]
- **Define acronyms inline on first body use.** Sweep operational acronyms (KTLO, OKR, BAU, SLO) along with product/metric ones (PI, BFM, SRR, TRX). [Axiom 2]
- **Strip internal scaffolding.** Phase/sprint/tier labels, "(timeline TBD)" notes. [Axiom 3]
- **"user", not "searcher"** in metric definitions and prose.
- **Lead with the verdict** on launch criteria, hypothesis status, recommendation status. [Axiom 2]
- **Mechanism before name.** Functional description on first use, not a role label. [Axiom 3]
- **No ambiguous pronouns.** "It", "this", "they" — replace with the concrete noun. [Axiom 3]
- **No invented data, quotes, or roadmap items.** Flag and ask if context is missing. [Axiom 3]
- **Terminology lock.** Once established, do not drift to a synonym without basis. [Axiom 3]
- **TL;DR redundancy sweep.** Run the four removal tests (preview, restated fact, meta-commentary, non-load-bearing component). [Axiom 1]
- **Team / role names in body, not person names.** Person names live in Stakeholder tables and sign-off lines; body prose uses the role ("Trust & Safety commits...", not "Alex commits..."). [Axiom 3]
- **Gates / dependencies have ONE canonical full explanation.** Status line gets a one-clause summary; other sections name the gate without re-explaining. [Axiom 2]

## The four Axioms

### Meta-rule for adding ACTIONs

Before adding a new ACTION, apply the orthogonality check: does an existing ACTION already cover this failure case? If the proposed rule only fires when an existing rule already fires, it is redundant. DELETE it, REPLACE the existing rule with the sharper version, or FOLD it into the existing rule's example. The bar is orthogonality, not completeness; the guide is meant to be a small set of independent rules a writer can hold in their head, not an exhaustive catalogue.

### Axiom 1 — Economy

RULE: Density of meaning. One idea per sentence; one subordinate clause max. When a thought needs two clauses, split into two sentences. The colon-with-explanation pattern is the most common violator: a header clause followed by a colon and a second independent reasoning clause is two ideas, not one. Mechanism explanations that chain signal-framing, current-consumption mechanism, threshold mechanics, and consequence across one colon-joined sentence are multi-idea even when each clause is individually precise.

ACTION: Scan for filler and ceremonial phrases ("It is worth noting that," "agreed in a follow-up meeting that," "discussed in the sync and concluded that"). DELETE the venue/process clause and absorb the action into a stronger verb. The meeting venue adds no information; the strong verb carries the agreement more compactly.
- WRONG: "the Ads team agreed in a follow-up meeting that the regression is not a blocker."
- RIGHT: "we aligned with the Ads team that this regression is not a blocker."

ACTION: Scan adverbs (-ly words, plus disguised adverbs like "actively", "consistently"). If an adverb modifies a verb, DELETE the adverb and REPLACE the verb with a stronger alternative. "Sprinted" beats "ran quickly"; "harms" beats "actively harms".

ACTION: Repetition. Identify sentences that repeat earlier-established meaning in weaker words. DELETE the weaker version. This applies across paragraphs: once a frame is set ("we treated this as a do-no-harm experiment, expecting flat metrics"), a callback ("metrics held flat as expected") adds nothing for a reader who retained the frame and patronizes them.

ACTION: Removal test. Before any sentence that explains behavior the reader is expected to take for granted, ask: does the sentence's absence change the meaning? If not, DELETE. Sentences that defend against imagined objections, pre-explain obvious constraints, or restate scope caveats fail this test. The rule applies with extra force in TL;DRs and lead paragraphs: scope-qualifying meta-sentences ("Impact is incremental on top of X landing; LOE counts Search-team effort only") fail when the body already establishes the qualifications.

ACTION: TL;DR redundancy sweep (STRICT). TL;DRs accumulate redundancy faster than any other section. Before declaring a TL;DR done, run all four tests on every sentence:

1. **Previews a later TL;DR item?** DELETE; the later item carries the conclusion.
   - WRONG: "The filter is active on ~14% of Spain searches today; the challenger model and candidate chips expand that coverage. Retiring the hard filter grows the upside further." (when item 2 below already covers retiring the hard filter)
   - RIGHT: "The filter is active on ~14% of Spain searches today; the challenger model and candidate chips expand that coverage."

2. **Restates a fact established by another TL;DR item's mechanism description?** DELETE. The most common shape is a **scope-establishing opener**: an item begins by re-stating a fact already established by another TL;DR item, then transitions to its actual content. The opener fails the removal test because the fact is already known; deleting it lets the item open on its load-bearing content.
   - WRONG: "Q2C produces a category-confidence score on every query. LEGO already consumes it for filter persistence between reformulations; this track extends that pattern." (when an earlier TL;DR item established Q2C as a classifier signal)
   - RIGHT: "LEGO already consumes Q2C for filter persistence between reformulations; we need to ensure it is vended so downstream surfaces can consume it too."

3. **Meta-commentary on cross-item relationships or operating model rather than a conclusion?** DELETE, or absorb the load-bearing word into an existing sentence (e.g., promote "independent" up into "three independent tracks" rather than appending "the tracks have no cross-stream dependency" at the end). The **operating-model variant** describes how the work will be done ("Search does not pre-build…each consuming team pulls on the signal") rather than naming a conclusion; it restates the option's framing without advancing the recommendation.
   - WRONG (operating-model meta-commentary): "The Query Understanding (QU) service already exposes Q2C; the remaining work is ensuring consuming surfaces can read it via LEGO. Search does not pre-build category-driven experiences; each consuming team pulls on the signal when it has a concrete use."
   - RIGHT: cut both sentences; QU/LEGO mechanics are body-detail and the operating-model commentary restates the option's framing without advancing the conclusion.

4. **Introduces a non-load-bearing named component (service, system, architecture term)?** REPLACE with a generic descriptor. "Downstream surfaces" beats "the Query Understanding (QU) service" when the conclusion still parses with the generic. The TL;DR is not the place to taxonomize the architecture; it is the place to state conclusions.
   - WRONG: "The Query Understanding (QU) service already exposes Q2C; the remaining work is ensuring consuming surfaces can read it via LEGO."
   - RIGHT: "we need to ensure it is vended so downstream surfaces can consume it too."

ACTION: Skeleton-then-expanded list. When a TL;DR introduces items by label, then immediately expands them in a second list, the skeleton is a weaker restatement. MERGE into one integrated list with [LOE/Impact] tags inline in each item's first line, and absorb any framing sentence ("Each track is tagged [LOE/Impact]") into the intro.

### Axiom 2 — Structure

RULE: Information hierarchy. Each section asserts a conclusion and earns its place in the document.

ACTION: BLUF. Extract the single most critical insight, decision, or request and MOVE it to the absolute top of the document.

ACTION: Signposting. Insert transitions ("Contrastingly", "Specifically", "As a result") to logically link disparate paragraphs.

ACTION: Maximum paragraph length 3-4 sentences. BREAK longer paragraphs into bullets. STRICT for "not recommended" rationales: five-sentence paragraphs almost always have overlapping reasoning that collapses to verdict + two-clause rationale + carve-out.
- WRONG: "Tuning classifier accuracy with the hard filter as the only consumer is not a recommended quarterly bet. Auto-filtering by category only suits a subset of traffic; expanding that share is a product and UX problem, not a model problem. {{COMPANY}} catalog is user-generated: user classification errors and category suggester misclassifications directly counter accuracy gains. E-commerce platforms can enforce category discipline at the catalog level; {{COMPANY}} cannot. Like the ranker, Q2C needs regular model maintenance to stay fresh; that is a standing hygiene task."
- RIGHT: "We will not consider further tuning classifier accuracy as a standalone quarterly bet. The hard filter caps the upside regardless of accuracy gains, and {{COMPANY}} user-generated catalog adds classification noise that even a perfectly retrained classifier cannot remove. Q2C still needs routine model maintenance, but that is a standing hygiene task."

ACTION: Numbered list when count is asserted. If prose explicitly counts items ("two fronts," "three reasons"), USE a numbered list so list items map 1:1 to the count. DO NOT use bullet points when a count is asserted.

ACTION: Cold-reader test for summaries (TL;DR, lead paragraphs, executive intros). DEFINE every label, alias, or acronym on first use within the summary. DO NOT reference sections the reader has not yet read; "(see Section 1)" is a forward reference that fails this test. The test also fires on product feature names introduced as sentence subjects before being described — either describe the feature inline or fold its example into a feature already introduced.
- WRONG: "it restricts the SERP to results from that category, with no user-visible signal of the restriction (mechanism in Section 1)."
- RIGHT: "it restricts the SERP to results from that category with no visible affordance."

ACTION: Definition vehicles attach to first use, not to thematic restatement. If a term has a parenthetical gloss, footnote, or glossary cross-reference, ATTACH it to the term's first body appearance, not to a later "formal" mention. After every structural edit, RE-CHECK that definitions live at first use.

ACTION: Define acronyms inline on first body use. The rule fires on any acronym not in the general business vocabulary, including operational acronyms that feel obvious to the author but are not (KTLO, OKR, BAU, SLO) along with product/metric acronyms (PI, BFM, SRR, TRX). Operational acronyms feel obvious to the author and miss the sweep most often. Default to inline definition; check `{{KNOWLEDGE_BASE_PATH}}/GLOSSARY.md` if uncertain.
- WRONG: "Q2C still needs routine model maintenance, but that is a standing hygiene task." (when the artefact later uses KTLO without defining it)
- RIGHT: "Q2C will still need routine model maintenance that we will take on as KTLO (Keep The Lights On)."

ACTION: Lead with the verdict for launch criteria, guardrail outcomes, hypothesis status, and recommendation status. "We met X with Y" beats "Y came in, meeting X". When flagging that an option is not recommended, name the option first and state the verdict immediately; do not bury the subject before the verdict.
- WRONG: "A fourth direction, continuing to tune classifier accuracy and per-category thresholds with the hard filter as the only consumer, is not on the recommended list."
- RIGHT: "Tuning classifier accuracy with the hard filter as the only consumer is not a recommended quarterly bet."

ACTION: Self-contained hypothesis statements. When reporting an experiment, use "The hypothesis that [X] was [confirmed/not confirmed]" — never "The hypothesis was not confirmed" alone. The reader must be able to read the verdict line standalone without scrolling back to find what was hypothesized.

ACTION: DO NOT use single-letter shorthands (A/B/C) or numbered aliases ("stream 1") to refer to product areas, features, or strategies in prose. Tables and comparison grids are the only valid context for letter labels.

ACTION: STRICT: No defensive section headers. Two banned shapes: (a) interrogative ("Why X is the case", "How we approached Y"); (b) contrastive ("Trigger: opportunity, not crisis", "Approach: pull, not push"). Both pre-empt objections rather than asserting conclusions. REPLACE with assertion headers naming the section's content directly. If a section genuinely earns a "why" framing, make it declarative ("The reason we chose X").
- WRONG (contrastive): "### Trigger: opportunity, not crisis"
- RIGHT: "### Motivation"

ACTION: When a section compares options and argues toward one, the title must signal both ("Options and recommendation"), and the recommendation must appear as an explicit labeled line after the comparison, not buried in subsections.

ACTION: DO NOT use em-dashes (—) in prose. Replace parenthetical em-dashes ("— X —") with parentheses; replace clause-introducing em-dashes with a colon or semicolon as appropriate.

ACTION: No dangling framing sentences. Every header, lead, or section opener carries an assertion; the next 1-3 sentences (or the immediate bullet list) MUST cash out that assertion. The colon-then-bullet anti-pattern is the most insidious form: a framing sentence ends in a colon, bullets follow, the writer treats the bullets as proof. The pattern fails when the bullets restate the same vague justification the framing already gave instead of naming a concrete mechanism. STRICT: every colon-then-bullet construction triggers a bullet-content audit. Each bullet must add a mechanism, number, or worked example the framing did not contain. If the bullets only re-name what the framing announced, DELETE both the framing and the bullets.
- WRONG: "The trigger is opportunity-driven:
  - Increase correct high-confidence predictions, the main lever for when we auto-apply category filters.
  - Reduce known failure patterns amplified by noisy labels and by the production feedback loop, where Production predictions influence what users convert on, which then shapes the next training set."
  (The framing announces "opportunity-driven"; the bullets re-name the same idea in two abstract restatements without naming what was actually observed.)
- RIGHT: omit the framing AND the bullets. Lead with the concrete mechanism: "The retrain is not driven by data drift; the current baseline still compares well to recently retrained variants. We are running it to capture the headroom from [specific lever] and [specific failure pattern observed in data]."

The dangling pattern applies to relationship claims as much as to opposition claims. Sentences asserting *fits, doesn't fit, benefits from, blocks, enables, depends on, is incompatible with* must spell out the mechanism in the next 1-3 sentences. If you cannot articulate the mechanism in plain terms, ASK the user via AskUserQuestion before deleting the claim; the user may know the mechanism and want it preserved.

ACTION: After any structural edit (removing a paragraph, moving a list item, deleting a signpost, reordering sections), RE-READ the affected section end-to-end. SCAN for orphaned transitions ("Then..." with nothing before it), broken numbering, signposts whose referent moved, pronouns whose antecedent was deleted.

ACTION: Fact-context fidelity on moves. Moving a fact across paragraphs changes its fidelity even when the wording is preserved verbatim, because surrounding sentences carry the context the reader needs to parse it. Before claiming a tightened version "loses no fidelity," verify each retained fact still has its supporting context in its new location. The most common failure: pulling a number forward into a lead to "show your work" but stripping the explanation that made the number parseable. "No facts deleted" is not the same as "no fidelity loss".

ACTION: Cross-section deduplication and section-purpose discipline. Each fact, mechanism, or framing has one canonical location, and each sentence in a section must advance that section's stated purpose. Three failure shapes share this rule:
(a) **Repetition.** A sentence restates content covered earlier. When filling templated sections (Context, Background, Strategic alignment), scan what earlier sections established; if overlapping, REFERENCE back ("As described above...") and use the slot for content not yet covered.
(b) **Tangent.** A sentence is related to the section's broader topic but does not advance the section's stated purpose. It belongs in another section, in the appendix, or cut entirely.
(c) **Gate / dependency re-explanation.** A launch gate, dependency, pre-condition, or scope decision is fully re-explained in multiple sections (Status, Objective, Requirements, Risks, Milestones, Open Questions). PICK ONE canonical location for the FULL explanation (usually Requirements or a dedicated Decision Log appendix entry) and reference it from other sections with a short label and link. The Status line gets a one-clause summary; other sections name the gate without re-explaining it. Telltale: "T&S commitment" or "Legal sign-off" appears 5+ times in the doc with the same expanded prose. The reader doesn't need to re-learn the gate each time it's mentioned.
A templated section can legitimately be brief, lean on cross-references, or contain only the content that fits its purpose; that is the writer being smart about structure, not failing to fill it.

ACTION: Reader-orientation in problem bullets. The closing sentence of a problem bullet orients the reader on the conclusion the bullet supports ("this RFC removes X so that does not happen"). Bullets that end on a stated fact and ask the reader to infer the recommendation fail at orientation.

ACTION: Avoid bureaucratic structural framings. When you find yourself coining "two valid trigger conditions," "three roles," "four scenarios," "the X clawback path / the Y clawback path," the framing is usually a substitute for integrating the content. Write the content directly. Telltale signal: a sentence that names categories and roles BEFORE stating the actual content, where the categorization adds no information beyond what the content alone would convey.

### Axiom 3 — Precision

RULE: Objective reality. Replace abstractions with concrete mechanisms; verify before asserting.

ACTION: Replace abstract nouns ("considerations", "issues") with concrete nouns ("budget cuts", "latency spikes"). Same applies to abstract quality-descriptor pairs used in place of a perceptual or behavioral description.
- WRONG: "The chip UX makes the restriction legible and recoverable: a selected category chip appears in the SERP."
- RIGHT: "The chip makes clear a filter is active: a selected chip appears in the SERP."

ACTION: Strip internal scaffolding when concrete content already carries the meaning. Phase numbers, sprint IDs, ATL/BTL labels, OKR codenames, P0/P1 prioritization tiers, and parenthetical status notes ("(timeline TBD)", "(scope TBD)") often survive from source docs. Apply the load-bearing test: would the reader need framework context to interpret this sentence, or do the concrete examples carry the meaning? If the latter, REMOVE the label and let the concrete content stand alone. If the architectural fact is known (e.g., two streams have no cross-dependency), state the fact instead.
- WRONG: "The chip UX and the ranker integration run in parallel (timeline TBD)."
- RIGHT: "The chip UX and the ranker integration have no cross-stream dependency; we can tackle each independently."

ACTION: Flag weasel words (might, could, possibly). CONVERT to definitive assertions backed by data, or [PLACEHOLDER] if data is missing.

ACTION: No invented data, quotes, or roadmap items. When context is missing, FLAG and ASK the user via AskUserQuestion. Inserting a plausible-sounding number, user quote, or future commitment is a fabrication that propagates through the document and into downstream decisions; the cost of asking is low, the cost of an undetected fabrication is high.

ACTION: Don't carry Slack shorthand or informal notes verbatim. Expand into plain language for the broader audience or ask the user for intent.

ACTION: Quantify "mixed", "varies", "depends" with ranges AND name the source of variance. Hedging without numbers is information loss; the reader needs anchors, not just a hedge label. When you know why a metric varies (different methodology, segment cut, time window, platform), name the dimension so the reader can interpret the spread rather than treat it as unexplained noise.
- WRONG: "Other categories show mixed direction (Real Estate, Motorbike) and need deeper analysis."
- RIGHT: "Real Estate ranges from +0.01% to -2.39% depending on calculation methodology (search-level vs item click-level), and Motorbike from -1.07% to flat."

ACTION: Convert passive voice to active. "We met our criterion" beats "Our criterion was met". Watch the missing-actor variant: a sentence using an intransitive construction with no named subject ("X goes to zero", "Y increases", "Z is removed") needs the actor named explicitly.
- WRONG: "Per-category threshold tuning goes to zero."
- RIGHT: "Search stops relying on manually-tuned per-category thresholds."

ACTION: Replace ambiguous pronouns ("it", "this", "they") with the concrete noun if the referent is not the immediately preceding noun. EXCEPTION: in a first-person memo authored by a named team member, "we" referring to the author's own team is unambiguous and preferred.
- WRONG: "Today, when Q2C is confident a query belongs to a category, it restricts the SERP to results from that category."
- RIGHT: "Today, when Q2C is confident a query belongs to a category, the filter restricts the SERP."

ACTION: Abstract action verbs ("condition on", "adapt experience", "gate on", "leverage", "support") need at least one worked example inline ("For example, X could do Y when Z"). If no concrete example is available, the claim is too vague to ship; REWRITE or DELETE.

ACTION: Incompatibility, dependency, or coupling claims between named system components need a concrete walk-through showing how the relationship manifests in a single concrete operation (a query, a request, a deployment step, a user action). The walk-through cashes out abstract component-talk into something the reader can simulate against their own model of the system.
- WRONG: "The semantic candidate set has no geographic shape, so the current disk pagination cannot share a candidate set with it."
- RIGHT: "Concretely: keyword retrieval today splits into two pages by distance (page 1 within the radius, page 2 beyond), while semantic retrieval returns the top K most similar items regardless of distance. Blending the two fairly requires merging the full keyword set with the semantic set in a single ranking pass; otherwise the user sees a first ranked block of (within-radius keyword + semantic) followed by a separate ranked block of beyond-radius keyword items."

ACTION: Mechanism before name. When introducing a domain term, system component, or named mechanism for the first time, EXPLAIN what it does (one sentence on mechanism + a concrete example) BEFORE using it as a noun in a consequence chain. A parenthetical gloss must describe mechanism (what the thing does), not role (what it is called or where it sits in the architecture).
- WRONG: "Make Q2C readable through LEGO (Search XP's component service) so consuming features can pull on it." ("Component service" is a role label.)
- RIGHT: "Make Q2C readable through LEGO (Search XP's service for managing SERP structure) so consuming features can pull on it."

The same rule fires in TL;DR list items when a proposed change is named without first stating the current-state mechanism being replaced. Open with what the current mechanism does (one short sentence), then describe the replacement (one short sentence). Multi-clause colon-chains that walk through classifier-signal framing, current consumption mechanism, threshold mechanics, and category exclusion in one breath are multi-idea; split.
- WRONG (under-elaborated): "**Ranker integration.** Replace the current per-category hard filter with Q2C as a ranking feature."
- RIGHT: "**Ranker integration.** The filter is yes/no: above the confidence threshold it fires, below it does nothing. The ranker integration replaces that gate: Q2C feeds the ranker, boosting results from the likely category without excluding others."

The rule also fires on abstractions the writer treats as self-evident inside a downstream argument ("the gate", "the bottleneck", "the mechanism") when the doc has not yet cashed out what the abstraction does.

ACTION: User-first framing for problem statements. When a problem has both a user-facing first-order impact and a team-facing or measurement-facing consequence, LEAD with the user-facing impact and POSITION the team-facing consequence as a downstream effect. The reader's first question is "what does this do to users?", not "what does this do to your dashboard?"
- WRONG: "Relevance metrics on ~19% of Spanish keyword searches are biased."
- RIGHT: "Buyers in Spain miss relevant items just past a hand-tuned radius on ~19% of keyword searches. Beyond the user-facing miss, every conversion measurement on the slice is conditioned on the hidden filter."

ACTION: Name teams and services precisely. DO NOT attribute actions to tribes, topics, or product areas ("Search does X", "Commerce decides Y") — tribes and topics are not actors. USE the specific team or service ("Search Core", "the QU service", "Search XP"). If the specific owner is unknown, USE passive voice or flag the gap rather than collapsing to the topic name.

ACTION: Use team or role names in body prose, not person names. Person names belong in the Stakeholder table, Open Questions / Decisions where the named person is the answer-holder, attribution lines for sign-offs ("Legal sign-off required") and Document History entries. They do NOT belong in body prose describing requirements, dependencies, gates, or status. The reader of a PRD shouldn't need to know who Alex or Jamie is to parse the spec; the role (Trust & Safety backend, Legal & Privacy) carries the meaning. Person-tagging happens in Jira / Confluence comments, not in the PRD body.
- WRONG: "Phase 1 ships once Alex's two P0 commitments land."
- RIGHT: "Phase 1 ships once Trust & Safety's two P0 backend commitments land."
- WRONG: "Pending Jamie Patel's review on {{LEGAL_TICKET_ID}}."
- RIGHT: "Pending Legal review on {{LEGAL_TICKET_ID}}." (Jamie Patel's name appears in the Stakeholder table row.)
- WRONG (in a Status line): "Gated on Trust & Safety roadmap commitment from Alex Chen and Legal UXW approval from Jamie Patel."
- RIGHT: "Gated on Trust & Safety roadmap commitment and Legal UXW approval."
The exception is canonical attributions where the person IS the entity (e.g., "X €120M fine" — X is the company name, not a person).

ACTION: Layer/stage/role discipline. When a system has named layers, stages, components, or roles with distinct functions (retrieval vs ranking, frontend vs backend, query understanding vs query execution, L1 vs L2), DO NOT lump items from multiple layers under a single layer's label, even if they share input or theme. The architectural distinction is the same one the system's documentation, owners, and code make; flattening it produces a category error.
- WRONG: "Three uses of distance in the retrieval layer" (when one is in retrieval and two are in L1 scoring).
- RIGHT: "Distance enters at two layers, retrieval and L1 scoring, with the following uses at each."

ACTION: In strategy documents, state technical dependencies in product-level consequences, not implementation mechanics.
- WRONG: "We must confirm routing and result-restriction are separable in the code."
- RIGHT: "We must confirm that removing result restriction does not break vertical routing."

ACTION: Never describe a known degradation as "acceptable." State the mitigation plan instead.
- WRONG: "An acceptable regression to address separately."
- RIGHT: "The chip UX is the planned restoration."

ACTION: Replace relative time references ("this window", "this sprint", "this quarter", "right now", "today") with absolute anchors: a specific quarter (Q2 2026), a calendar date, or an event anchor ("after the retrain lands", "before the ranker integration experiment"). Match date precision to temporal distance: ~1 year out → halves or quarters; ~1 quarter out → months; ~1 month out → weeks or specific date.

ACTION: DO NOT coin neologisms or metaphorical compound nouns to sound technical. Banned forms: compound adjectives borrowing imagery ("category-convicted", "null-by-dilution", "catastrophe-prone"); noun phrases borrowing imagery from launch windows, runways, drum beats, geometry, architecture ("compatibility window", "transition runway", "rollout cadence", "alignment surface", "decision corridor"); compound names invented in the moment to refer to a system component the doc has been discussing ("hard-filter mechanism", "binary gate" used as a standalone defined term). USE established vocabulary or plain prose. "Queries where the SERP is restricted to a single category" beats "category-convicted queries"; "the filter" beats "the hard-filter mechanism". Telltale signal: a hyphen between a concrete adjective and a noun where the writer is naming a system component on the fly. If the phrase did not exist before this sentence, prefer the bare noun.

ACTION: DO NOT use tech-bro verb-particle idioms in audience-facing prose: *stand up* (a service/measurement), *spin up* (an instance/effort), *wire up* (an integration/dependency), *tear down* (a stack/setup). These are infrastructure verbs that signal in-group engineering register and read as informal jargon to non-engineering readers. REPLACE with plain English: *establish, set up, start, build, integrate, connect, dismantle*. Telltale signal: an "X up/out" verb-particle that originated in engineering tooling and would not appear in a CEO memo. (Not banned: well-established business idioms like *kick off* (a project) and *roll out* (a feature).)

ACTION: Mechanism-implying adjectives need evidence: *hand-tuned, learned, automated, manually-curated, hard-coded, dynamic, derived, computed, inferred, heuristic, rule-based, data-driven, bounded*. Apply the verification check before using any of them: do you have evidence of how this thing was derived or maintained? "Bounded" implies a mathematically verified upper limit; if the actual claim is that the impact is measurable or observable, use "measurable" instead. If unverified, REPLACE with a neutral descriptor that names the artefact without claiming a method. *Per-keyword radius* beats *hand-tuned radius* until manual curation is confirmed; *51,666-keyword list* beats *manually-curated list* until you've confirmed the list is hand-built; *measurable and recoverable* beats *bounded and recoverable* until a mathematical bound is established.

ACTION: Terminology lock. Once a term is established in the document or session (e.g., "no-harm criterion", "search-to-transaction"), DO NOT drift to a synonym without basis. Substitutions either preserve the exact phrasing or are deliberate choices the writer can defend. Telltale signal: a fix-loop edit that swaps an established term for a "punchier" alternative ("no-harm bar" replacing "no-harm criterion"). When in doubt, search the document; if the term appears more than once in the existing draft, treat it as locked.

ACTION: Verify claims about organizational reality, and ask when you cannot. Claims about funding, prioritization, roadmap status, or critical-path positioning of named workstreams ("X is funded for 2026", "Y is on the critical path", "Z is prioritized for H1") are factual assertions about the organization that the user owns, not the writer. They require a verifiable source: a plan doc, leadership comms, a roadmap entry, a strategy memo. If you cannot cite a source, do NOT silently hedge, downgrade, or remove on the user's behalf. ASK the user via AskUserQuestion. The same rule applies to structural relationships between named entities (parallel workstreams, subset/superset, sequential dependency, blocking, ownership): treat parallelism as a claim that needs evidence, not a default.

### Axiom 4 — Calibration

RULE: Match tone to stakes. Frame problems as opportunity costs or maintenance debt when the system has been operating in the criticised state for an extended period (e.g., > 12 months without escalating failure). Reserve crisis framing for genuine crises: novel failures, escalating incidents, recent regressions, or imminent deadlines.

ACTION: Could-we-continue test. Before writing any pain framing in a problem statement, ASK: "Could we continue under these circumstances?" IF YES, the framing MUST acknowledge it explicitly ("the team has run this way for years; the cost is..." or "the marketplace has worked this way; the trade-off is..."). Skip the acknowledgment ONLY when the failure is new, novel, or actually escalating.

ACTION: STRICT: Banned default verbs in problem framing UNLESS the verb's plain-English meaning is literally true: *burn, hurt, lock out, stall, block, cripple, kill, destroy, inject(s), poison, infect, flood, choke, strangle*. The unifying pattern: the verb personifies a passive source (a catalog, a feedback loop, an architecture) as an active aggressor when in plain truth the source merely *contributes* or *adds* the cost. Apply the literal-truth check: "Is the catalog literally injecting noise into a target, the way a syringe injects fluid? Are buyers actually being hurt? Is capacity actually being burned?" If no, REPLACE with cost-naming neutrals: *carries, incurs, contributes, adds, delays, complicates*. The set is illustrative, not exhaustive; any verb that shares the personifying-an-aggressor shape (a system component as the grammatical subject of a forceful transitive verb) triggers the same check.
- WRONG: "{{COMPANY}} user-generated catalog injects classification noise that even a perfectly retrained classifier cannot remove."
- RIGHT: "{{COMPANY}} user-generated catalog adds classification noise that even a perfectly retrained classifier cannot remove."

ACTION: For systems live > 12 months, default framings are: opportunity cost ("the 2026 plan benefits from removing this coupling"), maintenance debt ("the team would rather invest the maintenance budget elsewhere"), or measurability gap ("the affected slice is unreadable for the metrics revamp"). Crisis framing on a multi-year-stable system is a calibration failure.

ACTION: When correcting an over-dramatic draft, DO NOT swing to nothing-burger. The fix to over-claiming is calibration (state the cost in plain terms), not deletion (lead with throat-clearing about the marketplace working). Track both edges; calibrated prose names the cost AND acknowledges the status quo is operable, in the same breath.

ACTION: Cost-naming traces to observed signal, and ask when no signal is available. When framing a cost from staleness, drift, decay, or shift, NAME the observed data signal showing that cost (the data points, the trend, the gap, the rising metric). Default templates ("the world has moved on", "drift accumulates", "behaviour has shifted") are uncalibrated when the underlying data is stable. The cost may instead be maintenance debt, opportunity cost, or scaling mismatch; if you cannot point to evidence for the alternative framing either, ASK the user via AskUserQuestion which framing matches the actual cost.

ACTION: Cross-section severity coherence. After adding a concrete walk-through to one section ("Why now", "Risks", "Technical Appendix"), RE-CHECK any higher-level framing summarizing the same issue (lead, problem statement, executive summary). If the elaboration reveals the issue is MORE severe than the higher-level implies, the higher-level is now understated and must be updated to match. Calibration is not a once-per-section property; it must hold ACROSS sections framing the same issue at different abstraction levels.

ACTION: Pressure/urgency framing requires trajectory data. When a sentence claims a current pressure ("catalog growth pressure", "scaling pressure", "load is climbing", "this is becoming binding"), NAME the observed trajectory data showing the pressure (a CAGR, a year-over-year delta, a metric crossing a threshold). If no such data exists or the trajectory is stable, the framing is overcalibrated; REFRAME as future-contingent risk and insert a [PLACEHOLDER: trajectory metric] for the writer to fill in, OR ASK the user.
- WRONG: "Catalog growth pressure on retrieval architecture" (when Spain catalog CAGR has been stable).
- RIGHT: "Catalog scale-out is a future risk, not a current pressure. Catalog CAGR over [PLACEHOLDER: last N years] has been stable at [PLACEHOLDER: X%]; the disk pagination would, however, block any future scale-out work if growth ever accelerates."

ACTION: Adjacent-workstream inflation check. Each downstream consequence in a problem bullet must (a) trace causally to the same first-order harm in the bullet's header AND (b) be material on its own merits. Apply the substitution test: "would I write this consequence if the workstream had a different name?" If the consequence reads as a name-drop to bulk up importance, CUT unless both the causal trace and the material stake are verified.

## Final-pass scan (mandatory before claiming done)

Scan the full draft systematically. Don't rely on the user catching violations.

| Check | What to scan for |
|---|---|
| Em-dashes | `—` should return zero hits in prose |
| Coined hyphenations / metaphor compounds | Compounds not in standard English; prefer unhyphenated form |
| Adverbs modifying verbs | -ly words and disguised adverbs ("actively", "consistently") — delete or strengthen the verb |
| Weasel words | might, could, possibly, TBD |
| Passive voice | "is X-ed by", "was Y-ed", missing-actor intransitives |
| Long sentences | 2+ subordinate clauses or multi-colon mechanism chains → split |
| Paragraph length | >4 sentences → split or bullet; "not recommended" rationales especially |
| Acronym definitions | Every acronym defined on first body use. Sweep operational (KTLO, OKR, BAU, SLO) and product/metric (PI, BFM, SRR, TRX) |
| Pronoun referents | "It", "this", "they" — replace with the concrete noun if ambiguous |
| Mechanism-implying adjectives | hand-tuned, learned, automated, dynamic, derived, bounded — evidence-backed or replaced |
| Metric naming | Rates named as rates, not as counts |
| Verdict-first | Launch criteria and recommendations lead with status |
| Self-contained hypothesis | "The hypothesis that [X] was [confirmed/not confirmed]" |
| Internal scaffolding | Phase/sprint/tier labels (Phase 1, ATL/BTL, P0/P1), "(timeline TBD)" status notes |
| Section header form | No interrogative ("Why X"), no contrastive ("X, not Y") — assertion only |
| Dangling colon-then-bullet | Each bullet adds mechanism, number, or worked example the framing did not contain |
| Banned hyperbolic verbs | burn, hurt, lock out, stall, block, kill, inject, poison, flood, choke — literal-truth check |
| TL;DR redundancy sweep | Run all four removal tests on every TL;DR sentence |
| Forward references in TL;DR | Non-load-bearing named components — replace with generic descriptors |

## Output discipline

- First-person plural ("we tested", "we observed") for team-authored artefacts.
- Always include actual metric values, never just "guardrails were met".
- For non-trivial design or implementation choices, use AskUserQuestion rather than resolving silently.
- End responses with the next action or question, not a recap of what was done.

## Failure modes to avoid

- **Reactive style fixes.** When a violation is caught, re-scan the rest of the doc for parallel violations.
- **"Complete" claims without the final pass.** Saying "all placeholders filled" is not the same as confirming the final-pass scan ran.
- **Skipping the glossary.** When in doubt about a {{COMPANY}} term, check `{{KNOWLEDGE_BASE_PATH}}/GLOSSARY.md` before asking the user.
- **Skipping the TL;DR redundancy sweep.** TL;DRs accumulate redundancy faster than any other section; the four removal tests are non-negotiable.
- **Treating fidelity as no-facts-deleted.** Moving a fact strips its surrounding context; verify the new location still parses standalone.
