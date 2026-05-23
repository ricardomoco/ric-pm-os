---
name: prd-analysis
description: Analyze an existing PRD to identify hidden assumptions, generate user flows and edge cases, define success metrics, or create a Go-To-Market plan. Use when the user has a PRD and wants to stress-test, extend, or operationalize it.
---

# PRD Analysis Skill

Expert toolkit for analyzing and extending Product Requirements Documents. Provides four complementary analysis modes that can be run independently or in sequence.

## Available Modes

Identify the correct mode from the user's request and load the corresponding reference file for detailed instructions.

| Mode | Trigger | Reference |
|------|---------|-----------|
| **Assumptions** | Identify hidden assumptions using Teresa Torres' Continuous Discovery framework | [assumptions.md](references/assumptions.md) |
| **Flows & Edge Cases** | Generate comprehensive user flows, edge cases catalog, and story map | [flows-edge-cases.md](references/flows-edge-cases.md) |
| **Success Metrics** | Define primary, secondary, guardrail, and diagnostic metrics (STEDII framework) | [success-metrics.md](references/success-metrics.md) |
| **GTM Plan** | Create a Go-To-Market launch strategy from the PRD | [gtm.md](references/gtm.md) |

## Shared Principles (All Modes)

1. **PRD First:** Always read and fully analyze the PRD before producing output.
2. **Scratchpad Thinking:** Use a `<scratchpad>` to systematically extract PRD elements before generating the analysis.
3. **Zero Invention:** Never fabricate data, quotes, or metrics. Flag missing context explicitly.
4. **Requirements ≠ Solutions:** Distinguish capabilities (what the system must do) from implementation (how to build it).
5. **Actionable Output:** Every recommendation must be specific, testable, and tied back to a PRD section.

## Workflow

1. **Receive PRD** — the user provides a PRD (file path, pasted content, or Confluence link).
2. **Detect mode** from the user's request (or ask if ambiguous).
3. **Load the reference file** for that mode — it contains the full analysis framework and output template.
4. **Execute the analysis** using the scratchpad approach described in the reference.
5. **Deliver structured output** matching the reference's output format.
