**Stage:** `Stage 1: Speclet` | `Stage 2: Kickoff` | `Stage 3: Solution Review` | `Stage 4: Launch Readiness` | `Stage 5: Impact Review`

> Pick one. Update as the PRD evolves. See §Stage Lifecycle below for what each stage requires and the gate to advance.

# 📌 Executive Summary
[2-3 sentences max. What are we building, why does it matter, what's the expected impact.]

# 🔄 Stage Lifecycle

This PRD is an evolving document. It starts as a brief in quarterly planning and evolves through discovery, specs, design exploration, launch, and post-launch review.

| Stage | What this stage contains | When it begins | Gate to next stage |
| :--- | :--- | :--- | :--- |
| **1: Speclet** | Executive Summary, Core Problem, Hypothesis, Strategy Fit, Motivating Data + 3 quotes, light Solution Vision (Phases 1-2) | Quarterly planning — the initiative brief | CPO / PL alignment to build |
| **2: Kickoff** | Adds: scope/non-goals, Metrics with MDE, Graduation Criteria, impact sizing model (Phase 3) | EM commits resources; data confirms detectability | Refinement meeting agrees the spec is buildable |
| **3: Solution Review** | Adds: Requirements & AC, Flows & Edge Cases, Behavior Spec for AI features (Phases 5, 5b, 6) | Refinement complete; engineering can build from this | Final tech review + cross-tribe dep sign-off |
| **4: Launch Readiness** | Adds: Phased Rollout with Ramp Gates, Kill Switch, Tracking & Analytics, Pre-Launch Checklist signed off (Phase 7) | All track owners (Eng / Design / Data / Legal / Ops) signed off | Dial-up |
| **5: Impact Review** | Adds: Results, what surprised us, annex new good/bad/reject examples (if AI), iterate/scale/retire decision | Experiment analysis complete | — |

The stage label tells reviewers what kind of feedback to give. Don't ask for Phase 7 details on a Stage 1 PRD; don't approve a Stage 4 PRD without the rollout gates filled in.

# 🎯 Objective

## Core Problem
[One sentence describing the issue.]

## Working Hypothesis
[One sentence proposed solution. "We believe [user] will [behavior] because [reason], leading to [outcome]."]

## Strategy Fit
[Which company bet/initiative this enables. Cite the parent strategy or vision doc.]

## Motivating Data
- Metric 1: [Current state, source]
- Metric 2: [Gap to target]
- Metric 3: [Market benchmark]

**User quotes (3 minimum):**
1. "[Verbatim quote]" — [Segment, source]
2. "[Verbatim quote]" — [Segment, source]
3. "[Verbatim quote]" — [Segment, source]

# 📊 Metrics

## 🚀 Launch Metrics

| Goal | Metric | Baseline | Target | MDE | Window |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [Objective] | [Definition] | [Current] | [Target with %] | [Min detectable effect] | [Days needed] |

## 🤓 Supporting Metrics

| Goal | Metric | Baseline | Target | Window |
| :--- | :--- | :--- | :--- | :--- |
| [Objective] | [Definition] | [Current] | [Target] | [Days] |

## 🔴 Guardrail Metrics

| Metric | Current | Acceptable Range | Alert Threshold |
| :--- | :--- | :--- | :--- |
| [Metric] | [Baseline] | [Min–Max] | [When to alarm] |

## 🎓 Graduation Criteria

When do we scale to 100%? Be explicit:

- [ ] Primary metric hits target at p<0.05
- [ ] No guardrail violations for [N] consecutive days
- [ ] [Stakeholder] approval (e.g. Finance on cost, Legal on copy)
- [ ] [Other gate]

# ❔ Identified Pain Points

| Pain point | User personas affected | Comments |
| :--- | :--- | :--- |
| [Issue] | [Persona] | [Comments / cite source] |

# 🤔 Assumptions

| # | Assumption (We believe…) | Type | Importance | Evidence | Risk |
| :--- | :--- | :--- | :--- | :--- | :--- |
| A1 | [Specific testable belief] | D/U/F/V/E | H/M/L | H/M/L | Risky/Safe |

[Type legend: D=Desirability, U=Usability, F=Feasibility, V=Viability, E=Ethical. For full assumption analysis, run `/assumption-identifier`.]

# 💣 Risks

## User Risks

| Risk | Likelihood | Impact | Detection | Mitigation |
| :--- | :--- | :--- | :--- | :--- |
| [Risk] | L/M/H | L/M/H | [How spotted: metric/threshold] | [Concrete action] |

## Platform / Legal Risks

| Risk | Likelihood | Impact | Detection | Mitigation |
| :--- | :--- | :--- | :--- | :--- |
| [Risk] | L/M/H | L/M/H | [How spotted] | [Concrete action] |

## Business Risks

| Risk | Likelihood | Impact | Detection | Mitigation |
| :--- | :--- | :--- | :--- | :--- |
| [Risk] | L/M/H | L/M/H | [How spotted] | [Concrete action] |

# 🗒️ Requirements

**Priority Definitions:**
- P0: Blocker / High Risk
- P0.5: Priority / Mid Risk
- P1: Desirable / MVP Iteration
- P2: Low ROI / Long-term

| Requirement | User story | Importance | Jira issue | Acceptance Criteria | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [Constraint] | As a... I want... So that... | [P0–P2] | [Leave Blank] | [Gherkin: Given/When/Then] | [Tech notes] |

# 🎨 User Interaction and Design

[Mockups, Figma links, interaction map. For AI features, cross-reference §Behavior Specification below.]

# 🤖 Behavior Specification

[Required for AI / ML / generative / recommendation / scoring features. Otherwise leave as "N/A — not an AI feature." Run Phase 5b (`5b-ai-behavior-contract.md`) to populate. Aim for 15–25 labelled examples covering good, bad, and reject cases. Include red-team scenarios (PII echo, prompt injection, gibberish, very long input) and offline-eval golden set.]

# 🧪 Experiment Details

## Phased Rollout

**Phase 1 — Initial Launch**
- **Exposure:** [%] of [country/segment] users
- **Randomization:** [User-level / session / cluster]
- **Duration:** [N] days minimum
- **Gate to Phase 2:** [Specific criteria — primary metric ≥ X, no P0 incidents, etc.]

**Phase 2 — Expansion**
- **Exposure:** [%] if Gate 1 passed
- **Duration:** [N] days
- **Gate to Phase 3:** [Specific criteria]

**Phase 3 — Scale**
- **Exposure:** [%] → 100%
- **Final Gate:** Graduation criteria met (see §Metrics)

## Setup
- **Countries:** ES, IT, PT
- **Devices:** WEB, IOS, AND
- **Triggering behavior:** [Define distinct event to avoid over-triggering]

# 🛑 Kill Switch

- **Location:** [Feature flag dashboard path / CLI command]
- **Access:** [Roles authorised — typically on-call eng + PM + EM]
- **Activation time:** [Target — e.g. <60 seconds]
- **Rollback time to 0% traffic:** [Target — e.g. <5 minutes]
- **Trigger conditions:** [PII detected / safety incident / multiple P0s / guardrail breach above threshold]

# 📈 Tracking & Analytics

| Event Name | Trigger | Properties | Purpose |
| :--- | :--- | :--- | :--- |
| `[event_name]` | [When fired] | [Data captured] | [Metric served] |

# 🧑‍💼 Stakeholder and Cross-Tribe Considerations

| Who | Level of impact | Reviewed (yes/no) |
| :--- | :--- | :--- |
| [Tribe/Person] | [High/Med/Low] | [No] |

# 🌟 Milestones

*Do not add or remove rows. Only update Owner/Status if context permits.*

| Milestone | Owner | Status/ETA |
| :--- | :--- | :--- |
| First PRD draft complete | PM | PENDING |
| UX specs ready | UX Designer | PENDING |
| First review with Tech | PM | PENDING |
| Implement changes requested by Tech | PM | PENDING |
| Final Tech review and sign-off | PM | PENDING |
| Code complete | EM | PENDING |
| QA / Bug bash | QA Engineer | PENDING |
| Dial-up | EM | PENDING |
| Analysis complete | Analyst | PENDING |
| Code clean-up and launch | EM | PENDING |

# ✅ Pre-Launch Checklist

## Engineering
- [ ] Code reviewed and merged
- [ ] Unit tests passing (>80% coverage)
- [ ] Integration tests passing
- [ ] Load testing completed
- [ ] Feature flag configured
- [ ] Kill switch tested end-to-end
- [ ] Monitoring and alerting live
- [ ] Runbook documented

## Design
- [ ] Final mocks approved
- [ ] Mobile / Web parity validated
- [ ] Accessibility audit passed
- [ ] Copy finalised and Legal-approved (if applicable)

## Data / ML / Analytics
- [ ] Tracking events instrumented and validated end-to-end
- [ ] Dashboards created
- [ ] A/B test config validated
- [ ] Power analysis approved
- [ ] [If AI feature] Offline eval golden set passes threshold
- [ ] [If AI feature] Human review rubric ready

## Legal / Compliance
- [ ] Privacy review completed
- [ ] Regulated copy Legal-approved
- [ ] Data retention policy confirmed
- [ ] Security audit passed (if applicable)

## Operations / Support
- [ ] Customer support trained
- [ ] FAQ documentation created
- [ ] Escalation path defined
- [ ] Cost approval received (if applicable)

# ❓ Open Questions

| Question | Owner | Target | Status | Resolution |
| :--- | :--- | :--- | :--- | :--- |
| [Question] | [Name] | [Date] | Open / Resolved | [Answer] |

# ⚠️ Considered Edge Cases

| Edge case | Impacted? | How are we addressing this? |
| :--- | :--- | :--- |
| [Scenario] | Yes/No | [Resolution] |

# ⛔ Out of Scope

[List what is explicitly not addressed and why. Forces decision-making about boundaries.]

# 🗂️ Document History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 0.1 | [Date] | [Name] | Initial draft |
| 1.0 | [Date] | [Name] | Solution review version |
| 2.0 | [Date] | [Name] | Launch-ready |
| 3.0 | [Date] | [Name] | Post-launch results |

# 📎 Appendix

The appendix carries content that supports the main body but should NOT load the main reader's working memory. Stakeholders consume the main PRD; specialists consume the appendix.

## Reference links

- [Link to user research]
- [Link to competitive analysis]
- [Link to technical design doc]
- [Link to prior art]
- [Link to parent strategy / vision]

## Decision Log (optional)

Chronological log of substantive scope or sequencing changes. Each entry: date + one-line summary + link to the comment / Slack thread / meeting where it was decided. The main body always reflects the *current* state; the Decision Log lives here for traceability.

| Date | Change | Reference |
| :--- | :--- | :--- |
| [YYYY-MM-DD] | [one-line summary of the agreement / supersession / scope shift] | [LA-XXX / Slack link / meeting note] |

## Detailed risk context (optional)

When a Risks-table row needs deeper context (legal precedent, audit findings, vendor concerns, regulatory references), put the detail here as a subsection and link from the main Risks row.

### [Risk name — e.g., DSA-KYB audit findings]

[Full detail: dates, quotes, references, links. The main Risks table carries the one-row summary + mitigation; this section carries the supporting evidence.]

## Stakeholder position papers (optional)

When Trust & Safety, Legal, or another stakeholder team has issued substantive guidance that shapes the spec (audits, position memos, regulatory framings), reference it here. Do NOT reproduce the full guidance in the main body — link out and summarise.

- [Stakeholder team] [date]: [one-line summary] — [link]

## Out-of-band history (optional)

Prior experiments, archived PRDs, deprecated approaches that inform the current spec. One-line each with a link.
