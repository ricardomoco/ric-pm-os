# Example: PMF Pre-Interview Survey — Two-Cohort Adoption Study

<!--
## PM-FACING PREAMBLE (do not paste into Typeform)

**Source research plan:** [link to your research plan]
**Cohorts covered:** C1 (Unaware Non-Adopters) + C2 (Aware Non-Adopters)
**Recruitment source:** Behavioural cohorts from analytics, matched to CRM email
**Estimated completion:** 5–7 min per respondent
**Total questions:** 12 per cohort (includes shared closing block of 3)
**Target N:** 150+ per cohort

### Why two separate surveys

C1 never tapped the feature. They literally cannot tell us "why didn't you use it" — they weren't in a position to choose. C2 saw the feature and didn't convert, so they CAN speak to intent and rejection reasons. A single survey would either leak context to C1 (a later question teaches them what the feature is) or waste half the C2 survey on awareness questions they've already demonstrated they passed.

### Assumptions covered

- **H1 (Awareness barrier):** C1 Q3–Q5 (unaided recall → aided recognition → pathway)
- **H2 (Effort barrier):** C2 Q6 + Q7 (perceived effort vs value)
- **H3 (Messaging — invalidated, testing replacements):** Shared closing MaxDiff (Q10–Q12)
- **Competitive framing:** Shared closing Q9

### Intentionally NOT covered

- Mental model assumptions that require observation — covered separately in interviews with active users.
- Long-tail use cases — captured in qualitative interviews, not this quantitative survey.

This is an **illustrative template**. Replace cohort definitions, hypothesis labels, and feature names with your own context. The structure (split by cohort, shared closing block, MaxDiff for messaging) is the reusable pattern.
-->

---

# Cohort C1 — Unaware Non-Adopters

> Hi! Thanks for taking 5 minutes to help us understand how you save items on {{COMPANY}}.
> Your answers are anonymous and used only to improve the product.

---

## Q1. How long have you been using {{COMPANY}}?

- Less than 3 months
- 3 to 12 months
- More than 12 months
- I don't remember

> Rationale: tenure split for downstream cohort analysis.

---

## Q2. How often do you save items you might want to come back to?

- Several times a week
- Once a week
- A few times a month
- Rarely or never

> Rationale: anchors respondent in saving behaviour before introducing the feature.

---

## Q3. When you save an item on {{COMPANY}}, what's the first thing you do with it?

> Open text. 1-2 sentences.

> Rationale: unaided recall question. Mentions (or absence of mentions) of the feature, tabs, or organizing terms becomes the primary signal for whether users noticed the feature organically.

---

## Q4. Which of these have you seen on {{COMPANY}}? (Select all that apply)

- A Favorites section
- A way to group saved items into named collections
- A "Recently viewed" section
- None of the above

> Rationale: aided recognition. Gap between % mentioning the feature in Q3 and % selecting it in Q4 is the "claimed vs real" awareness gap.

---

## Q5. The last time you wanted to compare a few saved items before deciding, how did you do it? (Open text)

> Rationale: surface the current alternative — screenshots, notes app, browser tabs — to size the competitive set the feature would replace.

---

# Cohort C1 — Hypothesis Probe (H1)

**What we're testing (PM-only, do not paste into Typeform):** when the feature is explained in plain language, does the cohort see value? Separates awareness failure from value failure.

## Q6. {{COMPANY}} has a feature called [Feature Name]. It lets you group items you've saved — for example, a group called "For the kitchen" or "Gift ideas" — so you can compare and decide more easily. How interested are you in trying it?

- Very interested
- Somewhat interested
- Not very interested
- Not interested at all

## Q7. (If "very" or "somewhat" in Q6) What would you use [Feature Name] for? (Open text)

> Rationale: validates whether the value prop maps to a use case the user already has.

## Q8. (If "not very" or "not at all" in Q6) Why not? (Open text)

> Rationale: separates "I don't need this" from "I already have a way to do this" from "I don't understand what this is".

---

# Cohort C2 — Aware Non-Adopters

> Hi! Thanks for taking 5 minutes. We noticed you've seen [Feature Name] on {{COMPANY}} but haven't created one. We want to understand why so we can make it better.

---

## Q1–Q2. (Same as C1 Q1–Q2.)

---

## Q3. You tapped the [Feature Name] tab at least once. Take yourself back to that moment — what were you hoping it would do? (Open text)

> Rationale: surface the expectation gap between what the user came for and what the feature delivers.

---

## Q4. What stopped you from creating one? (Select up to 3)

- I didn't understand what the feature was for
- It looked like too much work to set up
- I didn't have items I wanted to group
- I already organize items in my head / outside the app
- I forgot about it
- Other: ____

> Rationale: directly tests H2 (Effort barrier). The "I didn't understand" option also catches lingering H1 cases.

---

## Q5. (If "too much work" in Q4) What would make it easier? (Open text)

> Rationale: directionally validates the next iteration's hypothesis.

---

# Shared closing block (both cohorts)

## Q9. When you want to compare items you've saved on any shopping app, what do you usually do? (Open text)

> Rationale: external competitive framing — what's the user's existing workflow?

---

## Q10–Q12. MaxDiff — Of these three statements about [Feature Name], which is MOST appealing to you, and which is LEAST appealing? (Forced choice)

> Run 4 rounds, 3 statements per round, balanced sampling. Use the rounds to test 4-6 candidate value propositions.

> Rationale: surfaces the strongest messaging without the social-desirability bias of "rate each on a scale".

---

## Q13. (Optional) Would you be open to a 15-min interview to tell us more? (Yes / No)

> If Yes → ask for email + best time window.

---

> Thanks — your answers go straight to the team shaping the next version of [Feature Name]. If you opted in for an interview, we'll reach out within the next 2 weeks.
