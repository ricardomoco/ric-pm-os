---
name: product-visionary
description: Create a structured product vision document. Use when writing a vision, synthesizing strategy inputs, or aligning teams around a future state.
---

# Product Visionary

Expert guidance for turning raw context and fragmented notes into a rigorous, emotionally compelling product vision document that aligns teams and moves fast through planning cycles.

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the topic and any Confluence/Jira references the user provided. Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as the checklist of what to ask the user or flag in the output. Skip only if the user has already supplied a kb-grounder synthesis, or the task is pure formatting on an existing draft.

## What This Skill Produces

A complete vision document structured as:
1. A metadata header (contributors, stakeholders, status)
2. An **Objective** — why this vision doc exists
3. An **Executive Summary** — the 3-line pitch with key numbers
4. A **Problem Statement** — sharp, data-grounded, user-felt pain
5. A **Problem Space** — market context, macro trends, competitive pressure
6. A **Vision Statement** — the vivid, specific, 3–5 year destination
7. **Guiding Principles** — the non-negotiables that shape the solution
8. **Key Features and Capabilities** — what the future state enables
9. **The User Journey** — the core moments of the transformed experience
10. A **Strategy Outline** — phased roadmap with objectives, KPIs, and milestones
11. **FAQs** — anticipated challenges and answers
12. **Appendices** — links to research, mockups, data packs

## Workflow

1. **Parse Inputs**: Accept raw notes, research docs, data, transcripts, PRDs, or URLs as context. If no inputs are provided, use `AskUserQuestion` to request them. If inputs are thin, flag which sections will need to be marked `[TBD — research needed]`.
2. **Apply the Empathize → Create → Evangelize Framework**: Follow the methodology in [vision-methodology.md](references/vision-methodology.md) to synthesize inputs before writing.
3. **Quality Gate**: Before drafting, validate: Is there a sharp, specific problem? Can a 3–5 year destination be articulated? If not, surface the gaps and ask for clarification.
4. **Draft the Vision**: Populate all sections using the [vision-document-template.md](assets/vision-document-template.md). Fill from inputs; mark genuinely unknown fields as `[TBD]`, not placeholder text.
5. **Apply Narrative Techniques**: The vision statement and executive summary must use vivid, specific, emotionally resonant language — not corporate-speak. Follow the narrative guidance in [vision-methodology.md](references/vision-methodology.md).
6. **Output the Document**: Deliver the full document in markdown, ready to be pasted into Confluence or a Google Doc.

## Publishing to Confluence

When the user asks to publish or create a live document, read [shared/atlassian-config.md](../shared/atlassian-config.md) to determine the correct parent page. Vision docs go under Product Vision & Strategy (4401856905) or the relevant Strategic Pillar page.

## Reference Materials
- [Vision Methodology](references/vision-methodology.md): Ebi Atawodi's framework — four attributes of great visions, the three-stage process, narrative techniques, and common pitfalls.
- [Vision Document Template](assets/vision-document-template.md): The complete section-by-section template based on the One-Flow Upload Vision document ({{COMPANY}} internal benchmark).
