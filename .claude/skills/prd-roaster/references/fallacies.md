# Logical & Rhetorical Fallacies in PRDs

Use this catalogue during Pass 2 of the roast. For each fallacy, the goal is to:

1. Quote the exact phrase from the PRD
2. Name the fallacy
3. State why it doesn't hold

A fallacy named in the abstract ("the PRD has some shaky reasoning") is useless. Always quote and pin.

---

## False dichotomy / forced binary

**Pattern:** "Either we ship X or [bad thing happens]." Presents two options when more exist.

**Examples in PRDs:**
- "Either we adopt this approach or competitor wins."
- "We ship the badge in Q2 or buyers continue to abandon."
- "Either we build LQI now or we lose the market."

**How to attack:** Name the third option the PRD ignored. ("Or: ship the badge for KYC only, defer DSA KYB until process is bulletproof — a path the PRD doesn't even consider.")

---

## Motte-and-bailey

**Pattern:** Author advances a strong claim ("the bailey"), retreats to a weaker defensible one when challenged ("the motte"), then re-asserts the strong claim later as if validated.

**Examples in PRDs:**
- Bailey: "Verified sellers convert 5% better."
- Motte (when pressed): "Well, in one 2023 experiment on Android there was a +1.2% signal."
- Returns to bailey in the metrics section: "We expect +5% AOV uplift."

**How to attack:** Quote both versions. Force the author to commit to one.

---

## Begging the question (circular reasoning)

**Pattern:** The conclusion is smuggled into the premise.

**Examples in PRDs:**
- "The trust badge will increase trust because trust signals build trust."
- "Better recommendations will improve recommendation quality."
- "Increasing transparency will make sellers more transparent."

**How to attack:** Strip the rephrasing. "What's the actual mechanism? Which buyer behavior changes?"

---

## Survivorship bias

**Pattern:** "Successful companies do X, so we should do X." Ignores all the failed companies that also did X.

**Examples in PRDs:**
- "eBay has listing quality scores. We should too."
- "Airbnb uses ML for photo quality. So should we."
- "Vinted does X. They're winning. Let's copy."

**How to attack:** Ask for the counterfactual. "What about marketplaces that did X and failed? What about {{COMPANY}}-specific reasons X may not transfer?"

---

## Single-cause attribution

**Pattern:** Attributes a complex outcome to a single cause.

**Examples in PRDs:**
- "Buyers aren't converting because the IDP doesn't show verification status."
- "The 2023 KYC experiment got +1.2% — that proves verification drives conversion."
- "Top Profile underperforms because buyers don't understand it."

**How to attack:** Name 3 plausible alternative causes. Demand the PRD's design distinguishes between them.

---

## Post hoc ergo propter hoc

**Pattern:** "X happened after Y, therefore Y caused X."

**Examples in PRDs:**
- "AOV went up after we shipped the badge experiment, so the badge increased AOV."
- "Sellers complete profiles more after we added nudges — nudges drive completion."

**How to attack:** Name the confound. ("Was there a CRM campaign in the same window? A category mix shift? Seasonality?")

---

## Confirmation bias / cherry-picking evidence

**Pattern:** Cites only the data that supports the proposal, ignores or minimises contrary signals.

**Examples in PRDs:**
- "User research confirmed buyers want this." (3 of 18 interviewees mentioned it.)
- "The 2023 experiment was a success — +1.2% CVR." (Was rolled back due to legal.)
- "Top Profile sellers convert better." (Selection bias: top performers self-select into the badge.)

**How to attack:** Ask for the disconfirming evidence. If the PRD has none, that's the attack — the author didn't look.

---

## Appeal to authority (without justification)

**Pattern:** "[Senior person] wants this" or "[Expert / consultant / framework] says we should." Treats authority as evidence.

**Examples in PRDs:**
- "The CPO has prioritised this."
- "Per Teresa Torres' framework, this is a desirability assumption." (Torres is fine; using her as decoration without applying her method is the fallacy.)
- "Our designer thinks the badge should be blue."

**How to attack:** Strip the authority. Is the underlying claim defensible on the merits? If not, it doesn't become defensible because someone senior said it.

---

## Streetlight effect

**Pattern:** Measuring what's easy, not what matters. Choosing metrics by data availability rather than by what the feature is actually for.

**Examples in PRDs:**
- "Primary metric: tap rate on the badge tooltip." (Tap rate measures curiosity, not trust.)
- "Success: increase in seller profile visits." (Profile visits ≠ purchase intent.)
- "Metric: badge coverage %." (Coverage is an implementation metric, not a user outcome.)

**How to attack:** Ask what the feature is *actually* trying to change in user behavior. Is the chosen metric a proxy for that, or just a proxy because the data is there?

---

## Goodhart's law violation

**Pattern:** "When a measure becomes a target, it ceases to be a good measure." The PRD picks a metric that, if optimised, gets gamed and stops measuring the underlying outcome.

**Examples in PRDs:**
- "Optimise for badge coverage" → sellers complete fake KYC fields just to get the badge.
- "Optimise for chat response time" → sellers send empty messages to game the metric.
- "Optimise for AI description completeness" → AI fills with generic boilerplate, completeness goes up, quality goes down.

**How to attack:** Ask what gaming the metric would look like. Does the PRD have guardrails against that?

---

## Anchoring on stakeholder request

**Pattern:** A stakeholder request is treated as a user need with no validation in between.

