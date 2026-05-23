# Phase 2: Solution Definition

Define the solution vision, scope boundaries, technical dependencies, and key product decisions.

## Inputs Needed
- Validated Phase 1 output (problem framing)
- User's solution ideas, designs, or constraints
- Any existing Figma links, wireframes, or technical context

## Process

### 1. Solution Vision
- **What**: High-level description of what the feature does — from the user's perspective, not implementation.
- **Why This Solution**: Why is this the right approach to the problem defined in Phase 1? What alternatives were considered and rejected?
- **Key Decisions**: Document non-obvious choices and their rationale (e.g., "We chose city-level granularity over exact address because of privacy constraints").

**If the feature uses ML / generative AI / recommendations / scoring models**, also note here that Phase 5b (AI Behavior Contract) will be required during Stage 3 (Solution Review). Don't skip this — it changes the scope of what engineering builds.

### 2. Scope Definition
- **In Scope**: Specific capabilities this initiative delivers. Be exhaustive.
- **Out of Scope**: What explicitly will NOT be addressed. Name it to prevent scope creep.

### 3. Technical Dependencies (with SLAs)

Required when the feature consumes any external system, service, or team's deliverable. Don't hand-wave — name the dependency, its SLA expectation, and the fallback when it's unavailable.

| System / Team | Purpose | SLA Required | Fallback if unavailable |
| :--- | :--- | :--- | :--- |
| [System / team / service name] | [What it does for this feature] | [Uptime % + latency target] | [What happens if it's down] |

Examples:
- "[example PSP] KYC API" — verifies private seller identity — 99.9% uptime, <100ms P50 — IDP shows no badge, no error to buyer
- "Artisans DSA KYB endpoint" — exposes business verification status — TBD per Phase 1 backend spike — no badge for affected sellers

If the feature touches another tribe's roadmap (e.g. Bumpers, T&S, Artisans, MMP, {{SELLER_TEAM}}, Search, {{DISTRIBUTION_TEAM}}), name the named PM/EM on the other side and link their commitment artifact (Jira epic, Confluence page). "We discussed it" is not a commitment.

### 4. User Experience
- **Core User Journey**: The primary happy-path flow from entry to completion.
- **Key Screens/States**: High-level description of what the user sees at each step.
- **Design References**: Link Figma files, wireframes, or mockups if available.

## Output
Populate these sections of the PRD template ([references/template.md](../references/template.md)):
- **Solution Vision** (within §Objective or §User Interaction & Design)
- **In Scope** / **Out of Scope** (top of template; non-goals matter)
- **Technical Dependencies with SLAs** (within §Stakeholder section or §Risks if dependency is risky)
- **User Experience Overview** (within §User Interaction & Design)

## Quality Gate
Before proceeding to Phase 3, validate:
- [ ] Solution directly addresses the problem from Phase 1
- [ ] Scope boundaries are explicit (in and out)
- [ ] Key decisions are documented with rationale
- [ ] Each technical dependency has SLA + fallback named
- [ ] Cross-tribe dependencies have named PM/EM owner with linked commitment
- [ ] If AI/ML feature, Phase 5b is flagged as required for Stage 3
- [ ] No implementation details masquerading as requirements

Present output to user for validation before proceeding.
