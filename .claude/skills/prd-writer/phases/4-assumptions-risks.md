# Phase 4: Assumptions & Risks

Identify hidden assumptions using Teresa Torres' Continuous Discovery framework. Reference [references/assumptions.md](../references/assumptions.md) for risk classification logic.

For full deep-dive assumption analysis (15-25 assumptions, journey-mapped, with validation tests), route to `/assumption-identifier`. This phase focuses on populating the Risks and Assumptions sections of the PRD itself.

## Risks output format — required

When populating the §Risks section of the PRD, use a matrix with detection. Risks without a Detection column are decorative — they don't tell the team how to know the risk has materialised.

**Required output format (one matrix per risk category — User / Platform & Legal / Business):**

| Risk | Likelihood | Impact | Detection | Mitigation |
| :--- | :--- | :--- | :--- | :--- |
| [Specific risk] | L/M/H | L/M/H | [Metric / threshold / signal that flags it] | [Concrete action when detected] |

The Detection column is the discipline. Examples:
- "User feedback <3.0/5.0 OR adoption <15%"
- "P95 latency >500ms for 3 consecutive minutes"
- "False positive rate >3% over 24 hours"

Vague entries like "monitor and adjust" are not detection — they're hopes. Push back.

## Specificity over vagueness — one transformation

**Bad — risk without detection:**
> "Suggestions might be irrelevant. Mitigation: monitor and iterate."

**Good — risk with detection trigger and committed action:**
> "Risk: irrelevant AI suggestions degrade trust. Likelihood: M. Impact: H. Detection: user feedback <3.0/5.0 OR suggestion adoption <15% over 7 days. Mitigation: kill switch + model retrain queued at next sprint boundary."

Analyze the PRD or feature context provided by the user.

Before identifying assumptions, systematically analyze the PRD:

<scratchpad>
Extract PRD key elements:
- What problem/opportunity is being addressed?
- What solution is proposed? What's in scope vs. out of scope?
- Who are the target users/segments?
- What's the hypothesis? What outcomes are expected?
- What metrics define success?
- What timeline/rollout approach is planned?
- What technical approach or dependencies exist?

Identify explicit vs. implicit claims:
* What does the PRD state as facts vs. beliefs?
* What's presented as validated vs. assumed?
* What evidence is cited? What's missing?
* What must be true for each requirement to deliver value?
* What could invalidate the entire approach?

Map to assumption types:
* Desirability: Why will users want/use this? Is the problem real and important?
* Usability: Can users successfully accomplish their goals? Is it intuitive?
* Feasibility: Can we build this? Will technical approach work? Can we deliver on time?
* Viability: Will this achieve business goals? Is the ROI realistic? Can we support it?
* Ethical: Is this responsible? Are there privacy, accessibility, or misuse concerns?

Assess evidence quality:
* Where does the PRD cite user research, data, or past learnings?
* Where does it rely on intuition, best practices, or stakeholder opinions?
* What claims have high confidence vs. speculation?

Determine if clarification is needed:
* Is the PRD complete enough to identify key assumptions?
* Are critical sections missing (problem space, metrics, solution details)?
* Can I proceed or do I need specific clarifications?
</scratchpad>

Now identify and evaluate assumptions using Teresa Torres' methodology.

## **ASSUMPTION IDENTIFICATION & EVALUATION**
## **PRD Overview**
**Initiative:** [Name/title of the initiative from PRD]
**Core Hypothesis:** [Extract the hypothesis statement from PRD, or synthesize if not explicit]
**Primary Success Metric:** [What metric defines success]
**Target Users:** [Who this is for]

## **Context Assessment**
**Information Provided:** [Summarize what sections/details exist in PRD]
**Strengths:** [What the PRD covers well - evidence cited, clear rationale, etc.]
**Gaps:** [What critical information is missing or unclear]
[If major gaps exist that prevent thorough analysis, state them clearly and ask 2-3 specific clarifying questions. If sufficient context exists, state "Sufficient detail to proceed with comprehensive assumption analysis" and continue.]

