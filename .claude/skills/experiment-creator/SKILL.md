---
name: experiment-creator
description: Create a structured Jira Experiment issue with hypothesis, metrics, and test design, or fulfil/update an existing one (Setup, Results, Decision). Use when creating an experiment ticket from any context — PRD, Confluence page, notes, verbal description, inline conversation — or when populating results and decision on a running / closed experiment.
---

# Experiment Creator

Routes to the right mode based on the input. **Do NOT load all sub-instructions at once.**

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the topic and any Confluence/Jira references the user provided (parent PRD, initiative epic, prior experiments). Use the returned synthesis as your grounding. Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as the checklist of what to ask the user or flag in the output. Skip only if the user has already supplied a kb-grounder synthesis, or the task is pure ticket-field fulfilment with all values explicitly provided.

## Step 1: Detect Mode

| Signal | Mode | Load |
|---|---|---|
| User provides an existing Experiment ticket key (e.g. {{JIRA_PROJECT_KEY}}-NNN), or asks to *fulfil / populate / update / add results to* an existing ticket | **Fulfil Existing** | [modes/fulfill-existing.md](modes/fulfill-existing.md) |
| User asks to *create / draft / open* a new experiment ticket from a PRD, notes, or conversation | **Create New** | [modes/create-new.md](modes/create-new.md) |

If ambiguous, ask the user. Never load both mode files.

## Step 2: Resolve Metadata

Both modes share metadata resolution:

1. Scan the input for Tribe, Team, Market, Platform, Funnel Phase.
2. Consult [jira-config/jira-team-catalog.md](../../../jira-config/jira-team-catalog.md) to map names to IDs.
3. Fall back to [jira-config/user-defaults.md](../../../jira-config/user-defaults.md) if the input is silent.
4. **Hardcoded defaults:** assignee {{PM_NAME}}, Track Delivery, Method A/B test.

## Step 3: Execute

Read the selected mode file and follow its instructions.

## Shared Reference Materials

- [Detailed Instructions](references/detailed-instructions.md) — field extraction logic, option IDs, required-field checklist, ADF rules.
- [ADF Helpers](references/adf-helpers.md) — Python helper pattern for building ADF payloads for textarea custom fields.
- [Experiment Additional Info Template](assets/experiment-additional-info-template.md) — template for `customfield_{{CUSTOM_FIELD_ID}}` (Setup).
- [Results & Decision Template](assets/results-decision-template.md) — template for Results + Decision narrative (goes in description on fulfil).
- [Global Jira Catalog](../../../jira-config/jira-team-catalog.md).
- [Global User Defaults](../../../jira-config/user-defaults.md).
