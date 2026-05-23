# Assumption Types Reference

Teresa Torres' five types of assumptions, with definitions, where they hide in a PRD, and examples tailored to {{COMPANY}} marketplace context.

Use this file when you need deeper examples for a specific type, or when a type is under-represented in your draft and you need prompts to surface more.

---

## 1. Desirability (D)

**Definition:** Why do we think customers want this solution, and why do we think they'll do what we need them to do to get value from it?

**Where it hides in a PRD:**
- Problem / opportunity statement
- Hypothesis ("we believe that if we…")
- Target user segments and JTBD framing
- Expected behavior change ("users will start doing X")
- Any sentence where the PRD says "users want" or "users need"

**Example well-formed assumptions (marketplace context):**
- "We believe buyers evaluating an item with a verified seller badge will be more likely to initiate a chat than buyers evaluating the same item without the badge, because the badge reduces trust friction."
- "We believe sellers who hit the 'unreserve blocked' bottom sheet will want to cancel the shipment, rather than wait for it, because their underlying intent is to stop the sale."
- "We believe buyers who favorite ≥3 items in a category want to organize them into a list, rather than rely on the flat Favorites view."

**Red flags in the PRD:**
- "Users are asking for this" without a link to research or support volume data
- "This solves a major pain point" without citing severity
- "Users will love this"
- Problem framed without any user quote, interview, or behavioral data

**When you need more Desirability assumptions:** re-read the problem statement and ask: why would a user actually care? What behavior change does the PRD expect? What evidence exists that users want *this specific solution* and not a different one?

---

## 2. Viability (V)

**Definition:** Why do we think this solution will be good for the business?

**Where it hides in a PRD:**
- Success metrics and targets
- "Why now" / strategic fit section
- Resource requirements and cost implications
- Revenue / CVR / retention impact claims
- Trade-offs vs. other work on the roadmap

**Example well-formed assumptions:**
- "We believe a 2-line item card title in Search will improve Search → PI CVR by ≥1% without a meaningful drop in items-per-scroll."
- "We believe the operational cost of manually reviewing KYB applications is below the revenue lift from increased Pro-seller transaction volume."
- "We believe increasing verified-badge coverage to 40% of listings will lift AOV by ≥2% without cannibalizing non-verified-seller transaction volume."

**Red flags:**
- Metric targets pulled from thin air ("+1%") with no benchmark or historical baseline
- "This will drive revenue" without a model
- No mention of cost, operational load, or headcount implications
- Success metrics not tied to business outcomes

**When you need more Viability assumptions:** check the metrics section. Every target is a viability assumption. Also check: is there a guardrail on the metric it *might* cannibalize?

---

## 3. Feasibility (F)

**Definition:** Why do we think we can build, deliver, and operate this solution?

**Where it hides in a PRD:**
- Solution scope and architecture
- Timeline and milestones
- Dependencies on other teams / services
- Performance and reliability requirements
- Tech stack or integration points

**Example well-formed assumptions:**
- "We believe the Favorites service can be migrated off the monolith without introducing >50ms latency on the Favorites list endpoint."
- "We believe MMP's KYB service will return a verification status within 500ms p95 at IDP load time, so we can render the badge without a perceived performance regression."
- "We believe the ML ranker can generate top-profile recommendations from existing behavioral features, without requiring new events to be instrumented."

**Red flags:**
- "Engineering confirmed feasibility" with no details of what was confirmed
- Aggressive timelines with no buffer
- Dependencies on services the team doesn't own with no SLA cited
- No mention of rollback, observability, or failure modes
- "Should be straightforward"

**When you need more Feasibility assumptions:** look at the scope section and ask: which pieces depend on another team, another service, or an unproven approach? Each dependency is at least one feasibility assumption.

---

## 4. Usability (U)

**Definition:** Why do we think the user will be able to successfully use the solution?

**Where it hides in a PRD:**
- User flows and interaction details
- Requirements and acceptance criteria
- Onboarding, empty states, error states
- UI component descriptions
- Edge case handling

**Example well-formed assumptions:**
- "We believe sellers will understand the bottom sheet's CTA ('Go to transaction') points them to the surface where cancellation is possible, without additional tooltip or explanation."
- "We believe buyers will discover the 'Create List' entry point on the IDP without needing a coach mark, within their first 3 IDP sessions after favoriting an item."
- "We believe users will parse the difference between the 'verified' badge and the existing 'pro seller' badge without confusion."

**Red flags:**
- "The UI is self-explanatory"
- "Users will figure it out"
- No onboarding or discoverability strategy mentioned
- Complex flows without usability testing planned
- Error states not specified

**When you need more Usability assumptions:** walk through the flow as if you were the user. At every screen, ask: how do they know what to do next? What happens if they tap the wrong thing? What's the empty state?

---

## 5. Ethical (E)

**Definition:** Is there any potential harm in building this solution?

**Where it hides in a PRD:**
- Data collection and privacy mentions (or absence thereof)
- Accessibility requirements
- Impact on different user segments (often overlooked)
- What's NOT mentioned (this is usually where the risk is)

**Example well-formed assumptions:**
- "We believe displaying seller response time on the IDP does not systematically disadvantage sellers in time zones where {{COMPANY}} main audience is active during their sleep hours."
- "We believe a verified-badge requirement does not create a two-tier marketplace where unverified sellers see a disproportionate drop in PIs."
- "We believe the recommendation algorithm's use of Favorites data as a signal does not create filter bubbles that suppress exposure to items users haven't explicitly signaled interest in."
- "We believe the new bottom sheet is fully operable with VoiceOver / TalkBack and meets WCAG 2.1 AA contrast requirements."

**Red flags:**
- No mention of privacy, accessibility, or ethical review
- "Standard privacy policy covers this"
- "Accessibility will be addressed later"
- No consideration of potential misuse
- Assumption that all user segments experience the feature equally

**When you need more Ethical assumptions:** ask four questions: (1) who could be harmed by this? (2) who gets *less* service if this is live? (3) what data are we collecting or exposing that we weren't before? (4) does this meet accessibility standards? If the PRD doesn't answer any of these, each is an assumption.

---

## Cross-type coverage heuristic

A healthy analysis usually lands in this rough distribution:

| Type | Typical share | Red flag |
|---|---|---|
| Desirability | 25–35% | >50% → solution-first thinking, not enough building / business scrutiny |
| Viability | 15–25% | <10% → not enough scrutiny of business case |
| Feasibility | 15–25% | <10% → engineering details glossed over |
| Usability | 15–25% | <10% → you skipped walking the flow |
| Ethical | 10–20% | 0% → blind spot, restart the ethical pass |

If your output is skewed hard toward Desirability, the PRD author probably led with "users want this" and you followed them. Re-run Steps 3–4 of the method with the other types as your lens.
