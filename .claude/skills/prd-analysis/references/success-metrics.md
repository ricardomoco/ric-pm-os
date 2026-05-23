# Success Metrics Framework

Reference for the **Success Metrics** mode of the PRD Analysis skill. Defines a comprehensive, 4-tier metrics framework that aligns measurement with business outcomes, ensures experiment rigor, and provides actionable diagnostic depth.

---

## Role

You are a **data-driven Senior Product Manager** specializing in experimentation design, analytics instrumentation, and aligning product metrics with business outcomes. You combine statistical rigor with practical product sense to ensure every initiative is measurable, every experiment is well-designed, and every metric tells a clear story.

---

## Framework: 4-Tier Metrics Hierarchy

Every initiative needs metrics at four levels. Each level serves a distinct purpose:

### Tier 1: Primary Metric(s)

The **key decision-making criterion** for the initiative. This is the metric that determines success or failure.

- Typically **1 metric**, maximum **2-3** for complex initiatives
- Must directly reflect the initiative's core objective
- Must be movable by this initiative (not too upstream or downstream)
- Must pass the **STEDII** evaluation (see below)

**STEDII Evaluation Criteria:**

| Criterion | Definition | Questions to Ask |
|-----------|-----------|-----------------|
| **Sensitivity** | The metric moves detectably when the feature has an effect | Can we detect a meaningful change within our sample size and experiment duration? What is the expected effect size? |
| **Trustworthiness** | The metric accurately reflects the underlying reality | Is it resistant to gaming or manipulation? Does it measure what we think it measures? Are there confounders? |
| **Efficiency** | The metric can be measured with acceptable cost and latency | Can we compute it in near-real-time? Does it require expensive data joins or manual tagging? |
| **Debuggability** | When the metric moves, we can determine why | Can we decompose it into sub-metrics? Can we segment it to isolate causes? |
| **Interpretability** | Stakeholders understand what the metric means and why it matters | Can you explain this metric in one sentence to a non-technical executive? Does a 5% change have intuitive meaning? |
| **Inclusivity** | The metric represents all relevant user segments, not just the loudest | Does it weight all users fairly? Could it mask harm to a minority segment? Does it cover the full funnel or just converters? |

### Tier 2: Secondary Metrics

**Driver metrics** that connect feature behavior to business goals. These help contextualize the primary metric and provide a broader view of impact.

Use one or both frameworks to identify secondary metrics:

**HEART Framework (User-Centered):**
| Dimension | Definition | Example Metrics |
|-----------|-----------|----------------|
| **Happiness** | User satisfaction and sentiment | NPS, CSAT, in-app rating, qualitative feedback sentiment |
| **Engagement** | Depth and frequency of interaction | Sessions per user, actions per session, feature usage frequency |
| **Adoption** | New users or new usage of the feature | Activation rate, first-time feature users, % of eligible users who try it |
| **Retention** | Users who continue using over time | D7/D30 retention, churn rate, repeat usage rate |
| **Task Success** | Ability to complete core tasks | Completion rate, time-to-complete, error rate |

**AARRR Framework (Business-Centered):**
| Stage | Definition | Example Metrics |
|-------|-----------|----------------|
| **Acquisition** | How users discover the feature | Impressions, click-through from entry points, organic discovery rate |
| **Activation** | First meaningful experience | Onboarding completion, first successful action, time-to-value |
| **Revenue** | Monetization impact | Revenue per user, conversion to paid, ARPU change |
| **Retention** | Ongoing usage | Return rate, session frequency, feature stickiness |
| **Referral** | Users bringing other users | Share rate, viral coefficient, invitation conversion |

### Tier 3: Guardrail Metrics

**Trip-wire metrics** that prevent harmful changes even if the primary metric improves. Guardrails protect against unintended negative consequences.

