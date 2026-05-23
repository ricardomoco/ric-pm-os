---
name: ur-survey-creator
description: Generate a Typeform-ready user research survey (markdown) from a Research Plan to validate assumptions, hypotheses, and research questions. Use whenever the user wants to create a UR survey, pre-interview survey, assumption-validation survey, screener, or any structured questionnaire derived from a research plan, discovery doc, or validation brief — even if they don't say the word "survey" (e.g. "I need questions to test these assumptions", "validate this with 500 users", "pre-interview Typeform for my cohorts").
---

# UR Survey Creator

Generate a high-quality, Typeform-ready markdown survey from a Research Plan. Every question must be traceable to a research question, hypothesis, or assumption from the plan. The survey should stand up to post-hoc scrutiny: no leading questions, no double-barreled items, no invented methodology.

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the research topic and any Confluence/Jira references the user provided (the Research Plan, parent PRD, prior research). Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as the checklist of what to ask the user or flag in the output. Skip only if the user has already supplied a kb-grounder synthesis, or the plan is fully provided inline.

## Core principle

**Survey questions are hypotheses wearing question marks.** Each question exists to gather evidence that will move a specific assumption from "unvalidated" toward "supported" or "refuted." If a question doesn't map back to the plan, delete it.

## Workflow

Follow these steps. Don't skip ahead — the earlier steps are how you avoid generating generic questions.

### 1. Load the research plan

The user will provide the plan as one of:
- A Confluence URL → fetch via the Atlassian MCP (`getConfluencePage`)
- A local markdown file → read it
- Inline text/conversation context → use what's given

After fetching any external resource, log it to `knowledge-base-reference.md` per the workspace protocol (see CLAUDE.md).

### 2. Extract the survey substrate

Before writing a single question, extract and list these from the plan:

- **Research questions** — what the research is trying to learn
- **Hypotheses** (H1, H2…) — what we believe will turn out to be true
- **Critical assumptions** — with type (Desirability / Usability / Viability / Feasibility) and risk level
- **Target cohorts** — with behavioral definitions and the "why" each cohort is being studied
- **Quant findings already known** — drop-off points, conversion rates, prior data
- **Deliverables / decisions the survey will inform**

If any of these are absent or vague in the plan, **flag the gap to the user before proceeding**. Do not invent cohorts, assumptions, or prior data.

### 3. Decide survey scope

Ask or infer:
- **One survey for all cohorts, or one per cohort?** If the cohorts have divergent experiences (e.g. "never saw the feature" vs. "saw it and rejected it"), use per-cohort surveys — the questions a C1a respondent can answer are different from C1b.
- **Length target** — default to <8 min, ~12–18 questions max per cohort survey. Longer surveys tank completion rates.
- **Role in the research sequence** — standalone validation survey, or pre-interview screener feeding into qualitative? This changes question density and open-ended ratio.

### 4. Map assumptions → questions

For each assumption/hypothesis, design 1–3 questions that will produce evidence. Use this decision pattern:

| Assumption type | Best question format |
| --- | --- |
| Behavioral ("users do X") | Past-behavior closed question with concrete time anchor ("In the last 30 days, how many times did you…") |
| Attitudinal ("users value X") | Bipolar Likert (7-point) + open-ended "why" |
| Preference between framings ("users prefer X over Y") | MaxDiff forced-ranking (3-at-a-time rounds) |
| Awareness ("users know X exists") | Unaided recall open question FIRST, then aided recognition — never aided-first, it leaks |
| Mental model ("users understand X") | Scenario-based multiple choice ("If you deleted an item from 'All Favorites', what would happen to…") |
| Barrier ("X stops users from Y") | Multi-select barriers list + "Other" + follow-up "which was the single biggest reason?" |
| Intent ("users would do X") | Purchase-intent or behavioral-intent scale + "what would need to change" open |

Always pair closed-ended assumption tests with an open-ended "why" for the 1–2 highest-risk assumptions. Closed questions count the votes; open questions explain the motivation.

**Detailed question-type guide:** `references/question-types.md`

### 5. Apply UR best practices

