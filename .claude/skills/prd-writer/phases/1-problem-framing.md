# Phase 1: Problem Framing

Define the problem, the working hypothesis, and the evidence that justifies this initiative.

## Inputs Needed
- User's feature idea, research, or brief
- Any existing research transcripts, data, or Confluence pages
- The parent strategy / vision document this PRD ladders into

## Process

### 1. Gather Context

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the topic and any Confluence/Jira references the user provided. Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

The synthesis must surface: the parent strategy / vision doc the PRD ladders into, the current quarterly goal it serves, prior research and quant signals, and any open gaps. The PRD must cite the parent strategy doc explicitly — if kb-grounder doesn't return one, ask the user before continuing.

### 2. Write the Executive Summary
**2-3 sentences max.** What are we building, why does it matter, what's the expected impact. This is the BLUF — if a stakeholder reads only this, they should know the bet.

Bad — vague:
> "We're improving the seller component to help buyers."

Good — specific and committal:
> "We're surfacing identity verification (KYC for private sellers, DSA KYB for business sellers) on the IDP seller component. Research confirms identity verification ranks higher than Top Profile as a buyer trust signal. Expected impact: +1-2% CVR Item View → PI."

### 3. Define the Problem
- **Problem Statement (one sentence)**: What specific pain point or opportunity exists? Be concrete — name the user segment, the behavior, and the friction.
- **Working Hypothesis (one sentence)**: What's the bet? Phrase as "We believe [user] will [behavior] because [reason], leading to [outcome]."
- **Evidence**: What research, data, or signals support this? Cite specific sources. If none exist, flag this as a gap — do not invent.
- **User Segments**: Who experiences this problem? Primary and secondary segments.
- **Current State**: How do users solve this today? What workarounds exist?

### 4. Motivating Data — Quantitative + 3 Quotes Minimum

The PRD must include both quantitative and qualitative evidence:

**Quantitative (3 metrics minimum):**
- Current state metric (with source)
- Gap to target or benchmark
- Market or competitive benchmark

**Qualitative (3 verbatim quotes minimum — for user-facing features):**
1. "[Verbatim quote]" — [Segment, source, date]
2. "[Verbatim quote]" — [Segment, source, date]
3. "[Verbatim quote]" — [Segment, source, date]

**Rules for quotes:**
- Verbatim from real interviews, surveys, or support tickets — never paraphrased and never invented.
- Each quote must name the segment (e.g. "Power user, 50+ orders/year") and the source (interview ID, survey, support ticket).
- If the workspace has no qualitative data on the problem yet, flag it as a gap — recommend running `ur-survey-creator` or scheduling interviews.

**For non-user-facing features** (backend platform work, infrastructure, tech debt, observability, internal tooling), substitute user quotes with:

- **Engineer / operator pain citations** — "On-call paged 14 times last week for X" / "EM survey: 60% of engineers cite Y as top friction" / "Specific incident reports referencing the gap"
- **System signals** — "P95 latency spiked 40% Q1 → Q2" / "12 production incidents traced to Y over the last quarter"
- **Stakeholder pain** — quotes from internal customers (other PMs, EMs, support, T&S) using the system

Same rule: 3 minimum, attributed to source. The principle is "qualitative evidence beyond the author's intuition," not specifically end-user voice.

### 5. Scope the Opportunity
- **Impact**: How many users are affected? What's the business impact?
- **Prior Art**: Has this been attempted before (internally or by competitors)? What happened? If a {{COMPANY}} experiment was previously rolled back (e.g. 2023 KYC), name the rollback reason and what changed since.
- **Strategic Alignment**: How does this connect to quarterly goals and team strategy? Cite the parent strategy doc.

## Output
Populate these sections of the PRD template ([references/template.md](../references/template.md)):
- **Executive Summary** (2-3 sentences)
- **Core Problem** (one sentence)
- **Working Hypothesis** (one sentence)
- **Strategy Fit** (parent strategy reference)
- **Motivating Data** (quantitative + 3 quotes)
- **Identified Pain Points** (table)

## Quality Gate
Before proceeding to Phase 2, validate:
- [ ] Executive Summary is 2-3 sentences and includes expected impact
- [ ] Problem is specific and evidence-backed (not "users want X")
- [ ] Working Hypothesis follows the "We believe X will Y because Z" form
- [ ] At least 3 verbatim user quotes with source attribution
- [ ] User segments are named and characterized
- [ ] No data, quotes, or sources were invented
- [ ] Strategic alignment is explicit and links to a parent strategy doc

Present output to user for validation before proceeding.
