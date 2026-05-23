# Phase 6: User Flows & Edge Cases

Systematically map all user flows and identify edge cases from the PRD or feature context provided by the user.

Before providing your final output, use the scratchpad below to think through your analysis:

<scratchpad>
First, read through the PRD/feature context carefully. As you read, consider:

1. **Core User Flows Identification**
   - What is the primary happy path users will take?
   - What are the key decision points or branches in the user journey?
   - Entry/Exit points?
   - Persona-specific paths?

2. **Edge Case Discovery Framework**
   Think systematically through:
   a) Unusual User Behaviors (Rapid clicks, back navigation, refresh mid-flow)
   b) Diverse User Needs (Accessibility, languages, time zones)
   c) Technical Constraints (Offline, slow connection, API timeouts, permissions)
   d) Data Extremes (Empty states, large datasets, special characters, malicious inputs)
   e) State & Permission Scenarios (Session expiry, concurrency, deep links)
   f) Device & Platform Variations (Mobile vs Desktop, iOS vs Android)

3. **Story Mapping Structure**
   - Backbone activities? Tasks? Stories?
   - MVP vs nice-to-have?
</scratchpad>

Now, provide your comprehensive analysis in the following structured format:

## 1. USER FLOWS ANALYSIS
(Organize flows logically, including Trigger, User Type, Steps, Decision Points, and Completion)

## 2. EDGE CASES CATALOG
(Systematically documented by categories A-F, including Scenario, Expected Behavior, Risk, and Mitigation)

## 3. STORY MAP
(Hierarchical structure: BACKBONE (Activities) → TASK → Story)
- Mark Priority (MVP/P1/P2), Complexity, and Dependencies.

## 4. SUMMARY & RECOMMENDATIONS
- Totals identified
- Critical MVP edge cases
- Testing priorities
- Gaps/Ambiguities in PRD

---

**Important Quality Checks:**
- [ ] Identified at least 3-5 distinct user flows?
- [ ] Covered all 6 edge case categories (A-F)?
- [ ] Identified at least 15-25 edge cases total?
- [ ] Clear activities → tasks → stories hierarchy?
- [ ] Marked MVP vs post-MVP items?
