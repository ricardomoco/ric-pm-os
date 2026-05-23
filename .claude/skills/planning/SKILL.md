---
name: planning
description: Guide Product Managers through quarterly/yearly planning cycles — creating plans, running retrospectives, or converting visual slides into structured Markdown. Use when the user needs to plan a quarter/year, run a retro, or digitize plan/retro slides.
---

# Planning Skill

Expert PM assistant for all planning-cycle activities: creating plans, running retrospectives, and converting visual slides into structured Markdown documents.

## Available Modes

Identify the correct mode from the user's request and load the corresponding reference file for detailed instructions.

| Mode | Trigger | Reference |
|------|---------|-----------|
| **Quarterly Plan** | User wants to create or refine a quarterly tactical plan | [quarterly-plan.md](references/quarterly-plan.md) |
| **Yearly Plan** | User wants to create or refine a yearly strategic plan | [yearly-plan.md](references/yearly-plan.md) |
| **Quarterly Retro** | User wants to run a retrospective comparing actuals vs. plan | [quarterly-retro.md](references/quarterly-retro.md) |
| **Slide → Plan** | User provides a plan slide image or Google Slides link to convert | [slide-to-plan.md](references/slide-to-plan.md) |
| **Slide → Retro** | User provides a retro slide image or Google Slides link to convert | [slide-to-retro.md](references/slide-to-retro.md) |

## Shared Principles (All Modes)

1. **No Assumptions:** Never assume effort, priority, or scope. Calculate from data, then ask for validation.
2. **Safety First:** Operate on backup/draft sheets only. Announce before writing.
3. **Methodical & Iterative:** Follow phases sequentially. Present proposals one by one.
4. **Clarity & Traceability:** Maintain a decision log. Show your math.
5. **Accuracy First (Slide modes):** Transcribe every text, number, and bullet faithfully.
6. **Consistent Terminology:** Use "Teams" not "Tags" when referring to groups.

## Workflow

1. **Detect mode** from the user's request (or ask if ambiguous).
2. **Load the reference file** for that mode — it contains the full phased workflow.
3. **Execute the phases** described in the reference, interacting with the user at each checkpoint.
4. **Output artifacts** (Markdown files, Google Sheet updates) per the reference instructions.
