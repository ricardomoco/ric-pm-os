# Assumption Identification & Evaluation

Reference for the **Assumptions** mode of the PRD Analysis skill. Applies Teresa Torres' Continuous Discovery Habits framework to systematically uncover and prioritize hidden assumptions in Product Requirements Documents.

---

## Scratchpad Analysis

Before identifying any assumptions, you MUST perform a structured analysis of the PRD inside a `<scratchpad>` block. This ensures thorough extraction and prevents missed assumptions.

### Step 1: Extract Key PRD Elements

For each element, quote or summarize what the PRD states:

| Element | What to Extract |
|---------|----------------|
| **Problem Statement** | What problem is being solved? For whom? How is it framed? |
| **Proposed Solution** | What is the product/feature? What does it do? |
| **Target Users** | Who are the users? How are they segmented? What personas are referenced? |
| **Hypothesis** | What is the explicit or implicit hypothesis? (If X, then Y, because Z) |
| **Success Metrics** | What metrics define success? What targets are set? |
| **Timeline & Scope** | What is the delivery timeline? What is in/out of scope? |
| **Technical Approach** | What technologies, integrations, or architectures are proposed? |
| **Dependencies** | What does this depend on (teams, systems, data, third parties)? |
| **Risks Mentioned** | What risks does the PRD already acknowledge? |

### Step 2: Identify Explicit vs. Implicit Claims

- **Explicit claims**: Statements the PRD makes directly (e.g., "Users want X", "This will increase Y by Z%").
- **Implicit claims**: Unstated beliefs the PRD relies on (e.g., assumes users have a certain mental model, assumes data is available, assumes no regulatory blockers).

For each claim, note:
- The PRD section where it appears
- Whether evidence is provided
- The strength of that evidence (data, research, opinion, none)

### Step 3: Map Claims to the 5 Assumption Types

Categorize every explicit and implicit claim into one of the five assumption types defined below. A single claim may map to multiple types.

### Step 4: Assess Evidence Quality

For each assumption, rate the evidence:
- **Strong**: Backed by quantitative data, validated research, or production metrics
- **Moderate**: Supported by qualitative research, analogous data, or expert opinion
- **Weak**: Based on intuition, outdated data, or anecdotal evidence
- **None**: No supporting evidence provided

### Step 5: Flag Clarification Needs

List any areas where the PRD is ambiguous, contradictory, or missing critical information that prevents assumption evaluation.

---

## Assumption Framework Guide

### Type 1: Desirability Assumptions

**Definition:** Assumptions about whether users actually want, need, or would choose this product/feature over alternatives. These address the fundamental question: *Will anyone use this?*

**Example Assumptions from PRDs:**
1. "Users currently struggle with [problem] and actively seek a solution" — Assumes the pain is real and top-of-mind
2. "Users will prefer our solution over the current workaround" — Assumes switching cost is acceptable
3. "This feature addresses the needs of [segment]" — Assumes correct segment identification
4. "Users will adopt this within [timeframe]" — Assumes adoption speed
5. "The value proposition is compelling enough to drive behavior change" — Assumes motivation exceeds friction
6. "Users will choose this over competitor offerings" — Assumes competitive advantage is perceived
7. "Demand exists at sufficient scale to justify development" — Assumes market size

**Where to Look in PRDs:**
- Problem statement and user pain points
- Target audience and persona definitions
- User stories and jobs-to-be-done
- Value proposition sections
- Market opportunity estimates
- Competitive analysis

**Red Flags:**
- No user research cited for the stated problem
- Problem framed from company perspective, not user perspective
- "Users want..." statements without evidence
- No mention of alternatives users currently use
- Assumed adoption rates without historical benchmarks
- Single persona representing diverse user groups

---

### Type 2: Usability Assumptions

**Definition:** Assumptions about whether users can successfully understand, navigate, and achieve their goals with the proposed solution. These address: *Can users figure this out?*

