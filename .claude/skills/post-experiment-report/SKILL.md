---
name: post-experiment-report
description: Close out a {{COMPANY}} experiment. Synthesise the results (from an Amplitude link, notebook, raw notes, or a document), stress-test the launch/rollback narrative against the experiment setup, publish a post-launch report to Confluence ({{TEAM}} space) under the right initiative, and fulfil the Experiment ticket's Results / Learnings / Next steps / Decision fields. Use whenever the user wants to "close", "launch", "rollback", "write results for", or "generate a post-launch report on" an experiment.
---

# Post-Experiment Report

End-to-end close-out: results narrative → Confluence report → Jira Experiment ticket fulfilment.

## Grounding (run first)

Before drafting, delegate to the **kb-grounder** subagent with a brief stating the experiment topic, the experiment Jira key, and any related Confluence references (PRD, parent initiative, prior post-launch reports). Use the returned synthesis as your grounding for the *initiative context* (strategy fit, prior research, sibling experiments). Do not re-read the underlying files (`projects/`, `research/`, `{{KNOWLEDGE_BASE_PATH}}/`, `your team goals doc`, Confluence/Jira/Granola/Drive) in main context.

The Ingest step below still pulls the experiment ticket and results sources directly — kb-grounder is for surrounding context, not for the data the report is built from.

**When the results source is Amplitude (experiment, dashboard, chart, or notebook URL), delegate to the `amplitude-summarizer` subagent** instead of reading Amplitude tools in main context. It returns a structured brief — primary metric verdict, secondary signals, guardrails, adoption numbers, gaps — without flooding the main thread with raw chart tables. Use the brief as input to the narrative.

kb-grounder returns a structured synthesis with citations, verbatim quotes, and gaps. Treat its gaps as the checklist of what to ask the user or flag in the report. Skip only if the user has already supplied a kb-grounder synthesis.

## When to use

- "Close experiment {{JIRA_PROJECT_KEY}}-XXXXX" / "write the results for {{JIRA_PROJECT_KEY}}-XXXXX"
- "Generate a post-launch report for this experiment"
- "I've decided to launch / rollback [experiment] — do the write-up"
- "Fulfil the Results & Decision on [experiment ticket]"

## Required inputs (ask if missing — do not invent)

1. **The experiment ticket** (Jira key, e.g. `{{JIRA_PROJECT_KEY}}-NNN`) — source of truth for the setup (Hypothesis, Success Criteria, Primary Metric, Guardrails, Run window, Target Population).
2. **The results context** — any one or a combination of:
   - Amplitude experiment link (`https://app.amplitude.com/{{AMPLITUDE_ORG}}/...`)
   - Amplitude notebook link (`https://app.amplitude.com/{{AMPLITUDE_ORG}}/notebook/...`)
   - Raw notes / Granola meeting / text document
   - Confluence analysis page
3. **The user's decision** — `Launch`, `Rollback`, `Iterate`, or `Hold` (and which variant if there are multiple treatments).
4. **Target initiative / Confluence location** (optional) — the PRD / initiative page under which the report should live in {{TEAM}} space. If absent, infer from the experiment's parent Epic and confirm with the user before publishing.

If any of 1–3 are missing, pause and ask — never guess.

## Workflow (follow in order)

Load the detailed steps from [references/detailed-instructions.md](references/detailed-instructions.md). Do not skip stages.

1. **Ingest** — fetch the experiment ticket and all provided results sources.
2. **Validate setup** — read the documented Hypothesis, Success Criteria, and Primary Metric. If any are null on the ticket, stop and ask the user how to proceed.
3. **Synthesise observations** — extract data facts from the results sources, separated from interpretations.
4. **Stress-test the decision** — apply the [CSO Review Checklist](assets/cso-review-checklist.md). Flag every logic fallacy, narrative inconsistency, guardrail contradiction, confounder, or stakeholder risk you find.
5. **Ask the user to resolve flags** — present a numbered list of issues; never auto-resolve a flagged concern.
6. **Build the narrative** — use the [Post-launch Report Template](assets/report-template.md) (Results → Next steps → Durable learnings). Apply the Chief Science Officer self-review before output.
7. **Publish to Confluence** — follow [references/confluence-publishing.md](references/confluence-publishing.md) to locate the right initiative page in the {{TEAM}} space (key `ES`) and create the report as a child page. Confirm the target page with the user before creating.
8. **Fulfil the Jira Experiment ticket** — populate `customfield_{{CUSTOM_FIELD_ID}}` (Results), `customfield_{{CUSTOM_FIELD_ID}}` (Learnings), `customfield_{{CUSTOM_FIELD_ID}}` (Next steps), `customfield_{{CUSTOM_FIELD_ID}}` (Decision), `customfield_{{CUSTOM_FIELD_ID}}` (Results reviewed flag), `customfield_{{CUSTOM_FIELD_ID}}` (Decision follows Success Criteria flag). All textareas are ADF — use the helpers in [../experiment-creator/references/adf-helpers.md](../experiment-creator/references/adf-helpers.md).
9. **Post-update summary** — return a compact checklist to the user with:
   - Confluence page URL
   - Jira ticket URL with confirmation of every field set
   - Any flags the user resolved, and any that remain open
   - Any manual next steps (status transition, stakeholder notifications)

## What this skill does NOT do

- Create the experiment ticket — use `experiment-creator` for that.
- Transition the ticket to "Closed" — that is a manual step so the reader knows to review the Slack / Confluence auto-posts first.
- Rewrite the experiment setup (Context, Hypothesis, Primary Metric, Secondary Metrics, Success Criteria, Additional Information) — those fields are set at creation and are immutable record of the pre-experiment intent. Read from them; don't write over them.
- Create follow-up tickets unless the user explicitly asks.

## Shared Reference Materials

- [Post-launch Report Template](assets/report-template.md) — structure of Results / Next steps / Durable learnings.
- [CSO Review Checklist](assets/cso-review-checklist.md) — 4 principles + narrative-inconsistency probes.
- [Detailed Instructions](references/detailed-instructions.md) — full workflow with field IDs and tool calls.
- [Confluence Publishing](references/confluence-publishing.md) — how to place the report under the right initiative page in {{TEAM}}.
- [ADF Helpers (shared with experiment-creator)](../experiment-creator/references/adf-helpers.md) — Python pattern for building ADF payloads.
- [Voice & Epistemic Honesty Guide](../shared/voice-guide.md) — governs assertion strength, observation-vs-interpretation, no AI slop.
