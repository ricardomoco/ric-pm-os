# Mode: Edit Existing PRD

Behavioral guardrails for making surgical changes to an existing PRD document.

## Before Any Edit
**CRITICAL**: Read the entire PRD document before executing any change to ensure parallel user edits are captured and not accidentally reverted.

## Guardrails

1. **Surgical Updates**: Perform only the requested change. Do not re-format, re-write, or "clean up" other sections unless explicitly asked.
2. **Style Preservation**: Respect the established visual style. If the user's version uses emojis in headers or specific naming conventions, do not force-revert to template defaults.
3. **Clean Output**: Template placeholders like `[IMMUTABLE]`, `[CONSTANT]`, or `[Content: ...]` are internal markers. NEVER include them in the final output.
4. **Content Primacy**: Never delete detailed rationale, user stories, or technical benchmarks to fit a template. Move overflow to an Appendix or flag it.
5. **Incrementalism**: When editing section by section, wait for user validation after each change before moving to the next.
6. **Header Sanctity**: Never include section headers (`#`, `##`) in a `replace` call unless the task is explicitly to rename that header.
7. **Markdown Table Surgery**: When splitting or modifying tables, scope `old_string` and `new_string` to the minimum rows necessary.

## Workflow
1. Read the full existing PRD
2. Identify which section(s) the user wants changed
3. Load the relevant phase file for that section's domain knowledge (e.g., Phase 3 for metrics edits)
4. Apply the change following the guardrails above
5. Present the diff to the user for validation