## **Identified Assumptions**
For each assumption, provide:
* **Assumption statement** (clear, specific "We believe that..." format)
* **PRD Source** (which section this assumption comes from or is implied by)
* **Type** (Desirability, Usability, Feasibility, Viability, or Ethical)
* **Importance** (High/Medium/Low - impact on initiative success)
* **Evidence Strength** (High/Medium/Low - validation that exists)
* **Risk Level** (Risky/Non-Risky based on importance + evidence matrix)
* **Testing Recommendation** (Specific method to validate with timeline)

## **ASSUMPTION FRAMEWORK GUIDE**
Use these definitions to classify assumptions:
**1. DESIRABILITY Assumptions**
**Definition:** Assumptions about whether customers/users want this solution and will choose it over alternatives.
**Examples from PRDs:**
* "Users want to organize their favorites into categories"
* "The pain point described is significant enough to drive behavior change"
* "Target segment will prefer this over current workarounds"
* "Users will find the value proposition compelling"
* "The opportunity space described represents real user needs"
**Where to Look in PRDs:**
* Problem/Opportunity Space section
* Hypothesis statement
* Target user segments
* Use cases and user stories
* Expected behavior changes
**Red Flags:**
* "Users are asking for this" (without showing evidence)
* "This solves a major pain point" (without validation)
* "Users will love this feature"
* Problem described without user research citations

**2. USABILITY Assumptions**
**Definition:** Assumptions about whether users can successfully use the solution to achieve their goals.
**Examples from PRDs:**
* "Users will understand the mental model of albums vs. favorites"
* "The creation flow is intuitive enough to complete without help"
* "Users can discover the feature through the entry points provided"
* "Error messages will be clear enough for users to self-recover"
* "The empty state provides sufficient guidance"
**Where to Look in PRDs:**
* User flows and interaction details
* Requirements with acceptance criteria
* Onboarding approach
* UI component descriptions
* Edge case handling
**Red Flags:**
* "The UI is self-explanatory"
* "Users will figure it out"
* No mention of onboarding or discovery
* Complex flows without usability testing plans

**3. FEASIBILITY Assumptions**
**Definition:** Assumptions about whether we can build, deliver, or operate this solution with available resources and technology.
**Examples from PRDs:**
* "Our recommendation algorithm can generate relevant suggestions"
* "The database can handle the data structure at scale"
* "We can implement this within the stated timeline"
* "Third-party APIs will meet our latency requirements"
* "The technical approach described is viable"
**Where to Look in PRDs:**
* Solution details and technical architecture
* Timeline and milestones
* Dependencies on other systems/teams
* Performance requirements
* Integration points
**Red Flags:**
* "Engineering confirmed feasibility" (without details)
* Aggressive timelines without buffers
* Dependencies on unproven technologies
* No mention of technical risks
* "Should be straightforward to implement"

**4. VIABILITY Assumptions**
**Definition:** Assumptions about whether this solution works for the business (financially, strategically, operationally).
**Examples from PRDs:**
* "This will increase conversion rate by X%"
* "The cost of implementation is justified by expected revenue lift"
* "We can support this feature without additional headcount"
* "This will differentiate us enough to impact retention"
* "The metrics lift will meet ROI thresholds"
**Where to Look in PRDs:**
* Success metrics and targets
* Business objectives
* Resource requirements
* Go-to-market approach
* Expected impact on key business metrics
**Red Flags:**
* Ambitious metric targets without historical benchmarks
* "This will drive revenue" (without model)
* No mention of cost or resource implications
* Success metrics not tied to business outcomes

**5. ETHICAL Assumptions**
**Definition:** Assumptions about responsible use, privacy, fairness, accessibility, and unintended consequences.
**Examples from PRDs:**
* "Personalized recommendations won't create harmful filter bubbles"
* "Users understand how their data is used"
* "The feature is accessible to users with disabilities"
* "The solution won't be exploited for manipulation"
* "All user segments benefit equally"
**Where to Look in PRDs:**
* Data collection and privacy mentions
* Accessibility requirements
* Ethical considerations (if section exists)
* Impact on different user segments
* What's NOT mentioned (often the gap)
**Red Flags:**
* No mention of privacy, accessibility, or ethics
* "Standard privacy policy covers this"
* "Accessibility will be addressed later"
* No consideration of potential misuse
* Assumption that all users have same capabilities/access

