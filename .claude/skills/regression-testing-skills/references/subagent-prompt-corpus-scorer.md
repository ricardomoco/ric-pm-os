# Subagent prompt template — corpus scorer (the workhorse)

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool.

**Dispatch:** `subagent_type: general-purpose`, `model: sonnet`. Pattern-matched grading against explicit delta excerpts — Sonnet handles this cleanly. Do not use Opus here; the volume of these calls (2 to 6 per compress run, sometimes more if iterating) makes model choice load-bearing for cost.

This is the workhorse of the compression test. ONE subagent invocation per (condition, trial) pair: each subagent reads ONE skill version + ALL fixtures in the corpus, scores each fixture against its `delta.md` directly, and writes one `scoring.md` per fixture. The structure intentionally avoids producing verbose per-fixture violations.md files — direct delta-scoring is the cheaper path that the compress mode chose over the `/regression-testing-skills:learn` protocol's two-step (canonical/optimized → score).

---

You are running the corpus-scoring half of a skill-compression A/B test. You have ONE skill version and an array of fixtures. For each fixture, you apply the skill to the prefix and score whether the skill catches the violations the user actually fixed (the delta).

Each subagent only ever sees ONE skill version. This isolation is intentional: it removes anchoring bias from the comparison. Do NOT read the other condition's skill or other condition's outputs.

## Files you must read (and only these)

1. `{{SKILL_PATH}}` — the ONE skill version you are testing this run. Either the snapshot baseline OR the compressed candidate; never both.
2. `{{PM_WRITING_STANDARDS_PATH}}` — the required sub-skill that most writing skills mandate; apply both the named skill and pm-writing-standards. (Skip this line if the skill being tested IS pm-writing-standards itself.)
3. {{ADDITIONAL_REFERENCES}} — reference files the canonical skill points at. Leave empty if there are none.
4. The fixtures listed below. For each fixture, read its `prefix.md` and its `delta.md`.

## Fixtures to score

{{FIXTURE_LIST}}

Each entry is shaped: `<fixture-name> <prefix-path> <delta-path> <output-path>`. Read prefix and delta; write scoring.md to output-path.

## Files you MUST NOT read

- Any OTHER skill version. If you were given the snapshot baseline, do not read the compressed draft, and vice versa. Do not search for or read any SKILL.md not listed in step 1.
- Any other condition's `scoring.md` or any iteration-2 output. The first read of the prefix must not be primed by a sibling subagent's verdict.
- The corpus's `postfix.md` if one exists. The delta excerpts are the answer key in the appropriate granularity; the post-fix is over-detailed and would bias the scoring.
- The compress-mode workspace directories beyond `{{OUTPUT_BASE_PATH}}`. Reading the parent's audit or aggregate is allowed only if explicitly listed here.

## What to do

For each fixture in the list:

1. Read the prefix.md (the artifact in the state the user fixed FROM).
2. Read the delta.md. The delta is a numbered list D1, D2, ..., Dn. Each entry has a pre-fix excerpt, a post-fix correction, and the rule it violates.
3. Apply the skill to the prefix. Mentally simulate: "if I were applying this skill rigorously to this prefix, would I flag the issue described in D<i>?"
4. For each delta D<i>, decide:
   - **caught** — the skill, as written, contains a rule that would clearly fire on the pre-fix excerpt. The rule's wording does not need to be identical to the delta's rule citation; semantic equivalence is enough. You can quote the rule's heading or first line as evidence.
   - **partial** — the skill contains a rule that would fire on a closely-related issue but does not cover the specific failure pattern the user fixed. Example: "Active voice" rule fires on the same sentence, but the user's fix was specifically the geographic-scope qualifier (Spain) and the active-voice rule does not enforce scope. Mark the half-catch.
   - **missed** — the skill has no rule that would fire on this excerpt at all. The skill is missing the rule, or has it in a form too soft / too buried to fire.
5. Write `scoring.md` to the output path for that fixture in the schema below.

## Output schema (one scoring.md per fixture)

Strict schema — the aggregator script parses this:

```
# Scoring: <fixture-name>

Skill version applied: <baseline | compressed>

## D1: <delta description, copied verbatim from delta.md>
- Verdict: caught | partial | missed
- Evidence: <which rule from the skill fires (quote heading or first line); OR "no rule covers this" if missed; OR for partial, name the closest rule and the specific gap>

## D2: <...>
- Verdict: ...
- Evidence: ...

[... per delta ...]

## Summary
| Caught | Partial | Missed |
|--------|---------|--------|
| X/N    | Y/N     | Z/N    |
```

X + Y + Z = N. The numerator (X, Y, Z) is the count for that verdict; the denominator (N) is the total number of deltas in the fixture's delta.md. The aggregator script depends on the literal `X/N` form — do not deviate.

## What NOT to do

- Do NOT generate a free-form list of violations beyond the deltas. The compression test only cares about the deltas the user actually fixed; novel violations the skill might catch are outside the test's scope.
- Do NOT mark a delta as caught unless you can name the specific rule. "I think the skill would catch this" without a rule reference is a partial at best.
- Do NOT cite rules from a skill version you weren't given. If the rule must be in `{{SKILL_PATH}}`; if it's in pm-writing-standards, name that source explicitly.
- Do NOT skip a delta. If the delta is unclear, mark it `partial` and explain in the Evidence line; the aggregator and the diagnoser will read your evidence.
- Do NOT write more than one scoring.md per fixture. Overwrite any existing scoring.md at the output path.
- Do NOT include the `<` or `>` in your output — those are placeholder markers in this prompt template.
