# Question Types — When to use each

This reference covers every question format you'll commonly need for assumption-validation surveys, when to use it, and how it maps to Typeform fields. Pick the format that fits the **evidence you need**, not the one that feels comfortable.

## Table of Contents

1. [Closed single-select (multiple choice)](#closed-single-select)
2. [Closed multi-select (checkboxes)](#closed-multi-select)
3. [Likert scale (agreement)](#likert-scale)
4. [Bipolar semantic differential](#bipolar-semantic-differential)
5. [Frequency scale](#frequency-scale)
6. [Intent/Likelihood scale](#intent-likelihood-scale)
7. [Ranking (full list)](#ranking)
8. [MaxDiff (forced-ranking)](#maxdiff)
9. [Open-ended short text](#open-short)
10. [Open-ended long text ("why")](#open-long)
11. [Scenario-based multiple choice (mental model test)](#scenario)
12. [Unaided recall followed by aided recognition](#recall-recognition)
13. [Numeric / slider](#numeric-slider)

---

## <a name="closed-single-select"></a>1. Closed single-select (multiple choice)

**When to use:** Measuring categorical behavior or a discrete choice with mutually exclusive options.

**Typeform field:** Multiple Choice (single)

**Example (good):**
> In the last 30 days, how many times did you open the {{COMPANY}} app?
> - 0 times
> - 1–5 times
> - 6–15 times
> - 16–30 times
> - More than 30 times

**Rules:**
- Options must be mutually exclusive and collectively exhaustive (MECE).
- For frequency, use non-overlapping bands.
- Include "I don't know" or "I don't remember" if recall is plausibly weak.
- Order options logically (ascending/descending). Randomizing here destroys comparability.

**Avoid:**
- Overlapping buckets ("1–5" and "5–10").
- Options that mix dimensions ("Often", "In the mornings", "For work") — each option must answer the same question.

---

## <a name="closed-multi-select"></a>2. Closed multi-select (checkboxes)

**When to use:** When multiple answers can be simultaneously true (barriers, features used, reasons).

**Typeform field:** Multiple Choice (multi)

**Example (good):**
> Which of the following stopped you from creating a list? Select all that apply.
> - I didn't notice the Saved Items feature option
> - I didn't understand what the feature was for
> - It felt like too much work
> - I already organize my items another way (in my head, in notes, etc.)
> - I didn't think it would be useful
> - Something else
> - I don't remember

**Rules:**
- Always randomize option order (except the "escape hatches" which stay pinned to the bottom).
- Cap at ~7 options before randomization fatigue kicks in.
- Pair with a follow-up single-select ("Which was the single biggest reason?") to force a priority among multi-selected items.

**Avoid:**
- Using multi-select when you actually need a ranking. Multi-select can't tell you which reason mattered most.

---

## <a name="likert-scale"></a>3. Likert scale (agreement)

**When to use:** Measuring attitudes, perceived value, or subjective evaluation of a statement.

**Typeform field:** Opinion Scale (5-point or 7-point) or Multiple Choice with labeled options.

**Default:** 7-point balanced scale:
1. Strongly disagree
2. Disagree
3. Somewhat disagree
4. Neither agree nor disagree
5. Somewhat agree
6. Agree
7. Strongly agree

**Example (good):**
> How much do you agree with the following statement?
>
> "Organizing my favorite items would help me decide what to buy."
>
> [1 — Strongly disagree … 7 — Strongly agree]

**Rules:**
- Use 7-point for attitudinal depth; 5-point for quicker/lighter surveys. Odd number gives a neutral midpoint (respect respondents' right to have no opinion).
- Label endpoints always; labeling every point improves data quality but increases cognitive load.
- Write the statement neutrally — don't embed the conclusion you're hoping to confirm.

**Avoid:**
- Asymmetric scales ("Great / Good / OK / Bad") that bias upward.
- Double-barreled statements ("the feature is useful AND easy to use").

---

## <a name="bipolar-semantic-differential"></a>4. Bipolar semantic differential

**When to use:** Measuring where a product/feature sits between two opposing attributes.

**Typeform field:** Opinion Scale with custom endpoint labels.

**Example:**
> How would you describe the Saved Items feature feature?
>
> Confusing [1–7] Clear
> Useless [1–7] Useful
> Too much work [1–7] Effortless

**Use for:** Capturing gestalt impressions efficiently. Three differentials ≈ one Likert block but richer signal.

---

## <a name="frequency-scale"></a>5. Frequency scale

**When to use:** Measuring how often something happens.

**Typeform field:** Multiple Choice (single)

**Example:**
> How often do you favorite items on {{COMPANY}}?
> - Never
> - Less than once a month
> - 1–3 times a month
> - About once a week
> - Several times a week
> - Daily or almost daily

**Rules:**
- Anchor in specific time frames, not adjectives.
- "Sometimes", "rarely", "often" mean different things to different people. Avoid.

---

## <a name="intent-likelihood-scale"></a>6. Intent / Likelihood scale

**When to use:** Measuring behavioral intent or purchase intent.

**Typeform field:** Opinion Scale (5-point labeled) or NPS-style 0–10.

**Example:**
> How likely are you to create a list for your next big purchase on {{COMPANY}}?
> - Definitely will not
> - Probably will not
> - Might or might not
> - Probably will
> - Definitely will

**Caveat:** Intent scales consistently overestimate actual behavior — discount by ~50% for "Probably will" and ~20% for "Definitely will" when estimating real-world uptake. Use intent as *relative* signal, not absolute.

---

## <a name="ranking"></a>7. Ranking (full list)

**When to use:** When the user needs to express priorities across a small (≤5) set of items.

**Typeform field:** Ranking

**Example:**
> Drag to order the following from most important (1) to least important (5) when deciding what to buy:
> - Price
> - Seller reputation
> - Product condition
> - Shipping cost and speed
> - Photos and description quality

**Rules:**
- Cap at 5 items. Beyond that, completion rates crash and data gets noisy.
- For >5 items, use MaxDiff instead.
- Don't force ranking when a respondent might legitimately not care about some items.

---

## <a name="maxdiff"></a>8. MaxDiff (forced-ranking)

**When to use:** Comparing many items (6–15) on preference/importance. Discriminates between items far better than Likert.

**Typeform field:** Multiple Choice blocks in sequence. Typeform doesn't have a native MaxDiff field — simulate with 3-at-a-time "most / least appealing" rounds.

**Example pattern:**
> Round 1 of 4. Of these three statements about the feature, which is MOST appealing to you?
> - "Organize your favorites"
> - "Compare items for your next purchase"
> - "Save items to decide later"
>
> And which is LEAST appealing?
> - [same three options]

Design rule: each item appears 3–4 times across rounds, in varying combinations. For 6 items, use 4–6 rounds.

**Output:** Utility scores ranked — each item's "most appealing" count minus "least appealing" count, normalized. This gives you a defensible preference ordering.

**Use for:** Value prop / messaging / naming decisions. Much stronger than "which of these taglines resonates most?" asked in Likert.

---

## <a name="open-short"></a>9. Open-ended short text

**When to use:** When you need a specific factual answer that can't be pre-enumerated.

**Typeform field:** Short Text

**Example:**
> If you could rename the feature to something else, what would you call it?
>
> [single line]

**Rules:**
- Keep short-text questions to 1–3 per survey. They require more cognitive work than closed questions.
- Pre-commit to how you'll analyze them (word clouds, clustering, coding into themes).

---

## <a name="open-long"></a>10. Open-ended long text ("why")

**When to use:** Capturing the *motivation* behind a closed-question answer. This is where most of the insight comes from.

**Typeform field:** Long Text

**Example:**
> You said you didn't create a list. In your own words, what was going through your mind at that moment?

**Rules:**
- Always pair with a closed question — the closed answer gives the "what", the open answer gives the "why".
- Ask for specific moments ("take me back to that moment") rather than abstract rationale — triggers episodic memory, produces less sanitized responses.
- Cap at 2–3 long-text questions. More than that and completion rates collapse.
- Frame neutrally: "In your own words, why…" not "Why didn't you…" (which presupposes reluctance).

---

## <a name="scenario"></a>11. Scenario-based multiple choice (mental model test)

**When to use:** Testing whether users understand how something works — without giving them the answer.

**Typeform field:** Multiple Choice (single) with a setup paragraph.

**Example:**
> Imagine you've added 5 items to your Favorites and put 3 of them into a list called "Kitchen stuff." Then you delete one of the items from "All Favorites."
>
> What do you think happens to that item in your "Kitchen stuff" list?
> - It stays in the list
> - It's removed from the list
> - It becomes greyed out
> - I'm not sure

**Rules:**
- The correct answer should not be obviously "right" by the wording — distractors must be plausible.
- Place mental-model questions BEFORE any question that teaches the answer.
- "I'm not sure" is essential — without it, users guess, and you can't distinguish knowledge from chance.

---

## <a name="recall-recognition"></a>12. Unaided recall followed by aided recognition

**When to use:** Measuring awareness. This is the only correct way to measure it.

**Pattern:**

**Q1 (Unaided):**
> When you think about the {{COMPANY}} Favorites section, what features or things can you do there? List whatever comes to mind.
>
> [long text]

**Q2 (Aided, only shown AFTER Q1 is submitted):**
> Have you seen or used any of the following in {{COMPANY}} Favorites? Select all that apply.
> - The "Items" tab
> - The the feature tab
> - The "Searches" tab
> - Recommendations inside a list
> - None of these
> - I'm not sure

**Why this order matters:** Showing the aided list first tells respondents what exists, inflating claimed awareness. Unaided-first captures real top-of-mind recall.

---

## <a name="numeric-slider"></a>13. Numeric / slider

**When to use:** Capturing continuous numeric values (count, percentage, price).

**Typeform field:** Number

**Example:**
> Roughly how many items do you currently have in your Favorites on {{COMPANY}}?
>
> [number input]

**Rules:**
- Prefer bucketed single-select when the respondent is unlikely to know the exact number (few people know their exact favorites count — offer bands instead).
- Use numeric when the precise value matters (price willing to pay, age, etc.).

---

## Quick decision guide

| You need to know… | Use |
| --- | --- |
| How often something happens | Frequency scale (#5) |
| Which of N things stopped them | Multi-select + follow-up single-select (#2) |
| Whether they value something | Likert agreement (#3) |
| Which of many framings wins | MaxDiff (#8) |
| Whether they'll do something | Intent scale (#6, discount for optimism bias) |
| Why they did / didn't do something | Open-ended "why" (#10) paired with closed prior |
| Whether they understand a mechanic | Scenario multiple choice (#11) |
| What they remember about a feature | Unaided → aided (#12), never aided alone |
| Their priority order among 3–5 items | Ranking (#7) |
| Their priority order among 6–15 items | MaxDiff (#8) |
