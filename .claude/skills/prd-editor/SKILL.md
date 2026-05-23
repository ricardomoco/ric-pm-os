---
name: prd-editor
description: Edit an existing PRD or Product Strategy document surgically. Use when the user asks to "add", "update", "modify", "change", or apply decisions / meeting notes / stakeholder feedback / legal context to an existing document — including phrasings like "update the PRD based on [discussion]", "add this section", "change requirement X", "fix the metrics section". Also handles structural reconciliation against the canonical prd-writer template ("restructure", "reconcile", "force template structure", "audit against the template", "this document has drifted"). Runs a mandatory two-phase Propose → Execute protocol and treats user-provided context as input to interpret, not content to paste verbatim. Never invents content for missing sections; asks the user instead. Use prd-writer for creation from scratch.
---

# PRD Editor

## CORE MANDATE — read this before doing anything else

Editing is not writing. Your job is to change exactly what was asked and nothing else.

When the user provides rich context alongside an edit request (legal decisions, meeting notes, T&S feedback, stakeholder positions, compliance constraints), the context is **input for you to interpret** — not **content for you to paste into the document**.

If you skip Phase 1 and start editing, you will reliably produce:

- New chapters that summarise the discussion ("T&S Risks and Mitigation", "Commitments from Legal", "Recent Updates")
- Pre-intro preambles explaining what changed
- The same decision duplicated across Executive Summary, Requirements, Risks, and Open Questions
- Risk matrices spun up from a single legal exchange
- Inline source attribution ("per legal", "after discussion with TnS", "subject to legal approval")
- Renumbered or rewritten adjacent sections "for consistency"

These failures have happened in production. The two-phase protocol below is non-negotiable, with no exceptions for "quick", "obvious", or "small" edits.

## THE GOLDEN RULE — never invent information you don't have