Common guardrail categories:
- **User Experience:** Page load time, error rate, crash rate, accessibility score
- **Business Health:** Revenue, margin, support ticket volume, refund rate
- **Platform Health:** Server latency, API error rate, infrastructure cost
- **User Trust:** Report rate, block rate, fraud incidents, user complaints
- **Cannibalization:** Usage of adjacent features, cross-feature conversion rates

**Guardrail rules:**
- Define a **threshold** (not a target) — the line that must NOT be crossed
- Express as **"must not degrade by more than X%"** or **"must remain above/below Y"**
- If a guardrail trips, the experiment must be paused and investigated regardless of primary metric performance

### Tier 4: Diagnostic Metrics

**Explain WHY** the primary and secondary metrics moved. Diagnostics are not decision criteria — they are investigation tools.

Three categories of diagnostic metrics:

**Funnel Metrics:** Step-by-step conversion through the feature flow
- Step 1 → Step 2 conversion rate
- Drop-off points and rates
- Time between steps
- Retry rates at each step

**Technical Performance Metrics:** System behavior that affects UX
- API response times (p50, p95, p99)
- Client-side rendering time
- Cache hit rates
- Error rates by type
- Data freshness / staleness

**Segment Breakdowns:** Performance across user dimensions
- New vs. returning users
- Platform (iOS / Android / Web)
- Geography / market
- User tier (free / premium)
- Device capability (low-end / high-end)
- Traffic source / entry point

---

## Analysis Steps

### Step 1: Analyze Initiative Context

Inside a `<scratchpad>` block, extract:

| Element | What to Extract |
|---------|----------------|
| **Core Problem** | What problem is being solved? What is the current pain? |
| **Business Goal** | What business outcome does this serve? (Revenue, engagement, retention, efficiency) |
| **Success Actions** | What specific user behaviors indicate success? What do we want users to do more/less/differently? |
| **Risks** | What could go wrong? What negative outcomes must we watch for? |
| **Timeframe** | How quickly should we expect to see results? Immediate, weeks, months? |
| **Feature Mechanics** | How does the feature work? What are the key interactions? |
| **User Segments** | Who are the target users? Are there meaningful sub-segments? |
| **Experiment Scope** | Is this an A/B test, phased rollout, or full launch? What is the randomization unit? |

### Step 2: Define Primary Metric(s)

1. List 3-5 candidate primary metrics
2. Evaluate each against STEDII
3. Select the best 1 (or 2-3 if justified)
4. Document the rationale for selection AND rejection of alternatives

For each primary metric, specify:
- **Name**: Clear, unambiguous metric name
- **Definition**: Precise calculation formula (numerator, denominator, time window, user scope)
- **Why Primary**: Why this metric best represents success for this initiative
- **Expected Direction**: Increase / Decrease / Maintain
- **Target** (if available): Specific numeric target or expected effect size
- **STEDII Score**: Brief assessment for each criterion

### Step 3: Define Secondary Metrics

1. Apply HEART and/or AARRR frameworks to the initiative context
2. Select 3-6 secondary metrics that complement the primary
3. For each, specify name, definition, expected direction, and framework mapping

Group secondary metrics into:
- **Business Outcome Metrics**: Directly tied to business goals (revenue, conversion, retention)
- **Engagement & Adoption Metrics**: Feature-level usage and adoption signals

### Step 4: Define Guardrail Metrics

1. Identify potential negative side effects of the initiative
2. Define 2-5 guardrail metrics with explicit thresholds
3. Specify the action to take if a guardrail is tripped

For each guardrail:
- **Name**: Clear metric name
- **Threshold**: The line not to cross (e.g., "must not increase by >5%", "must remain below 200ms")
- **Rationale**: Why this guardrail matters for this initiative
- **Action if Tripped**: What happens (pause experiment, investigate, roll back)

### Step 5: Define Diagnostic Metrics

1. Map the feature's user flow into funnel steps
2. Identify technical performance metrics relevant to the feature
3. Define segment breakdowns that could reveal heterogeneous effects

