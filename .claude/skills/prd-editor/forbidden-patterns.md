# Forbidden Patterns

This file lists patterns the `prd-editor` agent must NEVER produce. Each pattern includes:
- The pattern with concrete examples (drawn from real failure modes)
- WHY it is banned
- The correct alternative

Cross-check the output of every Phase 2 execution against this list. If any pattern is detected, the validation step has FAILED — revert and redo.

---

## 1. Inline source attribution

NEVER include sentences inside the document that reference the source of a decision, conversation, stakeholder, or meeting.

### WRONG (real examples from production failures)

- "After talking with legal, we decided to revoke the badge within 30 minutes of any T&S flag."
- "Per the conversation on 2026-05-05, [example PSP] is the confirmed KYC provider for Phase 1."
- "Subject to legal approval, this requirement applies only to ES users."
- "As discussed with Alex from T&S, the propagation must complete within the SLO."
- "Decisions from the compliance team mandate identity verification via DSA-KYB."
- "Based on the legal review held last Thursday..."
- "Following the T&S audit findings..."

### Why banned

- The stakeholder reading the PRD does not need to know who decided. They need to know what we are building.
- Source attribution inside the document makes the decision read as provisional or contested.
- The Decision Log appendix (already in the template) carries this provenance for traceability. The main body always reflects the CURRENT decided state.
- Attribution inflates token count, fragments the read, and ages badly (next quarter no one knows who "Alex from T&S" was).

### RIGHT alternative

- State the requirement, constraint, risk, or metric as a current fact.
- If the source must be preserved for traceability, add a single one-line entry to the Decision Log appendix: `| 2026-05-19 | Confirmed [example PSP] as KYC provider for Phase 1 | <link to Slack / Confluence comment> |`. Do NOT cite the source elsewhere.

#### Side-by-side

WRONG:
> R-007: Badge revocation triggered within 30 minutes of any T&S flag (per legal review 2026-05-19).

RIGHT:
> R-007: Badge revocation triggered within 30 minutes of any T&S flag.

(Provenance, if needed, goes in the Decision Log appendix as a separate one-line entry.)

---

## 2. Unsolicited sections

NEVER create new sections, chapters, callouts, or major headings unless the user EXPLICITLY named them in the request. This is the most common and damaging failure mode.

### Banned section types (observed in production)

- "T&S Risks and Mitigation"
- "Compliance Risks"
- "Commitments to Fix from T&S"
- "Outstanding Items from Legal"
- "Recent Updates" / "Updates from [Date]"
- "Summary of Edits" / "Changes Made on [Date]"
- "Change Log" / "Revision History" (the template already has `Document History`)
- "Executive Summary of the Edit" / "Update TL;DR"
- "Background Context" / "Pre-intro Context Block"
- "Open Issues from [Stakeholder]"
- "Glossary additions"
- "T&S Position Paper" / "Legal Position Paper" as a NEW chapter

### Why banned

- The PRD template has CANONICAL locations for every category of content. Risks go in §Risks. Open issues go in §Open Questions. History goes in §Document History. New sections fragment the document and create stakeholder confusion.
- A reader scanning the PRD should see one canonical structure, not an archaeology of edit-driven chapters.
- Unsolicited sections signal that the agent is trying to "show its work" rather than execute the change.
- These sections age badly: six months later, "Commitments to Fix from T&S" reads as ambiguous (still outstanding? already fixed?) and rots in the document.

### RIGHT alternative

- Use the existing canonical sections. If a new risk emerges, ADD A ROW to the existing §Risks table via the `add_risk` change type. If a new question emerges, ADD A ROW to §Open Questions via the `add_open_question` change type.
- If the user genuinely wants a new section (rare), they will name it. Treat that request as `structural_change`, with all the extra guardrails that apply.
- For stakeholder position papers (T&S audits, Legal memos), reference them from the appendix's `Stakeholder position papers` slot in the template — do not reproduce them as new chapters.

---

## 3. Content duplication

NEVER place the same content in more than one section.

### Banned shapes

