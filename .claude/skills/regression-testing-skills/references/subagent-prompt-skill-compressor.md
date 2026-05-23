# Subagent prompt template — skill compressor

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool.

**Dispatch:** `subagent_type: general-purpose`, `model: opus`. This is the one phase where output quality dominates token cost — getting the compressed draft wrong forces an extra iteration loop. Use the most capable model available.

This subagent reads the canonical SKILL.md + a compression strategy + the bash audit, then writes the compressed SKILL.md draft directly into the iteration workspace. It is invoked once per iteration. The compressed draft is then A/B-tested by corpus-scorer subagents in the next phase.

---

You are compressing a {{COMPANY}} skill that has accreted bloat over time. A previous auditor pass identified specific compression moves. Your job is to produce the compressed SKILL.md that executes those moves while preserving every rule the skill currently catches.

## Files you must read (and only these)

1. `{{SKILL_PATH}}` — the canonical SKILL.md you're compressing.
2. `{{STRATEGY_PATH}}` — the compression strategy from the auditor (cross-section restatements to collapse, sub-patterns to merge, multi-example pairs to deduplicate, target word count).
3. `{{AUDIT_PATH}}` — the bash structural audit. Quantitative reference for the strategy.
4. {{ADDITIONAL_REFERENCES}} — sibling reference files the canonical skill points at (rubrics, checklists). These constrain what the compressed version can move to references/ vs keep inline. Leave empty if there are none.

## Files you MUST NOT read

- The corpus prefixes or deltas at `{{SKILL_DIR}}/regression-corpus/`. They are the answer key for the regression test in the next phase; reading them biases the compression toward those specific failures and breaks the test's evidence value.
- Other skills in `.claude/skills/`.

## What to do

1. Read all four input files. Internalise the strategy's identified moves and target word count.
2. For each move in the strategy, apply the corresponding edit:
   - **Collapse cross-section restatement** → keep the rule in its canonical location (the strategy names which one); replace the duplicate occurrence with either a one-line pointer or nothing if the canonical location is discoverable by structure.
   - **Merge sub-pattern proliferation** → replace 3+ named sub-patterns with one umbrella rule that lists the sub-patterns as bullets or as a numbered checklist within ONE rule body. Keep one canonical example per sub-pattern; move extras to references/ if the strategy says so.
   - **Deduplicate multi-example redundancy** → keep one canonical WRONG/RIGHT pair per rule. Choose the example that most clearly illustrates the failure pattern, not the most domain-specific one.
   - **Rewrite final-pass / checklist** to one-line scans. The body of the rule lives in the canonical location; the checklist points at it without restating.
   - **Pointer-without-body** → for each Quick-Reference or pointer-style entry, EITHER add the corresponding body ACTION at the cited location, OR remove the pointer if the rule already exists elsewhere in the skill. The orphan-pointer state must not survive the compression.
3. **Preserve ALL rules** the canonical skill catches. Compression is reorganisation, not elimination of capabilities. If you are tempted to drop a rule because it looks redundant, treat that as a signal that you have not understood its scope — keep it and document the kept rule.
4. **Apply the pm-writing-standards discipline** to your own writing: no em-dashes in prose, active voice, one idea per sentence, no weasel words, mechanism before name. The compressed draft is itself a {{COMPANY}} document.
5. Write the compressed SKILL.md to `{{COMPRESSED_DRAFT_PATH}}` (use the Write tool). The file must be a valid SKILL.md with the SAME frontmatter `name` and `description` as the canonical version.
6. Verify your output's word count is at or below the target word count. If you cannot hit the target without dropping rules, OVERSHOOT the word count rather than dropping rules — the regression test will catch fidelity loss but will not reward compression that lost a capability.

## What NOT to do

- Do NOT add new rules. New rules come from `/regression-testing-skills:learn`, not from compression.
- Do NOT remove rules. If a rule looks redundant, ask the auditor's strategy whether it was flagged for removal; if not, keep it.
- Do NOT change the frontmatter `name` or `description` unless the strategy names one as a compression target.
- Do NOT introduce em-dashes, weasel words, passive voice, or other pm-writing-standards violations in the compressed draft.
- Do NOT generate a diff or patch instructions. Output the COMPLETE compressed SKILL.md as a single file.
- Do NOT touch the corpus, the snapshot directory, or any file outside `{{COMPRESSED_DRAFT_PATH}}` (and any references/ files the strategy explicitly authorises).

## Output

Write the COMPLETE compressed SKILL.md to `{{COMPRESSED_DRAFT_PATH}}`. The file must:

- Start with the same `---` frontmatter (`name`, `description`) as the canonical version.
- Be self-contained markdown (no patches, no diffs, no "..." elisions).
- Hit or undershoot the target word count if achievable without dropping rules.
- Be ready for the corpus-scorer subagents to apply directly to corpus prefixes in the next phase.

After writing, return a brief one-paragraph summary: target word count, achieved word count, list of moves applied (one per line), and any rules you were tempted to compress but preserved (and why).
