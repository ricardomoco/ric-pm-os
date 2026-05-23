---
name: prd-writer
description: Write engineering-ready PRDs for {{COMPANY}} features. Use when drafting a PRD, defining metrics, identifying assumptions, mapping user flows, planning GTM, or editing an existing PRD.
---

# PRD Writer

This skill routes to the right phase of PRD creation. Do NOT load all phases at once.

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the topic and any Confluence/Jira references the user provided. Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as the checklist of what to ask the user or flag in the output. Skip only if the user has already supplied a kb-grounder synthesis, or the task is pure formatting on an existing draft.

## Operating principle

**PRDs are about decisions, not documentation.** Every section in the PRD output should resolve a decision — what we're building, what we're not building, how we measure success, what gates the rollout, what kills it. If a section reads as descriptive prose without a decision, rewrite it.

## How Claude (you) should work with the PM

Don't auto-generate decision-free prose. The PM has the context to make the call; your job is to surface the decisions, push for specificity, and finesse the prose. When the PM hasn't decided, **ask** — don't invent.

When you encounter:
- A vague target ("improve engagement") → ask for a baseline + magnitude + window
- A hand-waved rollout ("start small") → ask for exposure %, duration, gate criteria
- A risk without a detection trigger → ask how the team will know the risk has materialised
- A claim without a citation → ask for the source, or flag as a gap

## Phases

| # | Phase | File | When to load |
|---|---|---|---|
| 1 | Problem Framing | [phases/1-problem-framing.md](phases/1-problem-framing.md) | Starting a new PRD |
| 2 | Solution Definition | [phases/2-solution-definition.md](phases/2-solution-definition.md) | After problem is validated |
| 3 | Metrics Framework | [phases/3-metrics-framework.md](phases/3-metrics-framework.md) | "Define metrics", "success metrics", "experiment criteria" |
| 4 | Assumptions & Risks | [phases/4-assumptions-risks.md](phases/4-assumptions-risks.md) | "Identify assumptions", "de-risk", "what could go wrong" |
| 5 | Requirements & AC | [phases/5-requirements-ac.md](phases/5-requirements-ac.md) | "Write requirements", "acceptance criteria" |
| 5b | AI Behavior Contract | [phases/5b-ai-behavior-contract.md](phases/5b-ai-behavior-contract.md) | Feature uses ML / generative / recommendations / scoring |
| 6 | Flows & Edge Cases | [phases/6-flows-edge-cases.md](phases/6-flows-edge-cases.md) | "Map user flows", "edge cases", "story map" |
| 7 | GTM & Launch | [phases/7-gtm-launch.md](phases/7-gtm-launch.md) | "Launch plan", "GTM", "rollout strategy" |
| - | Edit Existing PRD | [phases/edit-existing.md](phases/edit-existing.md) | "Update section X", "fix the problem statement", editing a draft |

## Routing Logic

1. **New PRD from scratch**: Start at Phase 1. Complete one phase, present output, wait for user validation, then load the next phase. Do not skip ahead.
2. **Specific phase requested**: Jump directly to that phase. Load only that phase file.
3. **AI / ML / generative / scoring feature**: Phase 5b runs **in addition to** Phase 5 (not instead of). Auto-trigger when the feature description includes ML models, recommendations, generative output, or probabilistic scoring. The PM can override either way.
4. **Editing an existing PRD**: Load `edit-existing.md` for behavioral guardrails, then apply changes surgically.
5. **Continuing a draft**: Determine which phases are complete based on what exists, load the next incomplete phase.

Each phase outputs its section following the schema in [references/template.md](references/template.md). The final PRD assembles all phase outputs into one document.

## Size triage — do this FIRST for every new PRD

Before choosing a workflow, classify the initiative on two axes. **Auto-detect from context first, only ask the PM if the signals are genuinely mixed.**

### Axis 1: Size

| Size | Detection signals |
|---|---|
| **Small** (single-sprint scope) | Single owner; one engineer or one platform; minimal cross-tribe deps; reversible (feature-flag); bug fix / copy change / single-component tweak / colour swap / single-locale tweak; language cues: "quick win," "low-hanging fruit," "let me just spin this up," "small experiment," "1-week test" |
| **Substantial** (multi-sprint, cross-tribe) | Multiple platforms shipping simultaneously; cross-tribe dependencies named (Artisans, Bumpers, T&S, MMP, {{SELLER_TEAM}}, Search, {{DISTRIBUTION_TEAM}}); Legal review required; new service / endpoint / data pipeline; ML / scoring / generative system; regulated content (DSA, KYC, payments, identity); replaces existing functionality |