Run every draft question through `references/best-practices.md` before finalizing. Non-negotiable rules:

- No leading language ("How easy was…" presumes easy)
- No double-barreled ("Was it fast and clear?")
- Balanced scales (equal positive/negative anchors, labeled endpoints minimum)
- MECE option lists (mutually exclusive, collectively exhaustive) with "Other" + "Prefer not to say" where relevant
- Concrete time anchors ("in the last 30 days") over vague ones ("recently")
- Neutral order — randomize multi-select option order in Typeform; put "Other/None/Don't know" last
- No jargon the respondent doesn't share (internal feature names, analytics terms)
- No questions the respondent can't possibly answer (e.g. "Why didn't you use Feature X" to a user who never saw it)

### 6. Structure the survey

Use the template at `assets/survey-template.md`. Every survey includes:

1. **Intro block** — who you are, why this matters to respondent, estimated time, consent/anonymity statement, incentive if any
2. **Screener questions** — 1–3 qualifying items to confirm cohort fit (even when recruiting from pre-defined Amplitude cohorts, a soft screener catches mis-recruits)
3. **Warm-up** — one easy, low-stakes question about current behavior (anchors the respondent in the right context)
4. **Assumption blocks** — grouped by the assumption they test, with a one-line "What we're testing" comment for the PM (not shown to respondent)
5. **Closing block** — demographics (only if needed for segmentation), open "anything else we should know?", thank-you

### 7. Annotate each question

In the markdown output, every question gets a metadata prefix the PM can read but that won't be pasted into Typeform:

```
<!--
Tests: Assumption 1 (Chore Barrier) | H2
Cohort: C6 (Heavy Favoriters, Non-Adopters)
Type: 7-point Likert + open follow-up
Rationale: Captures subjective effort-vs-value trade-off; open follow-up gives the "why"
-->
```

This traceability is the difference between a survey that survives stakeholder review and one that gets rewritten.

### 8. Handle per-cohort splits

If the user asked for cohort segmentation (or you decided it's needed in step 3):

- One markdown file per cohort, OR
- One markdown file with clearly delimited sections (`## Cohort C1a — Unaware Non-Adopters`)

Default to the single-file approach unless the user says otherwise — easier to review side by side.

Across cohort surveys, reuse a **shared closing block** (demographics + cross-cohort questions like the "where do you save items to consider" competitive framing) so results are comparable.

### 9. Self-review pass

Before handing over, read the whole survey once more and check:

- Does every question trace to an assumption/hypothesis/RQ from the plan? If not, delete it.
- Can the target respondent actually answer every question? (Unaware users can't tell you why they didn't create a list.)
- Is there at least one open-ended "why" for each high-risk assumption?
- Is completion time ≤8 min? Estimate at ~20–30s per closed question, ~60–90s per open.
- Did you include the intro, screener, and closing blocks?
- Is the tone consistent with respondent-facing copy (conversational, not internal jargon)?

## Output

Return the survey as markdown. Do not attempt to actually create the Typeform — that's a human copy-paste step. Do include a short preamble at the top of the file listing:

- Source plan (link/path)
- Cohorts covered
- Estimated completion time
- Total question count
- Assumptions/hypotheses covered (with a mapping line per assumption)

## Reference files

- `references/question-types.md` — when to use each question format, with examples
- `references/best-practices.md` — anti-patterns and the "why" behind each rule
- `assets/survey-template.md` — the markdown structure for output
- `assets/example-pmf-survey.md` — a gold-standard reference survey built from a real {{COMPANY}} research plan; read this when you need a worked example of what "good" looks like

## When the plan is thin

If the research plan is missing assumptions, cohorts, or research questions, **do not paper over the gap with generic questions**. Instead:

1. List the specific gaps to the user ("The plan lists H1 and H2 but no explicit assumptions")
2. Offer to either (a) proceed with what's there and flag the under-tested areas, or (b) help the user augment the plan first
3. Let the user choose

A survey built on an incomplete plan produces data that can't answer the real questions. Better to pause than to generate questions that feel like they came from a template.
