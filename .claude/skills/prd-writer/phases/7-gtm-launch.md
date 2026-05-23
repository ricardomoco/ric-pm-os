# Phase 7: GTM & Launch Plan

Create a comprehensive, executable Go-To-Market plan from the PRD or feature context provided by the user.

## First check: experiment-driven or one-shot launch?

Same branch as Phase 3:

- **Experiment-driven launch:** use the **Phased Rollout with Ramp Gates** approach below — exposure %, gate criteria per phase, dial-up.
- **One-shot launch (backend migration, regulated launch, infrastructure):** use the **Phased Deployment + Rollback Plan** approach in the Non-experiment branch at the bottom of this phase.

Both branches still produce a Kill Switch specification and a Pre-Launch Checklist — those are non-negotiable regardless of launch type.

## Specificity over vagueness — one transformation

**Bad — fantasy rollout:**
> "Start with a small percentage of users and gradually expand based on performance."

**Good — phased rollout with ramp gates:**
> "Phase 1: 5% of ES/IT/PT iOS users for 7 days. Gate to Phase 2: P50 reply time ≤45s for 3 consecutive days, no P0 incidents, adoption ≥15%. Phase 2: 25% if Gate 1 passed. Phase 3: 50% → 100% with full graduation criteria."

"Start small, then ramp" with no gates is a hope, not a plan.

Before creating the GTM plan, conduct strategic analysis:

<scratchpad>
Extract critical information:
- What product/feature is launching? What's the core value proposition?
- Who are target users? What segments and personas?
- What problem does this solve? What pain points are addressed?
- What's the timeline? (Pre-launch, launch, post-launch phases with dates)
- What are the success metrics? (Primary, secondary, guardrail, graduation)
- What business objectives or constraints exist?
- Is this B2B or B2C? New market or existing feature?
- What resources are available or implied?

Determine GTM approach:
* Should this be product-led, sales-led, or hybrid?
* What channels align with target user behavior?
* What's the rollout strategy? (Big bang, phased, A/B test)
* How do we drive awareness, adoption, and retention?
* What are the key risks and mitigation strategies?

Identify context for adaptation:
* Company stage: Startup, growth, enterprise?
* Market maturity: New category or competitive space?
* User sophistication: Technical or mainstream?
* Launch scope: MVP, major release, or iteration?

Note gaps to address:
* What information is missing but needed?
* What reasonable assumptions can I make?
* What should be flagged as "[TBD]" for stakeholder input?
</scratchpad>

Now generate a complete, actionable GTM plan. Keep it concise (aim for equivalent of 5-8 pages), specific to the PRD context, and execution-ready. Use clear headers, tables for structured data, and bullets for readability.

## Required Outputs (populate these PRD sections)

### 1. Phased Rollout with Ramp Gates

**Required output format:**

```markdown
## Phased Rollout

**Phase 1 — Initial Launch**
- **Exposure:** [%] of [country / segment / device] users
- **Randomization:** [User-level (stable) / session / cluster]
- **Duration:** [N] days minimum
- **Gate to Phase 2:** [Specific criteria — primary metric ≥ X for N days, no P0 incidents, adoption ≥ Y%, etc.]

**Phase 2 — Expansion**
- **Exposure:** [%] if Gate 1 passed
- **Duration:** [N] days
- **Gate to Phase 3:** [Specific criteria]

**Phase 3 — Scale**
- **Exposure:** [%] → 100%
- **Final Gate:** Graduation criteria met (see §Metrics)
```

Each gate must have **specific, measurable criteria**. "Performance is good" is not a gate. "P50 latency ≤200ms over 3 days AND adoption ≥25%" is.

### 2. Kill Switch

Required for any feature touching trust, payments, identity, regulated content, or anything where a defect can harm users at scale.

**Required output format:**

```markdown
## Kill Switch

- **Location:** [Feature flag dashboard path / CLI command / config service]
- **Access:** [Roles authorised — typically on-call eng + PM + EM]
- **Activation time:** [Target — e.g. <60 seconds]
- **Rollback time to 0% traffic:** [Target — e.g. <5 minutes]
- **Trigger conditions:** [Specific conditions — PII detected, safety incident, multiple P0s, guardrail breach]
```

