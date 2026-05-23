# CSO self-review rubric

Apply this rubric in Step 2 of the post-experiment-report skill. The Chief Science Officer's job is to keep the report epistemically honest, factually accurate, and accessible to a company-wide audience. The seven principles cluster into three categories: scan the draft once per category.

> The "Cannot vs. underperforms" precision rule lives in `pm-writing-standards`'s cross-cutting rules; do not duplicate it here. Run `pm-writing-standards`'s final-pass checklist alongside this rubric.

---

## 1. Epistemic discipline

### 1.1 Distinguish observation from interpretation, and fact from hypothesis

Frame all causal explanations as hypotheses ("We hypothesize that...", "This suggests..."), never as proven facts. Conversely, distinguish what is mathematically, geometrically, or mechanically derivable (state as fact) from what is empirically uncertain (state as hypothesis). Claims like "a more vertical aspect ratio crops horizontal images more aggressively" or "a taller card reduces items per viewport at fixed page height" are facts, not hypotheses; the hypothesis lives in the *causal claim about behavior or outcome* downstream of the fact.

- WRONG: "consistent with the hypothesis that 4:5 crops horizontal images more aggressively than ~5:6"
- RIGHT: "4:5 mathematically crops horizontal images more aggressively than ~5:6; the data is consistent with that cropping driving buyer engagement."

### 1.2 Scope conclusions to data

Avoid superlatives ("critical", "key"). Scope claims strictly to what the data supports — do not extrapolate beyond what the numbers show.

**Specific failure mode — unverifiable groupings.** When grouping items (categories, segments, query types) to support a hypothesis, only include items whose grouping attribute is cleanly verifiable.

- WRONG: claiming "Cars, Tech, and Motorbike are horizontal-imagery categories that regressed" when Tech is mixed-orientation (laptops/TVs horizontal, phones/tablets vertical); the grouping survives because it sounds clean, but a reader who knows the catalog will catch the mismatch.
- RIGHT: claim only the unambiguous members ("vehicle categories with uniformly horizontal photos: Cars, Motorbike") and explicitly call out that mixed-orientation categories show mixed results without a clean pattern.

The fix is structural: name the unambiguous extremes, then bucket the middle as "mixed" rather than forcing it into the framing.

### 1.3 Challenge unsubstantiated assertions

If a claim isn't supported by the data, reframe it as a hypothesis or flag it. Sentences like "users prefer X" or "this drives Y" need either a number or a "we hypothesize" prefix. Synthesized launch rationales — fluent narratives stitched together from metric movements that fit a story — are the most damaging form of this failure: they read as "the data supported it" but the writer chose which data to elevate. Apply specifically to the **launch rationale**: if the rationale appears to be reverse-engineered from the dashboard rather than supplied by the user, ASK before keeping it.

---

## 2. Factual accuracy

### 2.1 Verify variant scope before asserting isolation

Before claiming the variant is identical to Baseline except for X, or that the experiment isolates X, verify the actual scope of changes from the implementation, screenshots, or PRD. Bundled changes are common, especially when a new component is rolled out alongside layout updates. An unverified isolation claim propagates downstream into the hypothesis statement, the no-harm framing, and the Durable Learnings, where it forces the reader to take the variant's purity on faith.

- WRONG: "Variant A used the new component, with visual presentation and information held identical to Baseline so this was a do-no-harm test of the swap itself" (when the variant actually bundled a new aspect ratio, element reordering, and a repositioned button).
- RIGHT: "Variant A used the new component, with a refreshed visual layout (4:5 aspect ratio, title above price, favorite button on the image). We treated this as a do-no-harm experiment, expecting flat key metrics from the bundled change."

### 2.2 The "no data" false hedge

Before writing "we lack data X" or "we cannot verify Y" as a hedge, check whether X or Y exists in source material already cited in the report — the PRD, dashboards, analysis docs, Vision pages, or any Confluence page referenced in the header. Hedging on missing data is only honest if the data is actually missing; otherwise it falsely shifts the gap from your verification effort onto the data, which is more damaging than the original unsupported claim.

- WRONG: writing "we cannot cleanly attribute their movement to the orientation hypothesis without category-level orientation data" when the by-category orientation distribution is in the PRD's appendix that the report already links to.
- RIGHT: fetch the data, apply it, and tighten or refute the claim.

---

## 3. Audience accessibility

### 3.1 Define complex concepts clearly

Explain any non-obvious concept in simple terms on first use. Internal system names, technical implementation details, and named components all need a one-clause plain-language gloss before being used in a consequence chain.

### 3.2 Expand informal shorthand

Pay special attention to phrases sourced from informal communications (Slack messages, notes, verbal summaries): these often compress organizational knowledge into shorthand the author understands but a company-wide reader does not. Either expand into plain language or ask the user to confirm the intended meaning before including. Do not carry informal shorthand into the report verbatim.