### Axis 2: Validation method

| Method | Detection signals |
|---|---|
| **A/B test** | Words like "experiment," "variant," "split test," "dial-up," "ramp"; has a control to compare against; reversible feature-flag; learning-oriented |
| **One-shot launch** | Migration, infrastructure, regulated launch already announced, tech debt, DB migration, "must ship 100% on day one," no rollback option |

### Routing matrix

| | A/B test | One-shot launch |
|---|---|---|
| **Small** | **Speclet (3-paragraph minimum) + Jira Experiment ticket** via `/experiment-creator`. Skip Phases 2–7. Stage 5 only if iterating after results. | **Speclet (3-paragraph minimum) + Jira Story.** Skip Phases 2–7 entirely. |
| **Substantial** | Full lifecycle, experiment branch, Stages 1-5, all phases | Full lifecycle, non-experiment branch, Stages 1-5, all phases |

### Speclet shape for SMALL initiatives

3 paragraphs minimum, 1 page maximum:

1. **Problem (one sentence) + working hypothesis (one sentence)** — what's wrong, what we believe will fix it.
2. **What changes (1-2 sentences)** — be specific about the surface and the variant. "Show seller name + rating in 2-line Item Card on Search SERP for ES iOS users."
3. **How we'll know (primary metric + duration)** — for A/B: the metric and the test window. For one-shot: pass criteria for go-live.

**Skip entirely for small initiatives:** 3 user quotes, MDE power analysis, Phase 2 tech dependencies with SLAs, full Phase 4 risk matrix, Phase 7 ramp gates by exposure %, Pre-Launch Checklist by track.

**Still required, but they live in the Jira ticket — NOT in the Speclet:**

- **Requirements & Acceptance Criteria (Gherkin Given/When/Then).** Every functional change needs testable AC. For small initiatives these go in:
  - **A/B test:** Jira Experiment ticket — populated via `/experiment-creator` (Setup field carries the variant description + AC)
  - **One-shot launch:** Jira Story description — populated via `/jira-ticket-writer` (Story body carries the AC table)
- **Tracking events** (if the metric requires new instrumentation).
- **Edge case handling** (1-3 lines, inline in the AC, not a separate Phase 6 deliverable).
- **AI behavior contract** if the small initiative still uses ML / scoring / generative — Phase 5b is non-negotiable regardless of size.

The Speclet sets *what's being tried and why*. The Jira ticket sets *what gets built and how it's verified*. Neither is sufficient alone — but for small initiatives there's no separate PRD between them.

**Skip even the speclet** if scope is fully obvious from a Jira ticket alone (e.g. "fix the avatar tap bug" — no PRD or speclet needed; just write the bug ticket with proper Gherkin AC).

### What "non-negotiables" apply to small initiatives

The §What every PRD must commit to list applies to **Substantial** PRDs only. For Small initiatives, the only non-negotiables are:

- Problem + hypothesis (one sentence each)
- Primary metric (for A/B) OR pass criteria (for one-shot)
- Owner

Everything else (MDE, graduation criteria, risk matrix, ramp gates, kill switch, pre-launch checklist by track) is **explicitly waived** for small initiatives. Don't enforce them — they create false rigour around work that doesn't need it.

### Detection output

When the skill is asked to start work on a new initiative, surface the classification before running any phase:

```markdown
**Detected:** Small + A/B test → Speclet + Experiment ticket path
**Reasoning:**
- "1-week test" language → small
- "variant" / "control" → A/B test
- No cross-tribe deps named → small confirmed

**Override?** Reply if I read the scope wrong (e.g. "treat as substantial," "this is a one-shot launch").
```

If signals are genuinely mixed (e.g. small in scope but touches regulated content like KYC), ask one specific question rather than running the full triage:

> "I see this touches [regulated content / cross-tribe dep / external service]. Single-sprint scope or multi-sprint? That determines whether we use the lightweight or full path."