- Same requirement appearing in §Executive Summary AND §Requirements (both fully written out)
- Decision context copied into §Objective, §Risks, AND §Open Questions
- Acceptance Criteria duplicating the Requirement text verbatim ("Requirement: badge must be revoked within 30 min" / "AC: Given a T&S flag, when the event fires, then the badge is revoked within 30 min")
- Same data point in §Motivating Data AND §Risks Detection column AND §Working Hypothesis
- Same constraint appearing in §Requirements AND §Out of Scope (these are opposites — duplicating them creates contradiction)
- A risk's mitigation text repeated in §Pre-Launch Checklist as a checkbox
- The new requirement also summarised in §Working Hypothesis or §Strategy Fit

### Why banned

- Stakeholders re-read the same text and assume something subtle differs between the two copies. Ambiguity multiplies; questions multiply.
- Edits to one copy do not propagate to the others, producing silent inconsistencies over time.
- Duplicated content inflates the document's perceived complexity and reduces signal density.

### RIGHT alternative

- One canonical location per fact. Reference from other sections with a label, never a copy: "see R-005" / "see Risk L3" / "see §Metrics Graduation Criteria".
- The Executive Summary summarises OUTCOME and IMPACT, not the requirement list verbatim. It says "Phase 1 ships verified-badge logic for KYC sellers with 30-minute revocation latency" — not the full Requirements row.
- Acceptance Criteria describe the TEST of the requirement (Given/When/Then), not a paraphrase of the requirement text.
- If a fact must appear in multiple places (rare), they must convey different angles: §Motivating Data carries the diagnostic baseline; §Risks Detection carries the alert threshold. Same metric, different jobs.

---

## 4. Format drift on untouched sections

NEVER reformat, renumber, restyle, or rewrite sections that were not in the approved scope.

### Banned operations

- Renumbering items in §Requirements or §Edge Cases when a new row is added in the middle
- Bolding or headering an existing requirement to "match the importance" of a newly added one
- Rewriting adjacent requirements for "consistency" or "improved clarity"
- Changing markdown table column widths or alignment
- Replacing emojis in section headers (if the document uses them) with text equivalents, or vice versa
- Converting a paragraph into bullets, or bullets into a paragraph, on a section that was not in scope
- "Cleaning up" or "tightening" prose in any section the user did not name
- Changing bullet symbols (• → -, * → -, etc.) outside the touched section
- Re-aligning markdown table pipes for cosmetic neatness across the whole document

### Why banned

- The user did not ask. Changes outside the approved scope are noise that the user must visually filter out during diff review.
- Adjacent edits make it harder for the user to verify the actual change landed correctly.
- The PM owns the established voice and structure; the editor's job is to preserve them.
- Format drift compounds across many edits, slowly turning a focused document into an over-styled, inconsistent one.

### RIGHT alternative

- Touch only what was approved in Phase 1.
- If you genuinely notice a real quality issue elsewhere (a broken table, a missing acceptance criterion, a contradicting statement), surface it as a SEPARATE proposed change for the user's approval. Do not fix it silently.
- Use the file's Edit tool with `old_string` / `new_string` scoped to the minimum text. Never use `replace_all` on prose.

---

## 5. Pre-intro preambles and summary-of-edits sections

NEVER add a "Recent changes", "Updated on [date]", "Summary of edits", "What changed", or "Recent updates" block to the document.

### Banned shapes

- A new section ABOVE the Executive Summary explaining what changed
- A floating callout at the top of the doc summarising recent edits
- A "TL;DR of recent updates" appearing before the document's own Executive Summary
- Inline tags next to changed items: `[UPDATED]`, `[NEW]`, `[MODIFIED]`, `[v2]`, `[CHANGED 2026-05-19]`
- An "Update preamble" paragraph at the top of §Requirements explaining recent additions
- A "What's new in this version" callout box anywhere in the document

### Why banned

- The §Document History table at the end of the template is the canonical place for version-level edit notes. Anything else is duplication or noise.
- Stakeholders should be able to read the document linearly, top to bottom, without context-switching into edit-meta. The meta sits in the appendix's Document History.
- `[UPDATED]` tags pollute the document permanently — every future version inherits the tags from prior versions.
- Pre-intro preambles bury the actual Executive Summary, which is what stakeholders need to see first.

### RIGHT alternative

- Update §Document History with one row: version number, ISO date, author, one-line summary of changes.
- Do NOT add tags or callouts inline. The diff itself is the evidence of what changed.
- If the user genuinely needs a "what changed" briefing (rare), produce it as an out-of-document message to them — never as a section inside the PRD.

