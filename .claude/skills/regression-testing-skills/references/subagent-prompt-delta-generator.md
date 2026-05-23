# Subagent prompt template — delta generator

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool. Dispatch via `subagent_type: general-purpose`.

This subagent reads a pre-fix and post-fix artifact and produces a structured delta — the ground-truth scorecard for the regression test. It is the autonomous replacement for hand-writing the delta.

---

You are generating the regression-test scorecard for a {{COMPANY}} skill optimization. Your task is to enumerate every issue that was caught between the pre-fix and post-fix versions of an artifact, citing the specific rule each maps to.

## Files you must read (and only these)

1. `{{PRE_FIX_PATH}}` — the rough draft of the artifact, before any review pass.
2. `{{POST_FIX_PATH}}` — the same artifact after review.
3. `{{SKILL_PATH}}` — the canonical skill that produced or governs the artifact. Read it to learn the rule names so you can cite them precisely.
4. `{{PM_WRITING_STANDARDS_PATH}}` — most writing skills mandate this required sub-skill; many of the deltas will cite rules from here.
5. {{ADDITIONAL_REFERENCES}} — any reference files the canonical skill points at (rubrics, checklists, extracted CSO files). Empty if none.

## What to do

1. Read all files listed above in full.
2. Compute a structured diff between pre-fix and post-fix in your head. For every difference (text removed, text added, text restructured, paragraph moved, sub-header inserted, owner relabelled, etc.), determine whether it represents a **rule-driven correction** (the human reviewer caught a violation) or a **content addition** (new information that wasn't in pre-fix and isn't a correction).
3. Discard content additions. Keep only rule-driven corrections. The delta is a list of CORRECTIONS, not a diff.
4. For each correction, identify the specific rule it maps to. Cite by source file + rule identifier as documented in that file. Examples (illustrative — use the actual heading and identifier from the source file you read, do not copy these verbatim or invent rule numbers): `cso-review.md 2.1: variant scope verification`; `pm-writing-standards Axiom 3 ACTION: internal-scaffolding strip`; `<skill-name> SKILL.md "<heading>": <rule name>`. Only cite rules that actually appear in the files you read.
5. Number each item D1, D2, ... in the order they appear in the artifact.

## Output format

Strict structured output, no preamble or commentary. One block per delta item, separated by blank lines. Each block has exactly four lines:

```
## D<N>: <one-line summary of the violation>
- **Pre-fix excerpt:** "<quoted text from pre-fix or location description>"
- **Post-fix correction:** "<quoted text from post-fix or 'removed entirely'>"
- **Rule violated:** <source file + rule identifier as documented in that file — same format as Step 4>
```

End with a single line: `Total: <N> deltas.`

## What NOT to do

- Do NOT include content additions in the delta. The post-fix may have added entirely new sections (e.g., a new Durable Learnings sub-section that didn't exist in the pre-fix). These are not corrections; they are new information. Skip them.
- Do NOT include cosmetic changes (whitespace, capitalization, punctuation) unless they map to a specific rule (e.g., em-dash removal maps to pm-writing-standards Axiom 2 ACTION).
- Do NOT propose what the rule SHOULD have caught. The delta is descriptive of what the human caught, not prescriptive of what the skill should have caught.
- Do NOT cite a rule you cannot find in the files. If you spot a correction but cannot map it to a documented rule, write `<no documented rule — possible new rule candidate>` as the rule line. The skill-edit-proposer subagent will use these candidates to propose new rules.
- Do NOT skip items because they look minor — a missed em-dash IS a delta if pm-writing-standards forbids em-dashes. Be exhaustive.

## Edge cases

The patterns below are illustrative — they are post-experiment-report-shaped because that's the skill the protocol was first developed against. The general rule is: **map every correction to a rule documented in the canonical skill or `pm-writing-standards`; when a correction has no documented rule, mark it as a new-rule candidate.** Specific examples that should generalize to other artifact types:

- **Content moved between sections** (e.g., one section to another in any skill that has section-discipline rules): cite the corresponding section-discipline rule from the canonical skill.
- **Rewording without semantic change**: skip unless it maps to terminology-lock or a similar rule.
- **Owner changed from a personal name to a team name** (in any skill that prefers team owners): cite the team-level-owner rule.
- **Internal scaffolding stripped** (Phase 1, ATL, Pillar X, sprint codenames): cite `pm-writing-standards` Axiom 3 internal-scaffolding-strip.
- **Sub-headers added** for a section that crossed an N-thesis threshold: cite the sub-headers rule if the canonical skill has one.
- **A claim about identity / equivalence / isolation softened** ("X is identical to Y" → "X bundles changes A, B, C"): cite the variant-scope or analogous verification rule.
- **A synthesized rationale removed** (rationale that reads as "the data supported it" with no user-supplied source): cite the rationale-not-synthesized rule if the canonical skill has one.
- **A hypothesis or claim restated to be self-contained** (no implicit references): cite the self-containment rule if applicable.

When in doubt about whether a correction maps to a documented rule, search the canonical skill and `pm-writing-standards` for keywords from the corrected text. If no rule surfaces, write `<no documented rule — possible new rule candidate>` and let the skill-edit-proposer evaluate.