**Example Assumptions from PRDs:**
1. "Users will understand the new UI without onboarding" — Assumes discoverability and learnability
2. "The flow from A to B is intuitive" — Assumes mental model alignment
3. "Users will complete the multi-step process" — Assumes acceptable friction tolerance
4. "Power users and novices can use the same interface" — Assumes one-size-fits-all works
5. "Users will find and use this feature" — Assumes discovery path is clear
6. "Error recovery is straightforward" — Assumes users can self-correct
7. "The terminology used is understood by all user segments" — Assumes shared vocabulary

**Where to Look in PRDs:**
- User flows and wireframes
- Acceptance criteria and interaction descriptions
- Onboarding and education sections
- Accessibility requirements
- Multi-step processes and forms
- Error handling specifications

**Red Flags:**
- Complex flows with no usability testing planned
- Assumed familiarity with domain-specific concepts
- No mention of error states or recovery paths
- "Intuitive" used without supporting evidence
- No consideration of accessibility or diverse user needs
- Missing empty states, loading states, or edge case UI

---

### Type 3: Feasibility Assumptions

**Definition:** Assumptions about whether the team can build, deliver, and operate the solution with available resources, technology, and expertise. These address: *Can we actually build this?*

**Example Assumptions from PRDs:**
1. "The existing API can handle the required throughput" — Assumes infrastructure capacity
2. "The ML model will achieve acceptable accuracy" — Assumes technical performance
3. "We can integrate with [third-party service]" — Assumes API compatibility and reliability
4. "The team can deliver within the stated timeline" — Assumes resource availability and velocity
5. "The data needed for this feature is available and clean" — Assumes data readiness
6. "This is backward-compatible with the current system" — Assumes no breaking changes
7. "Performance will remain acceptable at scale" — Assumes scalability

**Where to Look in PRDs:**
- Technical approach and architecture sections
- Timeline and milestones
- Dependencies and integration points
- Data requirements
- Performance requirements (latency, throughput, availability)
- Team capacity and skill requirements

**Red Flags:**
- No engineering input on estimates
- Novel technology with no proof of concept
- Hard deadlines with unclear scope
- Dependencies on systems the team doesn't own
- Data requirements without confirmed data availability
- "Simple" or "straightforward" used for technically complex work
- No mention of technical debt or migration costs

---

### Type 4: Viability Assumptions

**Definition:** Assumptions about whether the solution works for the business — financially, strategically, operationally, and legally. These address: *Should we build this?*

**Example Assumptions from PRDs:**
1. "This feature will generate [X] revenue or save [Y] cost" — Assumes financial impact
2. "This aligns with the company's strategic direction" — Assumes strategic fit
3. "Customer support can handle the change" — Assumes operational readiness
4. "The ROI justifies the investment" — Assumes return calculations are correct
5. "This won't cannibalize existing revenue streams" — Assumes no negative business impact
6. "We can sustain this operationally post-launch" — Assumes maintenance burden is manageable
7. "This is compliant with current regulations" — Assumes legal/regulatory alignment

**Where to Look in PRDs:**
- Business case and ROI sections
- Strategic alignment statements
- Operational impact assessments
- Revenue and cost projections
- Legal and compliance sections
- Resource allocation and opportunity cost discussions
- Stakeholder alignment sections

**Red Flags:**
- No business case or ROI analysis
- Revenue projections without clear methodology
- Missing operational impact assessment
- No mention of opportunity cost
- Assumed stakeholder buy-in without evidence
- "Strategic priority" stated without linking to company OKRs
- No consideration of maintenance and support costs

---

### Type 5: Ethical Assumptions

**Definition:** Assumptions about responsible use, privacy, fairness, accessibility, and unintended consequences. These address: *Should we build this, ethically?*

**Example Assumptions from PRDs:**
1. "Users will consent to data collection as described" — Assumes informed consent is sufficient
2. "The algorithm treats all user groups fairly" — Assumes no bias in models or data
3. "This feature doesn't create harmful incentives" — Assumes no negative externalities
4. "User data is adequately protected" — Assumes security measures are sufficient
5. "This is accessible to users with disabilities" — Assumes inclusive design
6. "The feature doesn't enable misuse or abuse" — Assumes bad actors are accounted for
7. "Dark patterns are not present in the design" — Assumes ethical UX practices