## **RISK CLASSIFICATION MATRIX**
Use this framework to determine risk level:

| Evidence Strength | Importance: HIGH | Importance: MEDIUM | Importance: LOW |
| ----------------- | ---------------- | ------------------ | --------------- |
| High              | Non-Risky        | Non-Risky          | Non-Risky       |
| Medium            | Risky            | Non-Risky          | Non-Risky       |
| Low               | Risky            | Risky              | Non-Risky       |

**Risk Level Definitions:**
* **Risky:** Test BEFORE building/launching or during development. Failure would significantly impact success.
* **Non-Risky:** Can proceed with monitoring. Either well-validated OR low-impact if wrong.

**Importance Criteria:**
* **High:** Core to the value proposition, hypothesis, or business model. If wrong, initiative likely fails or significantly underperforms.
* **Medium:** Important to user experience or business outcomes but can be adjusted. Affects quality but not fatal if wrong.
* **Low:** Nice-to-have, edge case, or peripheral feature. Minimal impact on core success if wrong.

**Evidence Strength Criteria:**
* **High:** Validated with user research, behavioral data, experiments, or proven in similar contexts. Multiple sources converge.
* **Medium:** Some data or research exists but limited, indirect, or from single source. Anecdotal evidence or small sample.
* **Low:** Based on intuition, best practices, stakeholder opinion, or unvalidated beliefs. No direct evidence cited in PRD.

## **TESTING RECOMMENDATION FRAMEWORK**
For each risky assumption, recommend a validation method appropriate to the assumption type:

**For Desirability Assumptions:**
* **User interviews (5-8):** Deep exploration of needs, pain points, and solution reaction
* **Survey (n=50-200):** Quantify demand, willingness to use, or problem severity
* **Fake door test:** Measure click-through on promised feature before building
* **Concierge/Wizard of Oz:** Manually deliver solution to validate value
* **Landing page test:** Gauge interest via sign-ups, wait-list, or pre-orders
* **Jobs-to-be-done interviews:** Understand context and alternatives

**For Usability Assumptions:**
* **Prototype testing (5-8 users):** Task completion with thinking aloud
* **First-click test:** Validate information architecture and navigation
* **5-second test:** Assess immediate comprehension
* **Cognitive walkthrough:** Expert evaluation of flow logic
* **Guerrilla testing:** Quick hallway tests of key interactions
* **Accessibility audit:** WCAG compliance check with assistive technology

**For Feasibility Assumptions:**
* **Technical spike (1-3 days):** Time-boxed exploration to prove concept
* **Proof of concept:** Build minimal version to validate approach
* **Load/performance testing:** Validate scalability with simulated data
* **API integration test:** Test third-party dependencies under realistic conditions
* **Architecture review:** Expert assessment with engineering leads
* **Prototype with real data:** Test with production-scale data subset

**For Viability Assumptions:**
* **A/B test (if safe):** Measure actual business impact with live users
* **Cohort analysis:** Analyze existing user behavior as proxy
* **Financial modeling:** Calculate unit economics, payback period, ROI
* **Operational pilot:** Test support/ops impact with controlled group
* **Competitive analysis:** Research how competitors approach similar problems
* **Expert review:** Consult domain experts on market dynamics

**For Ethical Assumptions:**
* **Privacy impact assessment:** Audit data practices with legal/privacy team
* **Accessibility audit:** Test with screen readers and assistive tech
* **Diverse user testing:** Include underrepresented groups in research
* **Red team exercise:** Brainstorm misuse scenarios and mitigations
* **Ethics review:** External perspective from ethics board or advisors
* **Fairness analysis:** Test for bias across different user segments

## **OUTPUT FORMAT**
Generate your analysis in this structure:
## **ASSUMPTION ANALYSIS FOR [PRD NAME]**
## **Executive Summary**
[2-3 sentences summarizing the initiative and your overall assessment of assumption risk]
## **PRD Strengths**
[What the PRD does well in terms of evidence, clarity, or de-risking]
## **Critical Gaps Requiring Clarification**
[Only include if essential information is missing. Ask 2-3 specific questions about PRD gaps.]

