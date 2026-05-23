# Subagent prompt template — canonical skill

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool. Then dispatch via `subagent_type: general-purpose`.

---

You are running a controlled regression test for a {{COMPANY}} skill optimization. Your task is to apply the **canonical** version of the skill to a draft and produce a structured issue list.

## Files you must read (and only these)

1. `{{SKILL_PATH}}` — the canonical skill you'll apply.
2. `{{PM_WRITING_STANDARDS_PATH}}` — most writing skills mandate this required sub-skill be invoked first; apply both.
3. `{{PRE_FIX_PATH}}` — the draft you're reviewing (current artifact).
4. {{ADDITIONAL_REFERENCES}} — any reference files the canonical skill itself points to (e.g., `cso-review.md` or extracted rubrics). Leave this section empty if there are none.
5. Corpus entries (historical fixtures): {{CORPUS_SAMPLE}}
   For each entry listed, read its prefix file. If `{{CORPUS_SAMPLE}}` is "None.", skip.

## Files you MUST NOT read

- The optimized draft at `{{SKILL_DIR}}/references/SKILL-draft-optimized.md` — you're testing the canonical version, not the draft.
- The post-fix version of the artifact at `{{POST_FIX_PATH}}`. Reading it contaminates the test; it is the answer key.
- The `references/example-*.md` files in the skill directory (structural reference only, not rule source).
- Any other skill in `.claude/skills/` beyond the ones named above.

## What to do

1. Read the files listed above.
2. Apply the canonical skill's review process — whatever named review step the skill defines (e.g., post-experiment-report has a "CSO self-review" step that loads `cso-review.md`; PRD-writer has its own checklist; each skill's step is named in its own SKILL.md). Also apply `pm-writing-standards`'s final-pass checklist. Apply both to the pre-fix draft.
3. Produce a numbered list of issues you would flag for the current artifact. For each:
   - **Quote** the offending text or describe the location precisely (section + paragraph or bullet).
   - **Cite** the rule it violates by source file + rule identifier as documented in that file. Examples (illustrative, not universal): `cso-review.md 2.1: variant scope verification` (when the canonical skill points at an extracted rubric); `pm-writing-standards Axiom 3 ACTION: internal-scaffolding strip` (when the rule lives in the sub-skill); or `<skill-name> SKILL.md "<heading>": <rule>` (when the rule lives inline in the canonical SKILL.md). Use the actual heading and identifier as they appear in the source — do not invent rule numbers.
   - **Recommend** the fix in one sentence.
4. If corpus entries are listed in step 5 above, apply the same review to each corpus entry's prefix file. Output a `## Corpus: <slug>` section for each, with its numbered issue list in the same format. If a corpus prefix has no issues found, write `No issues found.`

## What NOT to do

- Do NOT generate or rewrite the artifact.
- Do NOT speculate about what the human reviewer "probably did" — flag only what the skill rules say to flag.
- Do NOT skip issues because they look minor — be exhaustive within the skill's rules.

## Output format

The numbered issue list for the current pre-fix first, then a `## Corpus: <slug>` section for each corpus entry reviewed. Omit corpus sections entirely if `{{CORPUS_SAMPLE}}` is "None."
