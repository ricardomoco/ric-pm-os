# UR Survey Best Practices — Anti-Patterns and Rules

Every rule below has a *why*. When you hit an edge case, reason from the why — don't just follow the rule mechanically.

## Table of Contents

1. [Leading and presumptive questions](#leading)
2. [Double-barreled questions](#double-barreled)
3. [Biased scales](#biased-scales)
4. [Option design (MECE, order, escapes)](#option-design)
5. [Time anchors and recall](#time-anchors)
6. [Jargon and insider language](#jargon)
7. [Asking the impossible](#impossible)
8. [Question order and priming](#order-priming)
9. [Over-surveying](#length)
10. [Demographics placement](#demographics)
11. [Open-ended design](#open-ended)
12. [Intro, consent, and thank-you](#intro-outro)

---

## <a name="leading"></a>1. Leading and presumptive questions

**Rule:** Don't embed the answer you want in the question.

| Leading | Neutral |
| --- | --- |
| How easy was it to create a list? | How would you describe the experience of creating a list? [1 — Very difficult … 7 — Very easy] |
| Don't you think the Saved Items feature helps you organize better? | How much do you agree: "Saved Items help me organize items better." |
| What did you like about Saved Items? | What was your overall impression of Saved Items? |

**Why:** Leading language produces data that confirms what you already believed. Stakeholders see through it, and the research becomes unusable for decision-making.

**Specific patterns to catch:**
- "How easy/fast/clear was…" (presumes it was easy/fast/clear)
- "Don't you agree that…" (presumes agreement)
- "What did you like about…" (presumes liking)
- "Why didn't you use…" (presumes they should have used it)

**Fix pattern:** Replace the presumptive adjective with a bipolar scale. Replace "why didn't you X" with "take me back to that moment — what was going through your mind?"

---

## <a name="double-barreled"></a>2. Double-barreled questions

**Rule:** One question, one construct.

| Double-barreled | Split |
| --- | --- |
| Was the feature clear and easy to use? | 1. How clear was the feature? 2. How easy was it to use? |
| Do you find Saved Items useful and would you recommend it? | 1. How useful is Saved Items? 2. How likely are you to recommend Saved Items? |
| Was the process fast and did you understand it? | 1. How long did it take? 2. Did you understand what was happening? |

**Why:** When "clear AND easy" is one question, you can't tell which half drove a low score. Every double-barreled question throws away half its information.

**Catch phrase test:** if the question contains "and", "or", or "as well as" joining two adjectives/verbs → suspect.

---

## <a name="biased-scales"></a>3. Biased scales

**Rule:** Scales must be balanced — equal positive and negative options, with a neutral midpoint.

| Biased | Balanced |
| --- | --- |
| Great / Good / OK / Bad | Very good / Good / Neutral / Poor / Very poor |
| Very useful / Useful / Somewhat useful / Not useful | (7-point) Not useful at all … Extremely useful |
| Always / Often / Sometimes / Rarely | Daily / Weekly / Monthly / Less often / Never |

**Why:**
- Asymmetric scales shift the mean upward by design. You get "most users say it's at least OK" — uninformative.
- Vague frequency anchors ("often") mean different things to different people. Use absolute time anchors.

**Neutral midpoint:** Include one ("Neither agree nor disagree", "Neutral"). Respondents have a right to have no opinion. Forcing a side adds noise.

**Endpoints always labeled.** Labeling every point is better but optional on 7-point scales (avoids cramped labels).

---

## <a name="option-design"></a>4. Option design: MECE, order, escapes

**Rule:** Options must be Mutually Exclusive and Collectively Exhaustive.

**Escape hatches:**
- "Other (please specify)" — catches options you didn't anticipate
- "I don't know" / "I don't remember" — when recall might be weak
- "Prefer not to say" — sensitive topics only
- "None of the above" — for multi-selects

Pin escape hatches to the bottom. They should not be randomized with the rest.

**Order:**
- **Randomize** option order in multi-selects and unranked single-selects to avoid primacy bias.
- **Don't randomize** when order carries meaning (frequency scales, Likert).

**Exhaustive:** Pretest your option list. If >10% of respondents pick "Other", your options were poorly designed.

**Overlapping options are a bug.** "1–5 times, 5–10 times, 10+ times" — where does 5 go? Either "1–5, 6–10" or "1–4, 5–9, 10+".

---

## <a name="time-anchors"></a>5. Time anchors and recall

**Rule:** Use concrete time windows, not vague words.

| Vague | Concrete |
| --- | --- |
| Recently | In the last 30 days |
| Often | Several times a week |
| Lately | Since [month] |
| A while ago | More than 3 months ago |

**Why:** "Recently" means 2 weeks to one person and 6 months to another. Concrete anchors make responses comparable.

**Recall decay:** Beyond ~30 days, recall for routine actions gets unreliable. Beyond ~6 months, recall is almost useless except for memorable events.

**Use episodic framing for open-ended recall:** "Take me back to the last time you…" activates episodic memory, which is more accurate than semantic "in general" framing.

---

## <a name="jargon"></a>6. Jargon and insider language

**Rule:** Never use internal terms the respondent doesn't know.

| Internal | User-facing |
| --- | --- |
| Have you used the IDP recently? | When you last tapped an item to see its details, … |
| How engaged are you with our listings? | How often do you browse items on {{COMPANY}}? |
| What's your intent when you open the app? | What are you usually trying to do when you open {{COMPANY}}? |

**Pitfall:** Internal feature names that haven't been externalized. "Saved Items" is public-facing; "[ML recommendation system] recommendations" is not.

**Test:** Would a respondent who has never talked to a PM or designer understand this word?

---

## <a name="impossible"></a>7. Asking the impossible

**Rule:** Don't ask questions the respondent can't possibly answer.

Examples:
- "Why didn't you create a list?" → asked to a user who never saw the Saved Items feature feature. They didn't "choose" not to; they didn't know to choose.
- "Rate the satisfaction of users in your household" → they can only answer for themselves.
- "How does this compare to the iOS app?" → asked to an Android-only user.

**Fix:** Segment your survey by cohort so that only users who could plausibly answer a question receive it. Use Typeform's logic jumps for within-survey branching.

**Related:** Don't ask people to predict their own future behavior without caveats. Intent data is directional, not definitive. (See question-types.md §6 — discount intent by ~50% for "probably" and ~20% for "definitely".)

---

## <a name="order-priming"></a>8. Question order and priming

**Rule:** The order of questions shapes later answers. Design the order deliberately.

**Key principles:**
- **Unaided before aided.** Recall questions always come before recognition or listed-option questions. Once you show the options, you've leaked.
- **General before specific.** Start broad ("How do you use {{COMPANY}}?") before narrowing to the feature under study ("Have you seen Saved Items?"). Specific questions first primes respondents to focus on that feature in later answers.
- **Non-sensitive before sensitive.** Build rapport before asking anything that feels personal.
- **Easy before hard.** Warm-up questions build commitment. Hitting a hard question first raises drop-off.
- **Mental-model tests before any teaching moment.** If you explain how a feature works later in the survey, the mental-model question must come before that explanation.

**Common priming pitfall:** A question about "frustration with {{COMPANY}}" followed by an NPS question will depress the NPS score. Keep NPS / general satisfaction at the top OR after a clearly separated block.

---

## <a name="length"></a>9. Over-surveying

**Rule:** Survey length is the #1 completion-rate lever.

**Targets:**
- ≤8 min completion time
- 12–18 questions typical for assumption validation
- ≤3 open-ended (ideally 1–2 long-text, 1 short-text)

**Estimate:** ~20–30s per closed question, ~60–90s per long open-ended.

**Signs you've over-surveyed:**
- The same assumption is tested 3+ times in slightly different words
- You have "nice to know" questions that won't change any decision
- Multiple demographics blocks

**Cut test:** For every question, ask "if I didn't have the answer to this, would I still make the same decision?" If yes, delete.

---

## <a name="demographics"></a>10. Demographics placement

**Rule:** Demographics go at the END (or are recruited-in beforehand), never the start.

**Why:** Demographics feel like a chore. Starting with them tanks completion. End placement means even early drop-offs still give you behavioral data.

**Only ask what you'll use for segmentation.** Age, gender, location, income, etc., are not "standard". If you won't slice the results by it, don't ask.

**For {{COMPANY}} context:** If cohorts are already defined in Amplitude (platform, city, transactions), don't re-ask. Link survey responses to user IDs via the CRM recruit flow.

---

## <a name="open-ended"></a>11. Open-ended design

**Rule:** Open-ended questions are where insight lives — but they're expensive for respondents.

**Design principles:**
- **Pair with a closed prior.** The closed question sets the frame; the open captures the reasoning. "You said X. In your own words, why?"
- **Ask for specific moments.** "Take me back to the last time you…" > "In general, when do you…"
- **Neutral framing.** "What was going through your mind?" > "Why didn't you use it?"
- **One open-ended question per topic block.** Stacking opens causes fatigue and thin answers.
- **Place the most important open-ended question EARLY** (after warm-up). By question 10+, answer quality drops.
- **Optional for short-text, required for long-text you must have.** Required fields on hard questions cause abandonment.

**Plan analysis upfront.** Will you thematic-code, tag, cluster? Knowing this affects how you phrase (e.g. asking for single-reason responses vs. free-form).

---

## <a name="intro-outro"></a>12. Intro, consent, thank-you

**Intro block — non-negotiable:**
1. **Who is asking** — "{{COMPANY}} is running research to improve [area]."
2. **Why this respondent** — "You were chosen because you recently used [feature]."
3. **What they get** — incentive, or "helping shape the product you use."
4. **How long** — "Takes about 5 minutes."
5. **Privacy statement** — "Responses are anonymous / used only for research."
6. **No right/wrong answers** — reduces social-desirability bias.

**Closing:**
1. **Catch-all open** — "Anything else we should know?" (this is where gold sometimes shows up)
2. **Thank-you** with what happens next if there's an interview phase ("We may reach out to a subset of respondents for a 30-min follow-up interview — interested?")
3. **Incentive delivery** instructions if applicable.

---

## Quick self-review checklist

Before shipping a survey, verify:

- [ ] Every question maps to a research question, hypothesis, or assumption
- [ ] No leading language ("how easy", "don't you agree")
- [ ] No double-barreled items (no "and" joining adjectives)
- [ ] Scales are balanced with neutral midpoints
- [ ] Option lists are MECE with escape hatches where relevant
- [ ] Time windows are concrete, not vague ("last 30 days" not "recently")
- [ ] No jargon the respondent doesn't share
- [ ] No questions the respondent can't possibly answer
- [ ] Unaided recall is asked before aided recognition
- [ ] Demographics at the end, only if needed for segmentation
- [ ] ≤3 open-ended questions, paired with closed priors
- [ ] Estimated completion time ≤8 min
- [ ] Intro includes who/why/time/privacy
- [ ] Closing has catch-all open + thank-you
