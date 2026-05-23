---
name: research
description: Synthesize UX research data into structured deliverables — full Key Learnings reports, leadership summaries, or transcript quality audits. Use when the user has research transcripts, notes, or reports to process.
---

# Research Skill

Expert UX Researcher and Product Manager assistant for transforming raw qualitative and quantitative research data into structured, actionable deliverables.

## Available Modes

Identify the correct mode from the user's request and load the corresponding reference file for detailed instructions.

| Mode | Trigger | Reference |
|------|---------|-----------|
| **Key Learnings** | Synthesize transcripts/notes into a full Key Learnings report (4-10 insights) | [key-learnings.md](references/key-learnings.md) |
| **Summary** | Distill a Key Learnings report into a standardized leadership summary | [summary.md](references/summary.md) |
| **Transcript QA** | Audit transcripts for quality issues (gibberish, hallucinated names, repetitions) | [transcript-analysis.md](references/transcript-analysis.md) |

## Shared Principles (All Modes)

1. **Evidence-Based:** Every finding must trace to a specific quote or observation from the source data.
2. **Full Coverage:** Process ALL provided transcripts/files. Never sample unless explicitly told to.
3. **Context Grounding:** Read `@{{KNOWLEDGE_BASE_PATH}}/company-context.md` to identify strategic tensions.
4. **Style Guide Adherence:** Invoke the `pm-writing-standards` skill for all written output.
5. **Quant-First Logic:** Never jump to A/B testing. Propose quantitative validation, behavioral analysis, or concept testing first.
6. **Markdown Only:** Strict Markdown formatting. No HTML tags.

## Workflow

1. **Receive inputs** — transcripts, research plans, or Key Learnings reports.
2. **Detect mode** from the user's request (or ask if ambiguous).
3. **Load the reference file** for that mode — it contains the full phased workflow and output template.
4. **Execute the phases** described in the reference, ingesting all data before synthesizing.
5. **Deliver structured output** matching the reference's format.