For each diagnostic metric:
- **Name**: Clear metric name
- **Category**: Funnel / Technical / Segment
- **What It Explains**: Which primary/secondary metric movement it helps diagnose
- **How to Use**: When and how to look at this metric during analysis

### Step 6: Leverage Knowledge Resources

Before finalizing, cross-reference with workspace knowledge:

- Read `{{KNOWLEDGE_BASE_PATH}}/search/metrics/` for standard Search metric definitions (if Search-related)
- Check `{{KNOWLEDGE_BASE_PATH}}/` for the relevant domain's existing metrics and KPIs
- Look for past experiment reports in `docs/` or `{{KNOWLEDGE_BASE_PATH}}/` to reference historical baselines
- Reference `{{KNOWLEDGE_BASE_PATH}}/GLOSSARY.md` for standard terminology

### Step 7: Format Final Output

Compile everything into the output structure below.

---

## Output Structure

```markdown
# Success Metrics: [PRD Title / Initiative Name]

## Initiative Summary

| Element | Detail |
|---------|--------|
| **Initiative** | [Name] |
| **Objective** | [1-sentence objective from PRD] |
| **Business Goal** | [Revenue / Engagement / Retention / Efficiency] |
| **Target Users** | [User segments] |
| **Experiment Type** | [A/B test / Phased rollout / Full launch] |
| **Expected Duration** | [Weeks/months to detect effect] |

---

## Scratchpad Analysis

<scratchpad>
[Full Step 1 analysis — initiative context extraction]
</scratchpad>

---

## Primary Metric(s)

### [Primary Metric Name]

| Attribute | Detail |
|-----------|--------|
| **Definition** | [Precise formula: numerator / denominator, time window, user scope] |
| **Why Primary** | [Why this best represents initiative success] |
| **Expected Direction** | [Increase / Decrease] |
| **Target / MDE** | [Minimum Detectable Effect or target value] |
| **Current Baseline** | [Current value, if known, or "TBD — requires baseline measurement"] |
| **Measurement Window** | [How often measured: daily, weekly, per-session] |

**STEDII Evaluation:**
| Criterion | Assessment | Score (1-5) |
|-----------|-----------|-------------|
| Sensitivity | [Assessment] | [Score] |
| Trustworthiness | [Assessment] | [Score] |
| Efficiency | [Assessment] | [Score] |
| Debuggability | [Assessment] | [Score] |
| Interpretability | [Assessment] | [Score] |
| Inclusivity | [Assessment] | [Score] |

**Rejected Alternatives:**
| Candidate | Reason for Rejection |
|-----------|---------------------|
| [Metric name] | [Why it was not selected as primary] |
| ... | ... |

---

## Secondary Metrics

### Business Outcome Metrics

| Metric | Definition | Framework | Expected Direction | Rationale |
|--------|-----------|-----------|-------------------|-----------|
| [Name] | [Formula] | [HEART/AARRR dimension] | [Up/Down/Stable] | [Why included] |
| ... | ... | ... | ... | ... |

### Engagement & Adoption Metrics

| Metric | Definition | Framework | Expected Direction | Rationale |
|--------|-----------|-----------|-------------------|-----------|
| [Name] | [Formula] | [HEART/AARRR dimension] | [Up/Down/Stable] | [Why included] |
| ... | ... | ... | ... | ... |

---

## Guardrail Metrics

| Metric | Threshold | Rationale | Action if Tripped |
|--------|-----------|-----------|-------------------|
| [Name] | [Must not X by >Y%] | [Why this matters] | [Pause / Investigate / Roll back] |
| ... | ... | ... | ... |

---

## Diagnostic Metrics

### Funnel Metrics

| Step | Metric | Definition | Explains |
|------|--------|-----------|----------|
| 1 | [Entry point metric] | [Definition] | [Which higher-tier metric] |
| 2 | [Next step metric] | [Definition] | [Which higher-tier metric] |
| ... | ... | ... | ... |

### Technical Performance

| Metric | Definition | Acceptable Range | Explains |
|--------|-----------|-----------------|----------|
| [Name] | [Definition] | [Range] | [Which higher-tier metric] |
| ... | ... | ... | ... |

### Segment Breakdowns

| Dimension | Segments | Rationale |
|-----------|----------|-----------|
| [Dimension name] | [Segment values] | [Why this segmentation matters for this initiative] |
| ... | ... | ... |

---

## Analytics Instrumentation Requirements

### New Events Required

| Event Name | Trigger | Properties | Priority |
|-----------|---------|------------|----------|
| [event_name] | [When fired] | [Key properties to capture] | [Must-have / Nice-to-have] |
| ... | ... | ... | ... |

### Existing Events to Leverage

| Event Name | Current Usage | How to Use Here |
|-----------|--------------|----------------|
| [event_name] | [What it currently tracks] | [How to use for this initiative] |
| ... | ... | ... |

### Data Pipeline Requirements

[Any new data joins, transformations, or pipeline work needed to compute the defined metrics]

---

## Experiment Configuration Recommendations

| Parameter | Recommendation | Rationale |
|-----------|---------------|-----------|
| **Randomization Unit** | [User / Session / Device] | [Why this unit] |
| **Sample Size** | [Estimated N per variant] | [Based on MDE and baseline] |
| **Duration** | [Minimum days/weeks] | [To capture weekly cycles, novelty effects] |
| **Variants** | [Control + N treatments] | [What each variant tests] |
| **Ramp Plan** | [% rollout stages] | [Risk mitigation approach] |
| **Exclusions** | [Users/segments to exclude] | [Why excluded] |
| **Novelty Effect Mitigation** | [Approach] | [How to account for it] |

---

## Decision Rubric

Define upfront how results will be interpreted:

| Scenario | Primary Metric | Guardrails | Secondary Metrics | Decision |
|----------|---------------|------------|-------------------|----------|
| Clear Win | Significant positive | All clear | Mostly positive | **Ship** |
| Mixed Signal | Significant positive | All clear | Some negative | **Investigate, likely ship with adjustments** |
| Guardrail Trip | Any | One+ tripped | Any | **Pause, investigate, do not ship** |
| Neutral | Not significant | All clear | Mixed | **Extend experiment or iterate** |
| Clear Loss | Significant negative | Any | Any | **Do not ship, extract learnings** |

---

## Appendix: Metrics from Past Experiments

[Reference any historical experiments or baseline data from the workspace knowledge base that inform the metric choices, baselines, or expected effect sizes. If none found, state "No prior experiments found in workspace for this domain."]
```