### Promotion rule

If a small initiative shows signal worth scaling (e.g. the badge-colour A/B test wins → ship the colour permanently across all surfaces), **promote to a full PRD starting at Stage 2 (Kickoff)**. At that point you need MDE, graduation criteria, full rollout discipline. The Speclet becomes Stage 1 of the full PRD; you extend, don't rewrite.

The promotion direction is one-way: Speclet-only → full lifecycle. Going the other direction (downsizing a Substantial PRD to a Speclet) means the initial classification was wrong — fix the triage, don't shrink the PRD.

## Lifecycle Stages

PRDs are evolving documents. They start at quarterly planning as a brief and evolve through discovery, specs, design exploration, launch, and post-launch review. The skill recognises **5 lifecycle stages** that map onto the existing authoring phases:

| Stage | Authoring phases populated | Trigger | Gate to next |
|---|---|---|---|
| **1: Speclet** | Phase 1 (Problem Framing) + light Phase 2 (Solution Vision) | Quarterly planning brief | CPO / PL alignment "yes, build this" |

**Stage 1 Speclet shape — what's actually expected at quarterly planning:**

- **Length:** 1-2 pages max. If it's longer than 2 pages, you've drifted into Stage 2 work prematurely.
- **What's in:** Executive Summary, Core Problem, Working Hypothesis, Strategy Fit (parent doc cited), Motivating Data with quantitative + 3 quotes, light Solution Vision (1-2 paragraphs on the proposed approach). That's it.
- **What's out:** Detailed metrics framework with MDE (that's Stage 2), Requirements & AC (Stage 3), Rollout / Kill Switch (Stage 4). Don't pre-spec these — the speclet is for alignment, not engineering handoff.
- **Naming:** "Speclet" or "Initiative Brief" — same artefact, different name. {{COMPANY}} existing Initiative Brief format counts as a Stage 1 PRD; promote it in place rather than duplicating.
| **2: Kickoff** | + Phase 3 (Metrics with MDE + Graduation) + impact sizing | EM commits resources; data confirms detectability | Refinement meeting agrees the spec is buildable |
| **2: Kickoff** | + Phase 3 (Metrics with MDE + Graduation) + impact sizing | EM commits resources; data confirms detectability | Refinement meeting agrees the spec is buildable |
| **3: Solution Review** | + Phase 5 (Requirements & AC) + Phase 6 (Flows & Edge Cases) + Phase 5b if AI feature | Refinement complete; engineering can build | Final tech review + cross-tribe dep sign-off |
| **4: Launch Readiness** | + Phase 7 (Rollout with Ramp Gates + Kill Switch + Pre-Launch Checklist) | All track owners (Eng / Design / Data / Legal / Ops) signed off | Dial-up |
| **5: Impact Review** | New section: results, what surprised us, annex new examples (if AI), iterate/scale/retire decision | Experiment analysis complete | — |

**Stage rules for Claude:**

1. When the PM names a stage, only run the authoring phases that populate it. Don't write Phase 7 content on a Stage 1 speclet.
2. When promoting between stages, validate the prior stage's content is complete. Flag gaps before the gate.
3. The Stage field at the top of the template is the source of truth. Update it on every meaningful revision.
4. Stage 5 connects to the `/post-experiment-report` skill — it doesn't replace it. The PRD's Stage 5 section summarises and links to the post-experiment Confluence report.
5. Reviewers read with stage in mind: don't surface Phase 4 risk-matrix nitpicks on a Stage 1 speclet, and don't approve a Stage 4 PRD without the rollout gates filled in.

## Auto-detecting the stage

If the user provides an existing PRD without naming a stage (or the Stage field is empty / contradicts the content), **infer the stage before doing any work.** Don't silently assume — surface the inference, ask the PM to confirm or override.

**Detection heuristic.** Stages are detected by *populated content with real values*, not by section presence. A PRD with all section headers but placeholders like `[%]`, `[expected impact]`, `[verbatim quote]`, or empty tables is at most a Stage 1 speclet — even if Phase 7 headers exist.

