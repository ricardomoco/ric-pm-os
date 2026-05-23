# Subagent prompt template — skill auditor

Substitute the `{{...}}` placeholders with absolute paths before passing to the Agent tool.

**Dispatch:** `subagent_type: general-purpose`, `model: sonnet`. May also run inline in the parent agent's context (no separate Agent call) when the parent has the audit and SKILL.md in scope already — the inline path is cheaper and the analysis is contained.

This subagent reads a bash structural audit + the canonical SKILL.md, then returns a compression strategy: which sections to collapse, which examples are redundant, which Quick-Reference / pointer-style entries lack a body, and what the target word count should be. The output drives the skill-compressor.

---

You are auditing a {{COMPANY}} skill for compression opportunities. The skill has accreted rules over time and is now showing bloat (duplicate explanations across sections, multiple examples for the same failure mode, pointer-style entries without bodies). Your job is to identify what to compress and how, then hand the strategy to the compressor.

## Files you must read (and only these)

1. `{{SKILL_PATH}}` — the canonical SKILL.md you're analysing.
2. `{{AUDIT_PATH}}` — structural audit produced by `scripts/audit-skill.sh`. Word counts, section sizes, example-block counts, repeated content. The mechanical signals; you do the semantic analysis on top.
3. `{{TARGET_WORD_COUNT}}` — the bash audit's heuristic floor (40-60% of current). You may set the actual target lower or higher in your strategy if the skill's structure justifies it.

## Files you MUST NOT read

- The corpus prefixes or deltas at `{{SKILL_DIR}}/regression-corpus/`. Reading them biases the strategy toward what specific past failures looked like; the strategy must generalise. The regression test in a later phase will catch any compression that loses fidelity on those failures.
- Other skills in `.claude/skills/`.

## What to do

1. Read the audit. Note: the largest sections, the highest example-density sections, the most repeated lines, the largest section-size ratio.
2. Read the SKILL.md. Look for the patterns the audit flagged, plus the patterns it cannot detect:
   - **Cross-section restatement.** A rule appears in section A and again, in different words, in section B. Common shape: a "Cross-cutting rules" or "Quick reference" list AND a body Axiom/section that both state the same rule.
   - **Pointer-without-body.** A list entry that points at another section ("see Axiom 2") but the target section has no corresponding ACTION. The pointer is a structural orphan.
   - **Sub-pattern proliferation.** A single underlying principle is expressed as 3+ named sub-patterns (e.g., "scope-establishing opener", "operating-model meta-commentary", "cross-item preview" all of which are flavours of "TL;DR redundancy"). The umbrella principle should be one rule with sub-pattern examples; the sub-patterns themselves should not be top-level rules.
   - **Multi-example redundancy.** A rule with 2+ WRONG/RIGHT pairs that illustrate the SAME failure mode in different domains. One canonical pair carries the rule; extras can move to a references/ catalog if genuinely useful, otherwise delete.
   - **Final-pass checklist mirroring.** A "final pass" / "checklist" section that re-states each rule's body verbatim. The checklist should be a 1-line-per-rule scan, not a restatement.
3. For each pattern you find, note the SKILL.md location (section heading + line range) and the proposed compression move (collapse / merge / delete / move to references).

## Output format

Write a compression strategy as markdown. The structure:

```
# Compression strategy for <skill-name>

## Target

- Current word count: <X> words
- Target word count: <Y> words (<Z>% reduction)
- Rationale: <one sentence on why this target is achievable>

## Identified compression moves

### Move 1: <short title>
- **Pattern:** <one of: cross-section-restatement | pointer-without-body | sub-pattern-proliferation | multi-example-redundancy | final-pass-mirroring | other>
- **Locations:** <SKILL.md heading(s) + line range(s)>
- **Action:** <collapse into one canonical location | merge sub-patterns into umbrella rule | delete extra examples | rewrite final-pass to 1-line scans | other>
- **Risk to fidelity:** <none | low | medium — explain if medium>

[... per identified move ...]

## Rules NOT to compress

List any rules whose bloat is load-bearing (e.g., a sub-pattern that the regression corpus has historically tested as a distinct category). The compressor will preserve these even if they look like compression candidates.

## Single-source rule

Confirm: every kept rule will live in exactly one canonical location after compression. If a rule appears in multiple sections in the current skill, name the section that becomes the canonical home.
```

## What NOT to do

- Do NOT propose adding new rules. Compression is reorganisation and reduction; new rules come from the `/regression-testing-skills:learn` loop.
- Do NOT propose removing rules whose presence is justified by a past corpus entry. If you cannot tell whether a rule is corpus-justified, mark it as "preserve until regression test confirms".
- Do NOT write the compressed draft yourself — that is the compressor's job and is a separate prompt for a more capable model.
- Do NOT exceed the SKILL.md's existing top-level structure unless the structure itself is a compression candidate. If sections are reasonably named and the bloat is within sections, leave the structure alone.
- Do NOT propose edits to the frontmatter `name` or `description` unless one is itself a delta — the regression-testing protocol's integration with PostToolUse hooks depends on stable names.