---

## 6. Risk-matrix inflation

NEVER promote ad-hoc risks discussed during the edit conversation into the §Risks section unless the user explicitly asked for each one.

### Banned shapes

- A "T&S Risks and Mitigation" chapter spun up because T&S came up in the discussion
- A "Compliance Risks" appendix added because legal context was provided
- Adding 5+ new risk rows after a single legal exchange
- Inventing Detection thresholds and Mitigations that were not discussed
- Splitting one user-mentioned risk into three "for completeness"
- Promoting an Open Question into a Risk because it sounds important
- Adding meta-risks like "Risk: not aligning with T&S could cause [generic harm]"

### Why banned

- Risks are committed positions, not brainstorming output. Each row implies a real Detection signal and a real Mitigation owner.
- An inflated §Risks section makes the document defensive and noisy instead of declarative.
- Detection thresholds invented without basis violate the no-invention rule. They will not match telemetry that exists, and will be quietly ignored by engineering.
- Auditors and stakeholders will treat the Risks section as canonical; padding it with conjectural risks erodes the credibility of the real ones.

### RIGHT alternative

- If a new risk genuinely emerged from the discussion, propose ONE `add_risk` change in Phase 1, with the actual Detection signal and the actual Mitigation discussed.
- Do not bulk-add risks. One row per genuine risk.
- If a "risk" is really an unresolved question, route it to `add_open_question` instead.

---

## 7. Cross-section content leakage

NEVER let content from one change type bleed into other sections.

### Banned shapes

- An `update_metrics` change that also adds metric-language sentences to §Working Hypothesis or §Executive Summary
- An `add_requirement` change that also expands §Strategy Fit to "explain" the new requirement
- An `update_strategy` change that also rewrites the relevant §Risks rows to "align"
- A `structural_change` that also restyles the new section's siblings to "match"
- A change to §Open Questions that also adds context to §Stakeholder

### Why banned

- One change per location was the Phase 1 contract. Cross-section leakage breaks it.
- Each section has a job (decisions vs context vs commitments vs risks). Mixing the jobs across sections corrupts the document's information design.
- Leakage hides true scope from the user during diff review.

### RIGHT alternative

- If the user genuinely wants a change in multiple sections, propose multiple atomic changes in Phase 1 and get explicit approval for each.
- If you notice that an approved change "should also" affect another section, surface it as a clarifying question before executing — do not act on the inference.

---

## 8. Anti-cleanup discipline

NEVER "clean up", "tighten", "polish", or "improve readability" of sections you were not asked to edit.

### Banned shapes

- Rewriting an existing requirement to make it "more parallel" with a newly added one
- Replacing the existing voice with a tighter style after an edit
- Removing weasel words from adjacent sections during the same Phase 2 loop
- Consolidating two existing risk rows into one because they "feel duplicative"
- Renaming a section header to match a perceived convention

### Why banned

- The user did not approve these edits in Phase 1.
- Cleanup edits are subjective and the PM may have intended the existing voice.
- Each silent cleanup erodes the user's trust that Phase 1 == executed scope.

### RIGHT alternative

- If you spot a real cleanup opportunity, list it at the end of the Phase 2 summary as a `Suggested follow-up:` line, never as an executed edit.

---

## 9. Inventing content for missing canonical sections

NEVER author content for a missing canonical PRD section or subsection without explicit user-provided context. This is the prd-editor skill's **golden rule**: never invent information you don't have.

### Banned shapes

- Authoring a Working Hypothesis from inferred problem statement: "We believe users will engage more because [inferred reason], leading to [inferred outcome]"
- Filling a Strategy Fit citation from generic parent-strategy language: "This supports the broader trust initiative" (with no actual parent doc cited)
- Writing a Kill Switch protocol from generic engineering practice: "Toggle the feature flag in <5 minutes" (when no actual rollback path has been validated)
- Authoring fake user quotes attributed to anonymous personas or paraphrased from research summaries
- Pre-populating sub-headings with placeholder prose: `[TBD]`, `[to be added]`, `[Working hypothesis goes here]`, `[Author the strategy fit citation]`
- Composing a Pre-Launch Checklist from default template items when no actual cross-tribe sign-off has been confirmed
- Inferring a graduation criterion ("Primary metric hits target at p<0.05") when the user did not state the target or the significance bar
- Authoring an Executive Summary from a thematic synthesis of body content the agent has just read (this still inflates and re-frames)
- Filling a Motivating Data section with industry benchmarks when the document lacks {{COMPANY}}-specific baselines
- Auto-populating a Behavior Specification with "N/A — not an AI feature" without confirming with the user that the feature is non-AI

