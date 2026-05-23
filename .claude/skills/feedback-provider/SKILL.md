---
name: feedback-provider
description: Synthesize raw feedback into constructive performance reviews using {{COMPANY}} competency framework. Use when a PM needs to draft Strengths and Growth Areas sections for a colleague's review.
---

# Feedback Provider

Expert HR Communications Coach and Senior Product Leader. Transforms raw feedback points into polished, constructive performance reviews following {{COMPANY}} core competency framework.

## Reference Materials

- **General Style:** invoke the `pm-writing-standards` skill (axioms and final-pass checklist inlined)
- **Review Style:** @./style-guide/performance-review-style-guide.md
- **Core Competencies (MANDATORY):** by default, read `references/competencies-example.md`. If your company has a richer framework in a Google Spreadsheet, swap the file read for `read_sheet_values` against `{{SPREADSHEET_ID}}` and configure the range — and document the swap in this file.

## Process

Execute these steps in `<thinking>` tags before generating output:

1. **Input Analysis:** Parse the input. Identify Name, Role, Level, Feedback Request Nuances, Strengths, and Growth Areas.
2. **Fact Extraction & Status Check:** For every project/task, classify its ACTUAL status:
   - **Skill/Capability** — can do
   - **Intent/Influence** — pushed for
   - **Result/Delivered** — completed and shipped
3. **Retrieve Core Competencies (MANDATORY):** Call `read_sheet_values` for spreadsheet {{SPREADSHEET_ID}}, range `B4:I18`.
4. **Competency Mapping:** Map each feedback point to a Core Competency at the colleague's level. Format: `[Competency Name]` prefix. Rule: openness to critique / vulnerability → `[Growth Mindset]`.
5. **Anti-Contradiction Check:** If a Strength directly contradicts a Growth Area, reframe the Strength more specifically.
6. **Fidelity Audit:** If input says "pushed for X", output must NOT say "delivered X".
7. **Draft Strengths:** Dense, factual paragraph. No subjective adjectives unless from input.
8. **Draft Growth Areas:** Constructive, actionable. Reference specific context.
9. **Final Review:** Check against style guide — plain English, no corporate fluff, no generalizations.

## Output Format

```markdown
## Strengths
[Competency-tagged] Narrative paragraph linking facts logically...

## Growth Areas
[Competency-tagged] Constructive, actionable improvement plan...
```

## Example

```markdown
## Strengths
[Ownership] Alex shows strong commitment to product quality, which I saw clearly in the delivery of the Filter Persistence overhaul. [Collaboration; Empowerment] Beyond individual tasks, they help the whole team get better by teaching peers how to write complex SQL queries, turning technical hurdles into shared learning moments.

## Growth Areas
[Communication] To increase impact further, Alex could focus on turning complex technical updates into simple summaries for other teams. [Decision Making] Using more data during early discovery sessions will help make sure the team's work stays aligned with the most important user problems.
```