## **Identified Assumptions by Risk Level**
**HIGH-RISK ASSUMPTIONS (Must Test Before/During Development)**

| # | Assumption Statement | PRD Section | Type | Importance | Evidence | Risk | Testing Recommendation |
| - | ----------------------------------------------- | ----------------- | ------ | ---------- | -------- | ----- | -------------------------------------------------------------------------------------------------------------------- |
| 1 | We believe that [specific, testable assumption] | [PRD Section X.X] | [Type] | High/Med | Low/Med | Risky | Method: [Specific test]<br>Sample: [Size/criteria]<br>Timeline: [When to test]<br>Success criteria: [What validates] |

[Continue for all high-risk assumptions - typically 5-10 for a comprehensive PRD]
**Critical Path:** [Identify which 3-5 assumptions MUST be tested before development starts and why]

**MEDIUM-RISK ASSUMPTIONS (Test During Development/Beta)**

| # | Assumption Statement | PRD Section | Type | Importance | Evidence | Risk | Testing Recommendation |
| - | ------------------------------------- | ------------- | ------ | ---------- | -------- | ----- | ------------------------------------------------------------------------ |
| X | We believe that [specific assumption] | [PRD Section] | [Type] | Med/Low | Low/Med | Risky | Method: [Test]<br>Timeline: [When]<br>Success criteria: [What validates] |

[Continue for medium-risk assumptions - typically 5-8]

**LOW-RISK ASSUMPTIONS (Monitor Post-Launch)**

| # | Assumption Statement | PRD Section | Type | Importance | Evidence | Risk | Monitoring Approach |
| - | ---------------------------- | ------------- | ------ | ------------ | -------- | --------- | -------------------------------------------------------------------------------------------------------- |
| X | We believe that [assumption] | [PRD Section] | [Type] | High/Med/Low | High/Med | Non-Risky | Metric to watch: [Specific metric]<br>Threshold: [What indicates problem]<br>Review cadence: [Frequency] |

[Continue for low-risk assumptions - typically 3-7]

## **Assumption Distribution Analysis**
**By Type:**
* Desirability: [X assumptions] ([% risky])
* Usability: [X assumptions] ([% risky])
* Feasibility: [X assumptions] ([% risky])
* Viability: [X assumptions] ([% risky])
* Ethical: [X assumptions] ([% risky])

**Risk Profile:**
* High-Risk (Risky): [X] assumptions
* Low-Risk (Non-Risky): [X] assumptions

**Insights:** [Comment on any imbalances - e.g., "Heavy concentration in desirability assumptions suggests solution-first thinking" or "Lack of ethical assumptions indicates potential blind spot"]

## **Prioritized Testing Roadmap**
**Phase 1: Pre-Development Validation** (Must complete before build starts)

