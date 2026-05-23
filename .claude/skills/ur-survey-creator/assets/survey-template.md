# [Survey Title] — [Cohort Name]

<!--
## PM-FACING PREAMBLE (do not paste into Typeform)

**Source research plan:** [link or path]
**Cohort(s) covered:** [e.g. C1b — Aware Non-Adopters]
**Recruitment source:** [Amplitude cohort / CRM / in-app intercept]
**Estimated completion:** [X min]
**Total questions:** [N]
**Target N:** [150+ responses]
**Launch date:** [YYYY-MM-DD]

### Assumptions / hypotheses covered
- **A1 — [Name]:** tested by Q[x], Q[y]
- **A2 — [Name]:** tested by Q[z]
- **H1 — [Name]:** tested by Q[a], Q[b]

### Assumptions intentionally NOT covered
- **A[n] — [Name]:** out of scope for this cohort because [reason]
-->

---

## Intro (Typeform Welcome Screen)

Hi! Thanks for helping us improve {{COMPANY}}.

We're running a short research study on [topic] and your answers will directly shape what we build next. You were invited because you [cohort description in plain language].

- **Time:** About [X] minutes
- **Anonymity:** Your answers are anonymous and used only for research
- **No right or wrong answers** — we want your honest view

[Start button]

---

## Block 1 — Screener (if needed)

> Q1. [Screener question confirming cohort fit]
>
> [options]

<!--
Tests: Cohort qualification (not an assumption)
Type: Single-select
Logic: If answer = [X], end survey with "Thanks, this study is for users who [criteria]"
-->

---

## Block 2 — Warm-up

> Q2. [Easy, low-stakes question anchoring the respondent in the right context]
>
> [options]

<!--
Tests: Context-setting only
Type: [e.g. Frequency scale]
Rationale: Warm-up builds commitment and primes the respondent to think about the right domain.
-->

---

## Block 3 — [Assumption Block Name, e.g. "Awareness"]

**What we're testing (PM-only):** [Assumption X — one-line description]

> Q3. [Question]
>
> [options]

<!--
Tests: Assumption X
Type: [e.g. Unaided recall, Long Text]
Rationale: [why this question, why this format]
-->

> Q4. [Question]
>
> [options]

<!--
Tests: Assumption X (aided recognition follow-up to Q3)
Type: Multi-select
Rationale: Captures claimed awareness after unaided captures real recall.
-->

---

## Block 4 — [Next Assumption Block]

**What we're testing (PM-only):** [Assumption Y]

> Q5. [Question]
> [options]

<!--
Tests: Assumption Y
Type: [type]
Rationale: [why]
-->

---

## Block N — Closing

> Q[N-2]. Is there anything else you'd like us to know about [topic]?
>
> [Long Text — optional]

<!--
Tests: Catch-all — surfaces the unknown unknowns
Type: Long Text, optional
-->

> Q[N-1]. (Optional) We may reach out to a small group of respondents for a 30-minute interview. Would you be interested?
>
> - Yes, you can contact me
> - No thanks

<!--
Tests: Interview recruit pipeline
Type: Single-select
Logic: If Yes → route to contact-details block
-->

> Q[N]. (Optional) [One cross-cohort question if the survey is part of a multi-cohort study, e.g. competitive framing]
>
> [options]

<!--
Tests: Cross-cohort comparability
Type: [type]
Rationale: Shared question across all cohort surveys enables comparative analysis.
-->

---

## Typeform Thank-You Screen

Thanks for your time! Your answers go straight to the product team working on [feature/area]. If you opted in for a follow-up interview, we'll be in touch within the next [timeframe].

---

## Typeform Setup Notes (for the PM)

- **Randomize option order** on: Q[x], Q[y] (multi-selects with plausibly equivalent options)
- **Logic jumps:**
  - Q1 screener → end survey if [criteria]
  - Q[x] single-select → skip Q[y] if answer = "None of these"
- **Required fields:** screener + closed-ended assumption questions. Open-ended questions can be optional to reduce abandonment.
- **Hidden fields:** pass `cohort_id` in the Typeform URL so you can join responses back to the Amplitude cohort without a separate question.
- **Progress bar:** ON. Reduces abandonment in surveys >8 questions.
