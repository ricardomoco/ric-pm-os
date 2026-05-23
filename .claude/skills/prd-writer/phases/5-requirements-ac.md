# Phase 5: Requirements & Acceptance Criteria

Define the detailed requirements table with testable acceptance criteria in Gherkin syntax.

## Inputs Needed
- Validated Phase 1-2 output (problem + solution)
- Phase 6 output if available (flows & edge cases inform requirements)
- Design specs, Figma files, or wireframes

## If the feature uses AI / ML / generative / scoring models

Run **Phase 5b (AI Behavior Contract)** in addition to this phase. Phase 5 produces functional acceptance criteria; Phase 5b produces the behavior contract (15-25 labelled examples + red team scenarios + offline eval rubric). Both are required for AI features at Stage 3 (Solution Review).

## Specificity over vagueness — two transformations

The most common requirements failure is "ACs that look testable but aren't." Force the writer to escape:

**Bad — outcome unobservable:**
> Given a user opens the IDP, When they see the verified badge, Then they feel confident.

**Good — outcome observable and measurable:**
> Given a private seller has completed [example PSP] KYC, When the buyer views the IDP, Then the verified badge appears integrated in the account-type description below the seller name AND tapping it opens the Legal-approved KYC bottom sheet within 200ms.

**Bad — compound Then:**
> Then the badge shows AND the modal opens AND analytics fire AND no error is logged.

**Good — one behaviour per AC:**
> Scenario 1: Then the badge appears.
> Scenario 2: Then tapping the badge opens the modal.
> Scenario 3: Then `verified_badge_shown` event fires with seller_type and verifier attributes.

If "feel confident", "have a smooth experience", or "see good results" appear in a Then clause, push back.

## Process

### 1. Extract Requirements
From the solution definition and user flows, extract every discrete requirement:
- **Functional requirements**: What the system must do
- **Non-functional requirements**: Performance, security, accessibility, localization
- **Analytics requirements**: What events and properties need tracking

### 2. Structure the Requirements Table

| ID | Requirement | Priority | Acceptance Criteria | Platform | Notes |
|---|---|---|---|---|---|
| R-001 | [Requirement description] | P0/P1/P2 | Given/When/Then | All/iOS/Android/Web/BE | [Context] |

### 3. Write Acceptance Criteria (Gherkin)
Every requirement MUST have at least one AC in Given/When/Then format:

```gherkin
Scenario: [Descriptive name]
  Given [initial context or precondition]
  When [action or event occurs]
  Then [observable, testable outcome]
```

**Rules**:
- Each AC tests one behavior — no compound Then clauses
- Include happy path AND key error/edge scenarios
- "Then" must be observable and testable — no "user feels confident"
- Cover platform-specific behavior where it differs

### 4. Prioritize
- **P0**: Must ship. Feature doesn't work without it.
- **P0.5**: Priority / Mid risk. Deliver before experiment; mid-experiment deploy if needed.
- **P1**: Should ship. Significantly degrades experience without it.
- **P2**: Nice to have. Can ship without, iterate later.

### 5. Cross-reference with Phase 5b for AI features

If the feature uses AI:
- Phase 5 ACs cover **functional behaviour** ("the badge renders," "the API returns X")
- Phase 5b examples cover **AI behaviour** ("model output matches the labelled example for input Y")
- Both are required. Don't merge. The dev team uses Phase 5 ACs for functional QA and Phase 5b for behaviour validation against the offline eval golden set.

## Output
Populate the **Requirements** section of the PRD template ([references/template.md](../references/template.md)).

## Quality Gate
Before proceeding to Phase 6, validate:
- [ ] Every requirement has at least one Gherkin AC
- [ ] No "Then user feels X" or other unobservable outcomes
- [ ] No compound Then clauses (one behaviour per AC)
- [ ] P0 requirements cover the core happy path
- [ ] Edge cases from Phase 6 (if done) are reflected
- [ ] No implementation details in requirements (what, not how)
- [ ] Analytics/tracking requirements included
- [ ] If AI feature, Phase 5b is queued

Present output to user for validation before proceeding.