| Priority | Assumption # | Type | Testing Method | Duration | Owner | Blocker? |
| -------- | ------------ | ------ | -------------- | -------------- | ------ | -------- |
| P0 | [#] | [Type] | [Method] | [X days/weeks] | [Role] | Yes/No |
| P0 | [#] | [Type] | [Method] | [X days/weeks] | [Role] | Yes/No |
| P1 | [#] | [Type] | [Method] | [X days/weeks] | [Role] | No |

**Total estimated time:** [X weeks] **Recommended start:** [Timeframe relative to development timeline]

**Phase 2: During Development** (Validate as you build)

| Priority | Assumption # | Type | Testing Method | Timing | Owner |
| -------- | ------------ | ------ | -------------- | ----------------------- | ------ |
| P0.5 | [#] | [Type] | [Method] | [Sprint X or milestone] | [Role] |
| P1 | [#] | [Type] | [Method] | [Sprint X or milestone] | [Role] |

**Phase 3: Beta/Soft Launch Validation** (Test with real users before full rollout)

| Assumption # | Type | Testing Method | Success Criteria | Go/No-Go Impact |
| ------------ | ------ | -------------- | ------------------ | ----------------------- |
| [#] | [Type] | [Method] | [Metric/threshold] | [What happens if fails] |
| [#] | [Type] | [Method] | [Metric/threshold] | [What happens if fails] |

**Phase 4: Post-Launch Monitoring** (Track continuously)
* [List assumptions to monitor with metrics and review cadence]

## **Key Insights & Recommendations**
🚨** Riskiest Assumptions** (Highest threat to success)
1. **[Assumption #X - Type]:** [Why this is critical and what happens if wrong]
2. **[Assumption #X - Type]:** [Why this is critical and what happens if wrong]
3. **[Assumption #X - Type]:** [Why this is critical and what happens if wrong]

⚡** Quick Wins** (Can test fast and cheap)
* **[Assumption #X]:** [Why this is easy to validate and recommended approach]
* **[Assumption #X]:** [Why this is easy to validate and recommended approach]

🔍** Blind Spots** (Areas of overconfidence without evidence)
* [Call out areas where PRD states things as fact without evidence]
* [Highlight missing assumption types - e.g., no ethical considerations]
* [Note any groupthink or confirmation bias patterns]

💡** Opportunity Areas** (Where learning could unlock additional value)
* [Assumptions that if validated could expand scope or impact]
* [Areas where deeper research might reveal new opportunities]

## **Recommended Next Steps**
**Immediate Actions** (Next 1-2 weeks)
1. [Specific action - e.g., "Schedule 8 user interviews with heavy Favorites users to test Assumptions #1, #3, #5"]
2. [Specific action - e.g., "Conduct technical spike on recommendation algorithm to validate Assumption #12"]
3. [Specific action - e.g., "Review privacy implications with legal team for Assumptions #18, #19"]

**Before Development Starts**
* Complete Phase 1 testing (estimated [X] weeks)
* Update PRD with validated learnings
* Revise hypothesis and metrics based on findings
* Adjust scope if critical assumptions invalidated

**During Development**
* Integrate Phase 2 testing into sprint planning
* Create lightweight prototypes for usability validation
* Set up analytics to track proxy metrics

**Before Launch**
* Complete Phase 3 beta testing with clear go/no-go criteria
* Document any unvalidated assumptions for post-launch monitoring
* Create contingency plans for risky assumptions

## **Integration with PRD**
**Recommended PRD Updates:**
Add an "Assumptions and Risks" section with this table:

| Assumption | Type | Importance | Evidence | Risk | Validation Plan | Status |
| ----------------------------------- | ---- | ---------- | -------- | ---- | --------------- | ----------- |
| [Copy risky assumptions from above] |  |  |  |  |  | Not Started |

Update the PRD's "Success Metrics" section to include:
* Assumption validation metrics (e.g., "75% of interviewed users express intent to use Albums")
* Early indicators for monitoring low-risk assumptions

Update timeline to include:
* Assumption testing phases with go/no-go decision points
* Contingency time if assumptions are invalidated

## **QUALITY CHECKLIST**
Before finalizing this analysis, verify:
* Each assumption is stated as a specific, testable belief (not vague)
* Assumptions map to specific PRD sections for traceability
* All 5 assumption types are represented (Desirability, Usability, Feasibility, Viability, Ethical)
* Risk classification consistently uses the importance + evidence matrix
* Testing recommendations are specific (method + sample size/timeline + success criteria)
* The most critical assumptions that could kill the initiative are identified
* At least 12-20 total assumptions identified for a comprehensive PRD
* Balance across assumption types (not dominated by one type)
* Evidence assessment is honest (doesn't inflate PRD's confidence level)
* Ethical and accessibility considerations are not overlooked
* Recommendations are actionable with clear owners and timelines
* Testing roadmap aligns with PRD timeline and identifies blockers

**Important Notes:**
* Be comprehensive: A typical PRD has 15-25 meaningful assumptions. Fewer suggests surface-level analysis.
* Challenge certainty: If the PRD states something as fact without evidence, call it out as an assumption.
* Look for what's missing: Often the biggest risks are assumptions so ingrained they're invisible (e.g., ethical considerations).
* Be specific: "Users will like this" is too vague. "Users will prefer organizing favorites into albums vs. using tags" is testable.
* Connect to outcomes: Every assumption should clearly link to PRD's hypothesis or success metrics.

Begin your comprehensive assumption analysis now. Uncover hidden beliefs, challenge stated certainties, and provide an actionable testing roadmap that de-risks this initiative.
Write your complete analysis inside <assumption_analysis> tags.