| Stage | Required populated content (real values, not placeholders) |
|---|---|
| **Stage 1: Speclet** | Executive Summary (2-3 sentences); Core Problem; Working Hypothesis ("We believe X will Y because Z"); Strategy Fit citing parent doc; Motivating Data with quantitative metrics + 3 attributed user quotes |
| **Stage 2: Kickoff** | All Stage 1 content + In/Out Scope (explicit non-goals); Primary metric with **MDE filled in** (not `[Min detectable]`); Graduation Criteria as concrete checklist; impact sizing |
| **Stage 3: Solution Review** | All Stage 2 content + Requirements table with Gherkin AC for ≥3 P0 items; populated Edge Cases table; **(if AI feature)** Behavior Spec with ≥15 labelled examples + red team scenarios |
| **Stage 4: Launch Readiness** | All Stage 3 content + Phased Rollout with concrete numeric Ramp Gate criteria per phase; Kill Switch with location / access / timing / triggers all filled; Pre-Launch Checklist with named track owners |
| **Stage 5: Impact Review** | All Stage 4 content + Results section with actual measured numbers; "What surprised us"; iterate / scale / retire decision recorded |

**What counts as "real content":**
- `"+1-2% CVR"` ✅ — `[expected impact]` ❌
- A risk row with detection threshold (`"P95 latency >300ms"`) ✅ — `"monitor and adjust"` ❌
- `"Maria, 32, Madrid, 47 orders/year — 'I spend half my day...'"` ✅ — `"[verbatim quote]"` ❌
- `"5% of ES iOS users for 7 days, gate to 25% if P50 ≤45s"` ✅ — `"start small and ramp"` ❌

**Detection algorithm:**

1. Walk through Stages 1 → 5.
2. For each stage, mark each required section as **Complete** (real content) / **Partial** (some content but missing required elements like MDE) / **Empty** (placeholders or absent).
3. The PRD's stage = the highest stage where all required sections are Complete.
4. If earlier stages have Partial sections (e.g. PRD has Phase 7 content but only 2 quotes in Phase 1), the stage is still the highest fully-Complete stage — but flag the earlier gaps as "must fix to be a clean PRD at this stage."

**Required output format on detection:**

```markdown
**Detected stage: Stage [N]: [Name]**

Populated for this stage:
- [Section] ✅
- [Section] ✅
- ...

Missing for next stage promotion:
- [Section/element that would advance to Stage N+1] ❌
- ...

Earlier-stage gaps to flag (PRD is at Stage [N] but has incomplete content from earlier stages):
- [E.g. Only 2 user quotes — Stage 1 requires 3] ⚠️
- ...

Confirm Stage [N] or override (e.g. "treat as Stage 2"). I'll hold work until you confirm.
```

**Edge cases:**
- **No populated content at all:** Treat as "no stage yet" — recommend starting at Phase 1 fresh.
- **Stage 1 fully populated + Stage 2 partial + Stage 3 partial + Stage 4 empty:** Stage = Stage 1, with Stage 2 gaps flagged.
- **Stage field says X but content suggests Y:** Surface the conflict; ask which to trust.
- **Post-launch sections present (Stage 5 content) but Phase 7 sections look templated:** Probably a PRD that shipped without proper Stage 4 rigor — flag this as a quality warning, not just a stage mismatch.

Auto-detection runs at the start of every editing or roasting interaction with an existing PRD. If the user explicitly names a stage, skip detection and trust the user.

The stage labels are how the team communicates progress to [Director]. They're also how this PRD model absorbs the existing Initiative Brief artefact — Stage 1 IS the brief.

## What every PRD must commit to

These are the non-negotiables that the template enforces:

- **Executive Summary** (2-3 sentences with expected impact)
- **Working Hypothesis** (one sentence — "We believe X will Y because Z")
- **Strategy Fit** (parent strategy / vision doc cited)
- **Motivating Data** (quantitative + 3 user quotes minimum)
- **Primary metric with MDE** (Minimum Detectable Effect — without it the experiment is undetectable)
- **Graduation Criteria** (when do we scale to 100%)
- **Risk Matrix with Detection** (Risk / Likelihood / Impact / Detection / Mitigation)
- **Phased Rollout with Ramp Gates** (specific exposure %, duration, gate criteria per phase)
- **Kill Switch** (location / access / activation time / rollback time / trigger conditions)
- **Pre-Launch Checklist** (organised by track: Eng / Design / Data / Legal / Ops)
- **For AI features:** Behavior Contract via Phase 5b (15-25 labelled examples + red team + offline eval + human review rubric)