When a canonical subsection lacks context (you don't have a Working Hypothesis to write, no Strategy Fit citation, no real Kill Switch protocol, no verbatim user quotes), **ASK** the user whether to include the subsection. Do NOT author from inferred problem statements, generic templates, "best practice" defaults, or plausible-sounding placeholders.

Structure is enforced. Content is never fabricated. If you don't have the content, your only legitimate move is to ask whether to include the slot at all.

## When the skill activates

Activate on any of:

- The user references an existing PRD, Product Strategy, or document file/URL
- The user uses verbs like add, update, modify, change, fix, revise, integrate, reflect, apply
- The user pastes context (legal decisions, meeting notes, stakeholder feedback, audit findings) and asks to "update the document based on" it
- The user asks to remove, rename, or restructure a section (this triggers `structural_change` — extra rules below)
- The user asks to **restructure**, **reconcile**, **force template structure**, **audit against the template**, or signals that the document has **drifted** from the canonical PRD shape (this triggers `reconcile_to_template` — extra rules below)

Do NOT activate on creation requests ("write a PRD for X", "draft a Product Strategy for Y"). Route those to `prd-writer`.

## Reconciliation mode (`reconcile_to_template`)

Triggered when an existing document has drifted from the canonical PRD template (orphan chapters, missing canonical sections, bloated sections, progressive-disclosure failures, mis-located content) and the user wants to reconcile it.

The reconciliation mode is a **meta Phase 1 producer**. It emits a batch proposal that contains:

1. **A reconciliation table** mapping every current section to the canonical template (MATCHES / WRONG_LOCATION / ORPHAN_CHAPTER / BLOATED / MISSING). The canonical structure lives at [../prd-writer/references/template.md](../prd-writer/references/template.md).

2. **Atomic relocation proposals** for orphan chapters and mis-located content. Each one routes through the appropriate downstream change type (`structural_change`, `update_strategy`, `update_requirement`, `update_metrics`, etc.) in Phase 2.

3. **Progressive-disclosure flags** — verbatim quotes from framing sections (Objective, Strategy Fit, Executive Summary) that contain requirements-level, AC-level, edge-case, or implementation-mechanics content that should be deferred to later sections.

4. **Authoring decisions (ASK items)** for canonical subsections that are MISSING and have NO context available in the document. Each missing subsection gets its own ASK so the user can answer independently:

   ```
   ASK: <canonical subsection name>
   Current state: <where content exists today, or "no context in the doc">
   Question: <one specific question — e.g. "Do you have a Working Hypothesis you want me to draft from your input? If not, I skip the subsection.">
   Default if no answer: SKIP
   ```

5. **Critical content decisions** — cases where the canonical relocation changes WHO sees the content / WHEN, and the user must explicitly resolve them (e.g. "does the X €120M precedent go in §Executive Summary or Appendix?").

### Mandatory rules for reconciliation

- **Chapter structure is enforced.** Top-level canonical headings (Executive Summary, Objective, Metrics, Requirements, Risks, etc.) must appear in the order the template specifies.
- **Subsection inclusion is per-case.** A canonical subsection like Working Hypothesis, Strategy Fit, Motivating Data, Kill Switch, Pre-Launch Checklist, Graduation Criteria, or Behavior Specification is included ONLY if context exists in the document or the user provides it. Otherwise, ASK whether to include. Empty canonical headers with `[TBD]` placeholders are forbidden.
- **No silent authoring.** Reconciliation never fabricates content for a missing subsection, even when "best practice" or "industry standard" would suggest a default. The golden rule (above) applies.
- **No leaf execution in this loop.** `reconcile_to_template` is PROPOSAL-ONLY. After the user confirms each atomic change and answers each ASK, every approved change routes through its own DOC_MUSTS change type's Phase 2 execute loop.
- **Critical-content decisions are explicit.** When a relocation changes which audience sees the content first (e.g. moving the X €120M precedent from Appendix into Executive Summary), surface the trade-off and ASK before proposing the relocation as a confirmed change.

See [DOC_MUSTS.yml](DOC_MUSTS.yml) `reconcile_to_template:` for the full contract.

## Pre-flight

1. Invoke the `pm-writing-standards` skill once per session before producing any edited prose. It loads the {{COMPANY}} style axioms (no em-dashes, no weasel words, active voice, evidence-first framing, etc.) that all edits must respect.
2. Read [../shared/voice-guide.md](../shared/voice-guide.md) for tone calibration.
3. Read [../prd-writer/references/template.md](../prd-writer/references/template.md) once to confirm the canonical PRD structure (Executive Summary, Objective, Metrics, Requirements, Risks, etc.). Treat this as the legal sections list — anything not in the template is a structural change.

References are SHARED with `prd-writer`. Do not duplicate.

## The two-phase protocol

### PHASE 1 — Propose (mandatory; never skip)

When the user provides an edit request, regardless of how it's phrased:

1. **Read the document fully.** Capture the exact section names and item identifiers (R-001, Risk L3, Open Question Q4, etc.).

2. **Read the user-provided context separately.** Identify what is:
   - **Required change** (the user wants this in the document)
   - **Supporting rationale** (helps you understand the change, does NOT belong in the document)
   - **Off-topic background** (do not act on)

3. **Produce a numbered list of atomic proposed changes** in this exact format:

   ```
   [n]. TYPE: <change_type_from_DOC_MUSTS.yml>
       Location: <exact section name + item identifier if applicable>
       Change: <one sentence describing exactly what will change>
       Justification: <one sentence linking it to the user's request>
   ```

4. **State explicitly what is NOT being changed and why.** Use the format:

   ```
   NOT changing:
   - <section/item>: reason (e.g. "not named in the request", "covered by existing row R-005", "would be a structural change requiring explicit confirmation")
   ```

5. **Ask for explicit confirmation:** "Please confirm, reject, or adjust each item. I will not touch the document until you reply."

#### Rules for Phase 1 (no exceptions)

- **One change per location.** Never propose two changes to the same item unless the user's request explicitly requires both.
- **No structural changes by default.** Never propose adding a new section, renaming an existing one, removing a section, or reordering sections unless the user's request EXPLICITLY named the structural change. If you think a structural change is needed but the user didn't name it, **ask first** instead of proposing.
- **No source attribution inside the proposed changes.** "Per legal", "based on T&S meeting", "after compliance discussion" — none of these belong in the change text. The change stands on its own.
- **Ambiguous context = clarifying question.** If the user's context could map to two different changes (e.g. "Legal said we need to handle revocation" could mean update Requirements OR update Risks OR both), ask which one they want instead of guessing.
- **No anticipatory edits.** Do not propose changes that the user might want next ("you'll probably also need to update the Risk section"). Propose only what was asked.
- **No bundling.** A single user request that maps to four atomic changes gets four numbered items, not a single "rewrite the section" item.

#### Example Phase 1 output (real shape)

User input: "Update the PRD based on the legal team's decisions. They confirmed we can use [example PSP] KYC for Phase 1 and need DSA-KYB audit before Phase 2. Also said the badge has to be revoked within 30 minutes of any T&S flag."

Phase 1 output:

```
Proposed changes (4 atomic):

1. TYPE: add_requirement
   Location: §Requirements table, append as new row
   Change: Add R-NEW: badge revocation triggered within 30 minutes of any T&S flag.
   Justification: User stated this is a confirmed requirement from legal.

2. TYPE: update_requirement
   Location: §Requirements, existing row R-003 (KYC verification path)
   Change: Specify [example PSP] as the KYC provider for Phase 1.
   Justification: User stated [example PSP] is the confirmed Phase 1 path.

3. TYPE: add_open_question
   Location: §Open Questions table, append as new row
   Change: Add Q-NEW: DSA-KYB audit completion as a Phase 2 prerequisite, owner Legal, target TBD.
   Justification: User flagged this as a Phase 2 gate not yet resolved.

4. TYPE: update_metrics
   Location: §Guardrail Metrics table, existing row "badge propagation latency"
   Change: Set Alert Threshold to "p95 > 30 min".
   Justification: User stated the 30-minute revocation cap is a hard requirement.

NOT changing:
- §Executive Summary: legal context is rationale, not part of the impact summary
- §Risks: no new risk was named; revocation latency is covered by the new guardrail
- §Document History: will update only on the user's explicit go-ahead, after the changes land
- No new "T&S Commitments" or "Legal Decisions" section: not requested, and would duplicate content already in Requirements

Please confirm, reject, or adjust each item. I will not touch the document until you reply.
```

### PHASE 2 — Execute (only after explicit user approval)

For each approved change, run this loop INDEPENDENTLY:

1. **Classify.** Confirm the change type from [DOC_MUSTS.yml](DOC_MUSTS.yml). State the type out loud.

2. **Declare scope.** Before editing, state:
   - Which section(s) will be touched (must match `allowed_scope` for this change type)
   - Which operations will be performed (must match `allowed_operations`)
   - Which `forbidden_operations` are most relevant for this edit (pick the 2–3 most likely traps)

3. **Execute.** Make the edit strictly within declared scope. Use the file's Edit tool with `old_string` / `new_string` scoped to the minimum necessary text. Never use `replace_all` on prose.

4. **Validate.** Run the `validation_checklist` for this change type item by item. State **PASS** or **FAIL** for each. If any item is **FAIL**: revert the edit, re-read the document, redo. The change is not done until every validation item is **PASS**.

5. **Cross-check against [forbidden-patterns.md](forbidden-patterns.md).** Specifically scan for: inline source attribution, unsolicited sections, content duplication, format drift on untouched sections. If any pattern is detected: revert and redo.

Then, and only then, move to the next approved change. Each change gets the full loop.

#### Special rule for `structural_change`

`structural_change` covers: adding a new section, removing a section, renaming a section, reordering sections, splitting one section into multiple, merging sections.

- It can only be PROPOSED in Phase 1 if the user's request explicitly named the structural change (e.g. "add a Behavior Specification section", "remove the Out of Scope section", "rename Risks to Risks and Mitigations").
- It CANNOT be executed in Phase 2 without an additional, separate user confirmation: "You approved the structural change in Phase 1. To confirm: this will add/remove/rename section X. Type 'confirm' to proceed, or describe an alternative." Wait for the literal confirmation before executing.
- After execution, validate that no OTHER sections were affected (no renumbering, no header restyling, no cross-references rewritten unless explicitly approved).

## Output discipline

- After Phase 2 completes for all approved changes, present a clean summary: "Applied N changes to sections X, Y, Z. Did not touch sections A, B, C." Do NOT add a "Summary of edits", "Changes made", or "Recent updates" block to the document itself — that's a forbidden pattern.
- The Document History table in the PRD template is the only canonical place for version-level edit notes. Update it only if the user explicitly asks.
- Never declare done without running the validation checklist for every change. Skipping validation is the failure mode this skill exists to prevent.

## When to escalate to the user

Ask, don't guess, when:

- The user-provided context is ambiguous about WHICH section to change
- A proposed change would require touching more than one section (clarify whether all are in scope)
- A structural change seems implied but wasn't explicitly named
- A validation_checklist item keeps failing across retries (something about the request doesn't match the document state)
- The change conflicts with an existing requirement or risk (the document already says X; the new context says not-X)

The cost of asking is one round-trip. The cost of guessing is the failure mode this skill exists to prevent.

## Adjacent skills

- **`/prd-writer`** — for creating a new PRD from scratch. Includes its own `edit-existing.md` phase for very light surgical edits; this skill (`prd-editor`) replaces that phase whenever rich context is involved.
- **`/pm-writing-standards`** — mandatory pre-flight sub-skill for every edit's prose.
- **`/prd-roaster`** — adversarial critique. Run AFTER prd-editor finishes a substantive edit, before sending up the chain.

## Final reminder

Phase 1 is non-skippable. If you find yourself about to type into the document without having posted a Phase 1 proposal and received explicit confirmation, **stop**. Post the Phase 1 proposal instead. The user's downside from waiting one round-trip is small. The downside from hallucinating chapters into a stakeholder-facing PRD is large and concrete.