**Where to Look in PRDs:**
- Data collection and privacy sections
- Personalization and algorithm descriptions
- Accessibility requirements
- Terms of service and consent flows
- Moderation and abuse prevention
- Impact on vulnerable user populations
- Environmental or social impact sections

**Red Flags:**
- No privacy impact assessment
- Personalization without fairness evaluation
- Missing accessibility requirements
- No abuse or misuse scenarios considered
- Data collection beyond what's needed for the feature
- No mention of consent mechanisms
- Gamification without considering addictive patterns
- Features affecting children or vulnerable populations without safeguards

---

## Risk Classification Matrix

Use this matrix to classify each assumption by combining its **Importance** (impact if wrong) and **Evidence Strength** (confidence it's correct).

| Evidence \ Importance | **HIGH** | **MEDIUM** | **LOW** |
|---|---|---|---|
| **High** (strong data, validated research) | Non-Risky | Non-Risky | Non-Risky |
| **Medium** (qualitative research, analogous data) | Risky | Non-Risky | Non-Risky |
| **Low** (intuition, no data, outdated info) | Risky | Risky | Non-Risky |

### Definitions

**Risk Level:**
- **Risky (HIGH)**: Low evidence + High importance, OR Medium evidence + High importance. These are the assumptions that can derail the initiative if wrong, and we don't have strong evidence they're correct. **Test these first.**
- **Risky (MEDIUM)**: Low evidence + Medium importance. Could cause problems but unlikely to be fatal. **Test before scaling.**
- **Non-Risky**: Either well-supported by evidence OR low-impact if wrong. **Monitor but don't block on testing.**

**Importance Criteria:**
- **HIGH**: If this assumption is wrong, the initiative fails or causes significant harm. Core to the value proposition, affects primary metrics, or has legal/safety implications.
- **MEDIUM**: If wrong, the initiative underperforms or requires significant rework. Affects secondary metrics, user experience quality, or operational efficiency.
- **LOW**: If wrong, minor adjustments needed. Affects nice-to-have features, cosmetic elements, or edge cases.

**Evidence Strength Criteria:**
- **High**: Quantitative data from production, validated user research (n>=10 for qualitative, statistically significant for quantitative), proven patterns from analogous features, or regulatory/technical certainty.
- **Medium**: Qualitative research (small sample), expert opinion, data from related but not identical contexts, industry benchmarks, or competitive analysis.
- **Low**: Gut feeling, untested hypotheses, outdated data (>12 months), anecdotal evidence, or no evidence at all.

---

## Testing Recommendation Framework

For each assumption type, recommend appropriate testing methods based on the risk classification.

### Desirability Testing Methods

| Method | When to Use | Effort | Confidence |
|--------|------------|--------|------------|
| **User Interviews (Problem)** | Validate problem existence and severity. Early stage. | Low | Medium |
| **Survey / Quantitative Validation** | Validate demand at scale. After qualitative signals. | Medium | High |
| **Fake Door / Painted Door Test** | Test demand before building. Pre-development. | Low | Medium-High |
| **Concierge / Wizard of Oz** | Test value prop with manual delivery. Pre-development. | Medium | High |
| **Competitive Analysis** | Understand alternatives users currently use. Any stage. | Low | Low-Medium |
| **Prototype Preference Test** | Compare proposed solution vs. alternatives. Pre-development. | Medium | Medium |

### Usability Testing Methods

| Method | When to Use | Effort | Confidence |
|--------|------------|--------|------------|
| **Moderated Usability Test** | Deep understanding of user interaction. During design. | Medium | High |
| **Unmoderated Remote Test** | Scale usability validation. After initial design. | Low-Medium | Medium |
| **First-Click Test** | Validate navigation and discoverability. Early design. | Low | Medium |
| **A/B Test (UI variants)** | Compare usability of design options. During development. | Medium | High |
| **Accessibility Audit** | Validate inclusive design. Before launch. | Medium | High |
| **Card Sorting / Tree Testing** | Validate information architecture. Early design. | Low | Medium |

### Feasibility Testing Methods

| Method | When to Use | Effort | Confidence |
|--------|------------|--------|------------|
| **Technical Spike / PoC** | Validate technical approach. Pre-development. | Medium | High |
| **Architecture Review** | Assess system design. Pre-development. | Low | Medium |
| **Load / Performance Testing** | Validate scalability. During development. | Medium | High |
| **Data Audit** | Confirm data availability and quality. Pre-development. | Low-Medium | High |
| **Third-Party Integration Test** | Validate external dependencies. Pre-development. | Medium | High |
| **Incremental Delivery** | Reduce risk through phased rollout. During development. | Low | Medium |

### Viability Testing Methods

| Method | When to Use | Effort | Confidence |
|--------|------------|--------|------------|
| **Business Case Review** | Validate financial assumptions. Pre-development. | Low | Medium |
| **Stakeholder Alignment Check** | Confirm organizational support. Pre-development. | Low | Medium |
| **Pilot / Limited Rollout** | Test business impact at small scale. Soft launch. | Medium | High |
| **Operational Readiness Assessment** | Validate support and ops capacity. Before launch. | Medium | High |
| **Legal / Compliance Review** | Confirm regulatory alignment. Pre-development. | Low-Medium | High |
| **Cannibalization Analysis** | Check impact on existing products. Pre-development. | Medium | Medium |

### Ethical Testing Methods

| Method | When to Use | Effort | Confidence |
|--------|------------|--------|------------|
| **Privacy Impact Assessment (PIA)** | Evaluate data handling. Pre-development. | Medium | High |
| **Algorithmic Bias Audit** | Check fairness in models/algorithms. During development. | High | High |
| **Accessibility Compliance Review** | Validate WCAG/ADA compliance. Before launch. | Medium | High |
| **Abuse Scenario Modeling** | Identify misuse potential. Pre-development. | Low-Medium | Medium |
| **Ethics Review Board** | Get independent ethical assessment. Pre-development. | Medium | High |
| **User Consent Flow Testing** | Validate informed consent UX. During development. | Low | Medium |

---

## Output Format

Use this exact structure for the final output. Every section is mandatory.

```markdown
# Assumption Analysis: [PRD Title]

## Executive Summary

[2-3 sentence summary: total assumptions found, risk distribution, most critical finding, and primary recommendation.]

---

## PRD Strengths

[3-5 bullet points identifying what the PRD does well — areas with strong evidence, clear thinking, or thorough analysis.]

## Critical Gaps

[3-5 bullet points identifying the most significant missing elements, weak evidence areas, or logical gaps in the PRD.]

---

## Identified Assumptions

### HIGH Risk Assumptions

| # | Assumption | Type | PRD Section | Importance | Evidence | Risk | Recommended Test |
|---|-----------|------|-------------|------------|----------|------|-----------------|
| 1 | [Specific, testable statement] | [D/U/F/V/E] | [Section name] | High | Low | HIGH | [Specific test method] |
| ... | ... | ... | ... | ... | ... | ... | ... |

**Details:**

#### Assumption H1: [Title]
- **Statement:** [The specific assumption, phrased as a testable belief]
- **Type:** [Desirability / Usability / Feasibility / Viability / Ethical]
- **PRD Reference:** [Exact section or quote from the PRD]
- **Why It Matters:** [What happens if this assumption is wrong]
- **Current Evidence:** [What evidence exists, if any]
- **Evidence Gap:** [What's missing]
- **Recommended Test:** [Specific testing method with brief protocol]
- **Effort to Test:** [Low / Medium / High]
- **When to Test:** [Pre-dev / During dev / Beta / Post-launch]

[Repeat for each HIGH risk assumption]

### MEDIUM Risk Assumptions

| # | Assumption | Type | PRD Section | Importance | Evidence | Risk | Recommended Test |
|---|-----------|------|-------------|------------|----------|------|-----------------|
| ... | ... | ... | ... | ... | ... | ... | ... |

**Details:**

[Same detail structure as HIGH, for each MEDIUM risk assumption]

### LOW Risk Assumptions

| # | Assumption | Type | PRD Section | Importance | Evidence | Risk |
|---|-----------|------|-------------|------------|----------|------|
| ... | ... | ... | ... | ... | ... | ... |

[Summary table only — no detailed breakdown needed for LOW risk.]

---

## Assumption Distribution Analysis

### By Type
| Type | Count | HIGH Risk | MEDIUM Risk | LOW Risk |
|------|-------|-----------|-------------|----------|
| Desirability | | | | |
| Usability | | | | |
| Feasibility | | | | |
| Viability | | | | |
| Ethical | | | | |
| **Total** | | | | |

### Risk Profile
- **HIGH Risk:** [X] assumptions ([Y]% of total)
- **MEDIUM Risk:** [X] assumptions ([Y]% of total)
- **LOW Risk:** [X] assumptions ([Y]% of total)

### Key Insights from Distribution
[2-3 observations about what the distribution reveals — e.g., heavy desirability risk suggests need for user validation, absence of ethical assumptions suggests a blind spot, etc.]

---

## Prioritized Testing Roadmap

### Phase 1: Pre-Development (Week 1-2)
| Priority | Assumption | Test Method | Owner | Effort | Expected Duration |
|----------|-----------|-------------|-------|--------|-------------------|
| P0 | [Assumption ID + title] | [Method] | [Suggested role] | [L/M/H] | [Days/weeks] |
| ... | ... | ... | ... | ... | ... |

### Phase 2: During Development (Ongoing)
| Priority | Assumption | Test Method | Owner | Effort | Expected Duration |
|----------|-----------|-------------|-------|--------|-------------------|
| ... | ... | ... | ... | ... | ... |

### Phase 3: Beta / Soft Launch
| Priority | Assumption | Test Method | Owner | Effort | Expected Duration |
|----------|-----------|-------------|-------|--------|-------------------|
| ... | ... | ... | ... | ... | ... |

### Phase 4: Post-Launch
| Priority | Assumption | Test Method | Owner | Effort | Expected Duration |
|----------|-----------|-------------|-------|--------|-------------------|
| ... | ... | ... | ... | ... | ... |

---

## Key Insights

### Riskiest Bets
[Top 2-3 assumptions that pose the greatest threat to the initiative's success. Explain why.]

### Quick Wins
[2-3 assumptions that can be validated quickly and cheaply, reducing overall risk.]

### Blind Spots
[Areas the PRD doesn't address at all — types of assumptions that are entirely absent or underrepresented.]

### Opportunity Areas
[1-2 opportunities where validating an assumption could unlock additional value or scope expansion.]

---

## Recommended Next Steps

### Immediate (This Week)
1. [Specific action with owner suggestion]
2. [Specific action with owner suggestion]
3. [Specific action with owner suggestion]

### Before Development Starts
1. [Specific action with owner suggestion]
2. [Specific action with owner suggestion]

### During Development
1. [Specific action with owner suggestion]
2. [Specific action with owner suggestion]

### Before Launch
1. [Specific action with owner suggestion]
2. [Specific action with owner suggestion]

---

## Integration with PRD

### Recommended PRD Updates
[Specific sections of the PRD that should be updated based on this analysis, with concrete suggestions for what to add or change.]

1. **[Section Name]**: [What to add/change and why]
2. **[Section Name]**: [What to add/change and why]
3. ...
```

---

## Quality Checklist

Before delivering the analysis, verify every item:

- [ ] Each assumption is **specific and testable** — not vague or generic
- [ ] Each assumption **maps to a specific PRD section** with a reference or quote
- [ ] All **5 assumption types are represented** — if a type has zero assumptions, explicitly note it as a blind spot
- [ ] **12-20+ assumptions identified** for a comprehensive PRD (fewer for lightweight PRDs, with justification)
- [ ] **Balance across types** — no single type dominates without explanation
- [ ] **Evidence assessment is honest** — "Low" means Low, don't inflate confidence
- [ ] **Ethical considerations are not overlooked** — at least 1-2 ethical assumptions for any feature involving user data, algorithms, or behavioral nudges
- [ ] **Testing recommendations are practical** — appropriate for the team's stage and resources
- [ ] **Risk classification is consistent** — same evidence/importance combination always yields the same risk level
- [ ] **No invented data** — all evidence references point to real PRD content or explicitly state "no evidence provided"
- [ ] **Scratchpad analysis is thorough** — all 5 steps completed before assumption identification
- [ ] **Output follows the exact template** — no sections skipped or reordered