If any of these are missing when you assemble the final PRD, flag the gap to the PM before publishing.

## Lean main body, appendix for discursive content

A PRD is consumed by stakeholders with limited context (engineering managers, designers, legal reviewers, leadership). The main body must give them what they need to make their decision; everything else goes to an appendix.

**Stays in the main body** (the standard template sections):
- Executive Summary, Objective, Working Hypothesis, Strategy Fit, Motivating Data.
- Metrics (Launch / Supporting / Guardrail / Graduation).
- Risks (User / Platform / Legal / Business) — one row per risk with mitigation, no multi-paragraph narratives.
- Requirements (with acceptance criteria).
- Stakeholder table (where person names live).
- Phased Rollout, Kill Switch, Pre-Launch Checklist, Milestones, Open Questions, Edge Cases, Out of Scope.

**Moves to the Appendix** (or a separate linked doc):
- **Decision Log entries** — a chronological narrative of how the spec evolved (date-stamped agreements, supersessions, scope shifts). Stays in the appendix; the main body reflects the *current* state without re-narrating how it got there.
- **Detailed risk analyses** — when a single risk needs a multi-paragraph explanation (legal precedent, audit gap inventory, vendor-specific concerns), put the row in the main Risks table with a one-sentence mitigation and link to an appendix section for the detail.
- **Stakeholder position papers** — T&S guidance, Legal context, vendor documentation, audit findings — these are reference material, not active spec. Appendix.
- **Historical experiments / prior work narratives** — beyond a one-line "Prior work: X+1.2% in 2023, rolled back due to Y, see appendix" reference.
- **Process notes** — Slack threads, meeting notes, who-said-what audit trails. Appendix or link out.

**Rule of thumb:** the main body should be readable by a stakeholder with 10 minutes and zero session context. If the reader needs the backstory to parse a section, that backstory belongs in the appendix.

**Don't repeat appendix content in the main body.** A risk row that says "DSA-KYB has audit gaps" is enough in the main Risks table; the Slack 2026-05-05 findings (Gemini-only validation, no registry API, etc.) belong in an Appendix subsection that the row links to. Reproducing the appendix content in the row defeats the point.

## No re-explanation of gates and dependencies

When a launch gate, dependency, or pre-condition (Legal sign-off, T&S commitment, backend spike, dependency on another team) appears in multiple sections (Status, Objective, Requirements, Risks, Milestones, Open Questions, Stakeholder table), pick **one canonical location** for the FULL explanation. Everywhere else, name the gate and link / reference.

- **Status line:** one-clause summary. "Gated on Trust & Safety roadmap commitment and Legal UXW approval."
- **Requirements section:** the full AC and acceptance criteria for the gate. This is the canonical location for most gates.
- **Risks section:** name the risk and mitigation in one row.
- **Milestones:** one line per gate-event with date / status.
- **Open Questions:** one line if unresolved.
- **Stakeholder table:** one row per person/team with role.

**Telltale of over-explanation:** the same gate appears 5+ times in the doc, each time with the same expanded prose. The reader doesn't need to re-learn the gate each time it's mentioned. Use labels and links: "see Phase 0a in Phased Plan" or "see Risks L5".

## Adjacent skills

The PRD writer pairs with:

- **`/assumption-identifier`** — full Teresa Torres assumption analysis (15-25 assumptions, journey-mapped, with validation tests). Use when stress-testing a draft.
- **`/prd-roaster`** — adversarial pre-publish critique. Run before sending the PRD up the chain.
- **`/success-metrics`** — deeper metrics framework when Phase 3 needs more rigor.
- **`/prd-accessibility-requirements`** — generate a11y AC for any user-facing feature.

## Publishing to Confluence

When the user asks to publish or create a live document, read [shared/atlassian-config.md](../shared/atlassian-config.md) to determine the correct parent page. PRDs go under their Strategic Pillar → Initiative folder. Create the initiative folder first if it doesn't exist.

## Voice & writing standards

All PRD output follows the [Voice & Epistemic Honesty Guide](../shared/voice-guide.md). No black-box superlatives, no manufactured drama, no hedge-stacking. Earned confidence — assertion strength matches evidence strength.