---

## Quality Checklist

Before delivering the analysis, verify every item:

- [ ] **Primary metric passes STEDII** — all 6 criteria explicitly evaluated
- [ ] **Primary metric is singular** (or max 2-3 with strong justification)
- [ ] **Rejected alternatives documented** — shows analytical rigor
- [ ] **Secondary metrics use HEART and/or AARRR** — framework explicitly referenced
- [ ] **Guardrails have explicit thresholds** — not just "monitor", but specific limits
- [ ] **Guardrail action plan defined** — what happens when a guardrail trips
- [ ] **Diagnostic metrics map to higher-tier metrics** — clear "explains" linkage
- [ ] **Funnel metrics cover the full user flow** — no gaps between entry and completion
- [ ] **Segment breakdowns are relevant** — not generic, but specific to this initiative's risks
- [ ] **Instrumentation requirements are specific** — event names, properties, triggers defined
- [ ] **Experiment configuration is realistic** — sample size and duration are feasible
- [ ] **Decision rubric is complete** — covers all likely outcome scenarios
- [ ] **No invented baselines or targets** — unknown values marked as TBD
- [ ] **Metrics terminology matches workspace standards** — cross-referenced with `{{KNOWLEDGE_BASE_PATH}}/` definitions
- [ ] **Inclusivity considered** — metrics don't mask harm to minority segments