"Be ready to roll back if needed" is not a kill switch. The fields above are.

### 3. Pre-Launch Checklist

Organise by track. Each track owner sign off independently.

```markdown
## Pre-Launch Checklist

### Engineering
- [ ] Code reviewed and merged
- [ ] Unit / integration tests passing
- [ ] Load testing completed
- [ ] Feature flag configured
- [ ] Kill switch tested end-to-end
- [ ] Monitoring and alerting live
- [ ] Runbook documented

### Design
- [ ] Final mocks approved
- [ ] Mobile / Web parity validated
- [ ] Accessibility audit passed
- [ ] Copy finalised and Legal-approved (if applicable)

### Data / ML / Analytics
- [ ] Tracking events instrumented and validated end-to-end
- [ ] Dashboards created
- [ ] Power analysis approved
- [ ] [If AI feature] Offline eval passes threshold
- [ ] [If AI feature] Human review rubric ready

### Legal / Compliance
- [ ] Privacy review completed
- [ ] Regulated copy Legal-approved
- [ ] Data retention policy confirmed

### Operations / Support
- [ ] Customer support trained
- [ ] FAQ / help-centre updated
- [ ] Escalation path defined
- [ ] Cost approval received (if applicable)
```

# **GO-TO-MARKET PLAN**

(Follow the structure: Launch Overview, Value Proposition & Positioning, Phased Rollout with Ramp Gates, Kill Switch, Marketing & Communication Plan, Success Metrics & Monitoring, Risk Management, Pre-Launch Checklist, Budget & Resources, Execution Timeline)

## **QUALITY CHECKLIST**

- [ ] All recommendations specific to this PRD?
- [ ] Phased rollout has explicit gate criteria per phase (or non-experiment branch used)?
- [ ] Kill switch specifies location, access, activation time, rollback time?
- [ ] Pre-launch checklist organised by track with track owners?
- [ ] Timeline aligns with PRD?
- [ ] Success metrics map to PRD §Metrics graduation criteria (or §Decision rule for one-shot)?
- [ ] Messaging addresses specific pain points?
- [ ] Contingency plans included?

## Non-experiment branch — Phased Deployment + Rollback Plan

When the launch is a one-shot (per Phase 3 classification), replace Phased Rollout with this:

### Phased Deployment

For one-shot launches, "phasing" means staging → canary → production, not user-traffic %. Required format:

```markdown
**Phase 1 — Staging validation**
- Test environment: [staging / shadow]
- Duration: [N hours / days]
- Pass criteria: [pre-launch validation criteria from §Phase 3]

**Phase 2 — Canary (if applicable)**
- Scope: [single region / single shard / dark-launch behind flag]
- Duration: [N hours]
- Pass criteria: [error rate <X%, latency under target, no P0 alerts]

**Phase 3 — Full production**
- Scope: 100% traffic
- Monitoring: [dashboards live, on-call paged for thresholds]
```

### Rollback Plan

For reversible launches:

```markdown
- **Rollback path:** [Feature flag off / DB revert script / config rollback]
- **Activation time:** [Target — e.g. <5 minutes]
- **Owner:** [On-call engineer / EM]
- **Trigger conditions:** [Specific alerts that warrant rollback]
```

For irreversible launches (e.g. one-way DB migration, regulated launch already announced):

```markdown
- **Rollback NOT possible.** Hotfix-forward only.
- **Hotfix on-call:** [Named engineer with capacity reserved for next release window]
- **Communication path:** [How users / internal teams hear about issues — e.g. status page, Slack channel]
- **Maximum tolerated impact before declaring failure:** [Threshold — e.g. >5% error rate sustained over 30 min]
```

If the writer can't name a rollback or hotfix path, the launch isn't ready. Push back.

### Kill Switch (still required)

Same format as the experiment branch — feature-flag location, access roles, activation time, trigger conditions. For irreversible launches, the Kill Switch may be partial (e.g. flag-off the new UI but the DB migration stays). Document what the Kill Switch actually disables.

### Pre-Launch Checklist (still required)

Same Eng / Design / Data / Legal / Ops format. Some boxes shift — for example, "Power analysis approved" becomes "Load test passed at 5x peak prod" for non-experiment launches.