**Examples in PRDs:**
- "PROs Artisans tribe wants the verified badge to differentiate PRO sellers." (Maybe; what do buyers want?)
- "CPO requested we surface verification." (User need not validated.)
- "Search team needs LQI as a ranking signal." (Ranking signal need ≠ buyer evaluation need.)

**How to attack:** Distinguish the stakeholder ask from the user need. Both can be valid; the PRD must say which it's solving.

---

## Sunk-cost reasoning

**Pattern:** "We've already invested in X, so we should keep going."

**Examples in PRDs:**
- "We've already built the rule-based Top Profile, so let's extend it with ML."
- "The 2023 KYC experiment was rolled back, but we've done the work, let's revive it."
- "We've already aligned with Legal in 2023, so we should ship now."

**How to attack:** Past investment is irrelevant to whether the next investment is worth making. Ask: would you start this today knowing what you know?

---

## Hasty generalisation

**Pattern:** Drawing broad conclusions from a small or unrepresentative sample.

**Examples in PRDs:**
- "5 of 8 interviewees said they trust verified sellers more — buyers want this."
- "One car-dealer use case shows DSA KYB works — the model generalises."
- "User 5866228C said Top Profile is confusing — the badge is broken."

**How to attack:** Sample size, segment representativeness, signal-to-noise. Don't argue with the qualitative finding; argue with the inferential leap.

---

## False equivalence

**Pattern:** Treats two different things as the same to make the comparison work.

**Examples in PRDs:**
- "KYC for private sellers and KYB for business sellers are both verification, so one badge works."
- "Top Profile and Verified are both trust signals, so they can coexist."
- "PRO and Business Account mean the same thing to users."

**How to attack:** Name the dimension on which they're different. Force the PRD to address whether that difference matters.

---

## Slippery slope

**Pattern:** "If we do X, then Y, then Z, then disaster" without supporting the chain.

**Examples in PRDs:**
- "If we don't ship the badge in Q2, sellers will lose faith and the marketplace will collapse."
- "If we add mandatory fields, sellers churn, supply dies."

**How to attack:** Demand the evidence at each link of the chain. Most slippery slopes break at link 2.

---

## Texas sharpshooter (drawing the target around the data)

**Pattern:** Looking at noisy data, identifying the cluster that supports your hypothesis, ignoring the rest.

**Examples in PRDs:**
- "In the high-value segment, verified sellers convert 8% better." (No pre-registered hypothesis on segment.)
- "On Tuesdays, the experiment shows uplift." (Sub-segment dredging.)

**How to attack:** Ask whether the segment was pre-registered. If not, the finding is hypothesis-generating, not hypothesis-confirming.

---

## Loaded question (in research)

**Pattern:** Question phrased to elicit a specific answer.

**Examples in PRDs / research summaries:**
- "How important is verification to your purchasing decision?" (Implies it's important.)
- "Would you trust a seller more if they were verified?" (Almost everyone says yes; means nothing.)

**How to attack:** Quote the question. Ask whether a neutral phrasing was tested.

---

## Equivocation

**Pattern:** Same word used in two senses without flagging the shift.

**Examples in PRDs:**
- "Verified" — sometimes means "identity-verified by [example PSP] KYC," sometimes "DSA KYB-complete," sometimes "trustworthy."
- "Quality" — sometimes means listing completeness, sometimes photo quality, sometimes seller behaviour.
- "Trust" — sometimes means "willingness to transact," sometimes "perceived honesty," sometimes "absence of fraud signal."

**How to attack:** Force a definition. Make the author commit.

---

## Hedging that masquerades as honesty

**Pattern:** A claim is buffered with so many hedges that it makes no commitment, but reads as if it does.

**Examples in PRDs:**
- "This may potentially help in some cases."
- "Users could possibly find this somewhat useful."
- "We might see a small improvement, depending on factors."

**How to attack:** Force commitment. "What is the claim? What would falsify it?"

---

## False precision

**Pattern:** Numbers stated to a precision the data doesn't support.

**Examples in PRDs:**
- "Target: AOV €54.16 (+2%)" derived from "+2% feels right."
- "Expected impact: +1.2% CVR" sourced from a single 2023 experiment with no confidence interval.
- "Badge coverage: 19.3%" rounded from a hand-wave estimate.

**How to attack:** Demand the source for each digit. Decimal points imply data the PRD doesn't have.

---

## Argument from incredulity

**Pattern:** "I can't see how this could fail, therefore it won't."

**Examples in PRDs:**
- "It's hard to see how a verified badge would harm conversion."
- "I don't see how Goodhart could apply here."

**How to attack:** Failure of imagination is not evidence. Demand a pre-mortem.

---

## Implicit "we"

**Pattern:** "We" assumes shared agreement that doesn't exist. Often masks single-author preferences as team consensus.

**Examples in PRDs:**
- "We agree that the badge should be blue."
- "We've decided to use Stage 1 only." (Who is "we"? When was it decided?)
- "We know buyers want this." (Who knows? From what evidence?)

**How to attack:** Ask who specifically agreed, when, and on what evidence. "We" without names is a presumption.

---

## How to deploy this catalogue in a roast

For each fallacy you spot:

1. **Quote** the exact line. Use blockquote or "Section X says: '...'"
2. **Name** the fallacy from this list (or describe it precisely if not listed).
3. **Explain** why it doesn't hold in 1-2 sentences max.
4. **Don't pile on** — one fallacy per quote is enough. If a single sentence has three fallacies, name the most consequential one.

If a "fallacy" you want to call is just "the PRD didn't justify this" — that's not a fallacy, that's missing evidence. Save it for Pass 3 (technical hallucinations) or Pass 7 (what's missing).
