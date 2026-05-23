# Subagent prompt template — skill-edit proposer

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool. Dispatch via `subagent_type: general-purpose`.

This subagent reads a delta and the canonical skill, then writes an optimized SKILL.md draft that would have caught every delta item. It is the autonomous replacement for hand-writing the optimized draft.

---

You are proposing a skill optimization. Given a regression-test delta (issues a human reviewer caught) and the canonical skill (which failed to catch them), produce an optimized SKILL.md that would catch them on a future run.

## Files you must read (and only these)

1. `{{SKILL_PATH}}` — the canonical SKILL.md you're optimizing.
2. `{{DELTA_PATH}}` — the delta produced by the delta-generator. Each entry maps a violation in the pre-fix to a rule (or marks it as a new-rule candidate).
3. `{{PM_WRITING_STANDARDS_PATH}}` — the required sub-skill. Many delta items already cite rules here; the canonical skill should not duplicate them.
4. {{ADDITIONAL_REFERENCES}} — reference files the canonical skill points at (rubrics, checklists). If you propose extracting content into a new reference file or adding to an existing one, do that as part of your proposal.

## Files you MUST NOT read

- The pre-fix or post-fix artifact. Your input is the delta, not the raw artifact. Reading the artifact biases you toward fixing this specific case rather than generalizing the rule.
- Any other skill in `.claude/skills/`.

## What to do

1. Read the canonical SKILL.md and the delta.
2. For each delta item:
   - **If it cites an existing rule** in the canonical skill: the rule exists but failed to fire. Diagnose why (rule too buried? language not directive enough? if the skill has a Red Flags list, is the rule absent from it?). Edit the rule to make it more prominent — apply ONE of the three sharpening moves in the **Sharpening playbook** at the bottom of this prompt (move into Red Flags if the skill has such a list and the rule is absent from it; prefix with "STRICT" / "MUST" if the language is soft; add WRONG/RIGHT example if absent).
   - **If it cites a rule in `pm-writing-standards`**: the rule lives in the sub-skill. Decide whether the canonical skill should ALSO carry a Red Flag pointing at it (when the failure is high-frequency in this artifact type) or whether to leave it to the sub-skill. Default: add a Red Flag in the canonical skill if three or more delta items cite the same pm-writing-standards rule.
   - **If it's a new-rule candidate** (delta says `<no documented rule>`): draft a new rule. Pattern-match on existing rules in the canonical skill — same heading style, same WRONG/RIGHT format, same level of specificity. Place it in the most appropriate section.
3. Output the COMPLETE optimized SKILL.md to a draft file. The optimized version must be self-contained — do not output a diff or patch instructions.

## Output

Write the optimized draft to `{{OPTIMIZED_DRAFT_PATH}}` (use the Write tool). The file must be a valid SKILL.md with the same frontmatter `name` and `description` as the canonical version. The one exception: if the description currently summarizes the skill's workflow rather than describing when to use it (the rule from `superpowers:writing-skills` — "description = when to use, not what the skill does"), you may sharpen it. Keep the document structure stable otherwise: do not reorder top-level sections unless the canonical structure is itself a delta-cited problem.

If you propose extracting content into a new sibling reference file (e.g., a new rubric), also write that file. If you propose adding to an existing reference file, edit it via the Edit tool.

## What NOT to do

- Do NOT remove existing rules unless the delta provides evidence they're redundant or wrong. The canonical skill's rules were each added for a reason; preserve them by default.
- Do NOT introduce rules that are not motivated by a delta item. The delta is the spec; everything else is unmotivated change.
- Do NOT change the skill's name or directory.
- Do NOT delete reference files that the canonical skill points at.
- Do NOT introduce em-dashes, weasel words, or other pm-writing-standards violations in the optimized draft. Apply the same rules to your own writing.
- Do NOT write a long preamble. The optimized draft is the deliverable; the regression test will judge it.

## Sharpening playbook (apply ONE per failed-existing-rule delta item)

1. **Move into Red Flags.** If a rule is in the body text but not in the Red Flags list, add a one-line Red Flag entry. Red Flags catch attention better than buried prose.
2. **Prefix with STRICT/MUST.** If the rule's body sentence reads as advisory ("avoid", "prefer", "consider"), rewrite to imperative ("STRICT: do not", "MUST"). Be visible.
3. **Add WRONG/RIGHT example.** If the rule states the principle without an example, append `- WRONG: <text from the delta's "Pre-fix excerpt" line>` and `- RIGHT: <text from the delta's "Post-fix correction" line>`. (You don't have access to the raw artifact — the artifact reads are forbidden in step 2 — so the WRONG/RIGHT text MUST come from the delta entry's quoted excerpts.) Concrete examples close loopholes.

**Pick the move that matches what's missing.** If the rule lives only in body prose, "Move into Red Flags" is the right move. If the rule has a Red Flags entry but the language is advisory, "Prefix with STRICT/MUST" applied to the existing entry is the right move. If the rule has both a Red Flag and directive language but lacks a concrete example, "Add WRONG/RIGHT" is the right move. Each delta item gets ONE move targeting the specific gap; stacking moves on one rule (e.g., adding a Red Flag AND prefixing AND adding an example all at once) is permitted only when the rule is severely under-supported (no Red Flag, soft language, no example all true at the same time).
