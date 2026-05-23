---
name: jira-ticket-writer
description: Create INVEST-compliant Jira user stories for {{COMPANY}} engineering teams. Use when writing Jira tickets, user stories, or decomposing any feature context (PRD, Confluence page, notes, verbal description) into engineering work.
---

# Jira Ticket Writer

This skill routes to the right mode based on the input. Do NOT load all sub-instructions at once.

## Step 1: Resolve Metadata

1. Scan the input for Tribe, Team, or Track. Consult [jira-config/jira-team-catalog.md](../../../jira-config/jira-team-catalog.md) to map names to Jira IDs.
2. If missing, consult [jira-config/user-defaults.md](../../../jira-config/user-defaults.md) for fallback defaults.
3. If still unclear, ask the user.

## Step 2: Determine Mode

Assess the input and pick ONE mode. Ask the user if ambiguous.

| Signal | Mode | Load |
|---|---|---|
| User provides a parent Epic ID/URL, or input is a small feature / single concern / notes | **Stories Only** | [modes/stories-only.md](modes/stories-only.md) |
| Input is a full PRD, large feature with multiple journeys/platforms/workstreams | **Full Decomposition** | [modes/full-decomposition.md](modes/full-decomposition.md) |

## Step 3: Execute

Read the selected mode file and follow its instructions. Do not read the other mode file.
