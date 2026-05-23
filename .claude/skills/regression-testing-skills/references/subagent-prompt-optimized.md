# Subagent prompt template — optimized skill draft

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool. Then dispatch via `subagent_type: general-purpose`.

---

You are running a controlled regression test for a {{COMPANY}} skill optimization. Your task is to apply the **optimized** version of the skill to a draft and produce a structured issue list. Treat the optimized draft as if it were the canonical SKILL.md.

## Files you must read (and only these)

1. `{{OPTIMIZED_DRAFT_PATH}}` — the optimized skill draft you'll apply (this is NOT the canonical SKILL.md).
2. {{ADDITIONAL_REFERENCES}} — any reference files the optimized draft introduces or relies on (e.g., a newly-extracted `cso-review.md`, checklist files). Leave empty if there are none.
3. `{{PM_WRITING_STANDARDS_PATH}}` — most writing skills mandate this required sub-skill be invoked first; apply both.
4. `{{PRE_FIX_PATH}}` — the draft you're reviewing (current artifact).
5. Corpus entries (historical fixtures): {{CORPUS_SAMPLE}}
   For each entry listed, read its prefix file. If `{{CORPUS_SAMPLE}}` is "None.", skip.

## Files you MUST NOT read

- The canonical `{{SKILL_PATH}}`. You're testing the optimized draft, not the canonical version. Apply only the optimized draft.
- The post-fix version of the artifact at `{{POST_FIX_PATH}}`. Reading it contaminates the test; it is the answer key.
- The `references/example-*.md` files in the skill directory (structural reference only, not rule source).
- Any other skill in `.claude/skills/` beyond the ones named above.

## What to do

1. Read the files listed above.
2. Apply EVERY rule the optimized skill draft documents: the named review step (each skill names its own — e.g., "CSO self-review" in post-experiment-report; check the draft's table of contents to find it), the structural rules in the body of SKILL.md (whatever sections the draft uses to enumerate rules — read the headings to identify them, do not assume specific section names), the Red Flags list if present, and any rules in the additional reference files. Also apply `pm-writing-standards`'s final-pass checklist. Apply all of these to the pre-fix draft.
3. Produce a numbered list of issues you would flag for the current artifact. For each:
   - **Quote** the offending text or describe the location precisely (section + paragraph or bullet).
   - **Cite** the rule it violates by source file + rule identifier as documented in the file. Examples (illustrative, not universal): `cso-review.md 2.1: variant scope verification`; `SKILL-draft-optimized.md Red Flags: <rule>`; `SKILL-draft-optimized.md "<heading>": <rule>`; `pm-writing-standards Axiom 3 ACTION: internal-scaffolding strip`. Use the actual heading and identifier from the source — do not invent rule numbers.
   - **Recommend** the fix in one sentence.
4. If corpus entries are listed in step 5 above, apply the same review to each corpus entry's prefix file using the optimized draft. Output a `## Corpus: <slug>` section for each, with its numbered issue list in the same format. If a corpus prefix has no issues found, write `No issues found.`

## What NOT to do

- Do NOT generate or rewrite the artifact.
- Do NOT speculate about what the human reviewer "probably did" — flag only what the skill rules say to flag.
- Do NOT skip issues because they look minor — be exhaustive within the skill's rules.

## Output format

The numbered issue list for the current pre-fix first, then a `## Corpus: <slug>` section for each corpus entry reviewed. Omit corpus sections entirely if `{{CORPUS_SAMPLE}}` is "None."