### Why banned

- A PRD's missing section IS information. The reader needs to know "this section was intentionally skipped because [context not yet available]" — not "the agent invented something plausible to fill the slot."
- Once invented content lands, downstream readers (engineering, legal, leadership) cite it as if it were real. The fabrication propagates into sprints, decisions, and external commitments.
- "Best practice" defaults are almost always wrong for the specific context. A generic Kill Switch misses the actual feature-flag path; a generic Working Hypothesis misses the team's actual mental model; a generic Pre-Launch Checklist omits the tribe-specific gates.
- Reconciliation against the template enforces STRUCTURE, not content. Confusing the two is the failure mode this section exists to prevent.

### RIGHT alternative

- ASK the user explicitly whether to include the missing subsection. Use the ASK contract from `reconcile_to_template`:

  ```
  ASK: <subsection name>
  Current state: no context available in the document
  Question: do you want to include this subsection? If yes, please provide the content
            (e.g. the Working Hypothesis sentence, the Strategy Fit parent-doc citation,
            the Kill Switch flag path). If no, I skip it entirely.
  Default if no answer: SKIP
  ```

- If the user provides content, treat it as a user-supplied edit and route it through `update_strategy` (or the appropriate change type) with the user-provided text verbatim.
- If the user says skip, do not include the subsection at all. Do not leave an empty header.
- For partial context (e.g. the document has the +1.2% / +5% motivating numbers but no verbatim user quotes), surface BOTH parts: include the numbers via relocation, ASK about the quotes.

### Special-case: subsections with valid skip reasons

Some canonical subsections are legitimately skipped in some PRDs. These exceptions still require explicit user confirmation; they are not defaults the agent can apply silently:

- **§Behavior Specification** — "N/A — not an AI feature" is a valid skip when the feature provably does not use ML, scoring, or generative output. ASK the user to confirm.
- **§Kill Switch** — for non-experiment PRDs (migrations, one-shot launches), may be replaced with "Pre-launch validation criteria + Post-launch monitoring + Decision rule" per the prd-writer skill's "Non-experiment PRDs" guidance. ASK before applying the substitution.
- **§Experiment Details** — if the PRD is a non-experiment artefact (infrastructure, regulated launch with no rollback), the section may be skipped or restructured. ASK.
- **§Graduation Criteria** — same exception as Kill Switch for non-experiment PRDs. ASK.

For every other canonical subsection, the absence of content is an ASK to the user, never an opportunity to invent.

---

## Pattern recognition: scan for these tells before declaring done

Before claiming a change is complete, scan the output for these textual tells:

- Any sentence containing **"per"**, **"after"**, **"as discussed"**, **"subject to"**, **"based on conversations"**, **"following"** (when followed by a meeting/person/team) → inline source attribution
- Any new header containing **"T&S"**, **"Legal"**, **"Compliance"**, **"Commitments"**, **"Recent"**, **"Updates"**, **"Summary"**, **"Pre-"** → likely unsolicited section
- Any new content above the §Executive Summary header → pre-intro preamble
- Any inline **`[NEW]`**, **`[UPDATED]`**, **`[CHANGED]`**, **`[v2]`**, **`[REVISED]`** → drift tag
- Any proper noun (e.g. "DSA-KYB", "[example PSP]", "Top Profile") appearing 5+ times across distinct sections → likely duplication
- Any new bullet beginning with **"As discussed,"**, **"Per the meeting,"**, **"Based on input from,"** → attribution leak
- Any added paragraph in §Executive Summary, §Objective, or §Working Hypothesis when the change type was `add_requirement`, `add_risk`, or `add_open_question` → cross-section leakage

Each detected tell is a FAIL on validation. Revert the change, re-read the affected section, and redo within the declared scope.
