# Why each onboarding question exists

Notes for skill authors and contributors who want to extend the `get-started` flow. End users don't need to read this.

## Step 2 — Identity batch

### Role
Affects the default seniority calibration for `pm-writing-standards` and any skill that surfaces "appropriate for level" advice. A senior PM defaults to terser, more strategic prompts; an APM defaults to scaffolded, more explanatory ones.

### Domain
Affects example framing across all skills. A marketplace PM sees "buyer / seller" examples; a SaaS PM sees "user / admin"; an internal platform PM sees "consumer team / platform team". The OS is genericized but examples calibrate.

### Team size
Affects `kb-grounder` defaults (one squad → searches one team space; multi-squad tribe → searches across sibling spaces) and `session-brief.sh` (solo PM → minimal brief; large tribe → richer cross-team activity surface).

### Writing style
Affects `pm-writing-standards` axiom calibration. "Terse and blunt" enforces all four Axioms aggressively. "Balanced" relaxes the paragraph-length and one-idea-per-sentence rules. "Detailed" tolerates longer explanatory passages.

## Step 3 — Naming (free-text)

These replace every `{{COMPANY}}`, `{{TEAM}}`, `{{PRODUCT}}`, `{{ATLASSIAN_BASE_URL}}`, `{{JIRA_PROJECT_KEY}}`, `{{CONFLUENCE_SPACE_KEY}}` placeholder across the OS. They are the most operationally important values — without them, skills that publish to Confluence or open Jira tickets fail.

If the user says "skip" for Atlassian, those placeholders remain — and skills that require Atlassian degrade gracefully (they show "Configure your Atlassian settings before using this skill" instead of running).

## Step 4 — Integrations (multi-select)

Used to trim `.claude/settings.json` to only the MCP servers the user actually uses. Removes permission grants the user doesn't need (smaller blast radius for accidental tool calls) and reduces the prompt noise from skills that gate behaviour on MCP availability.

## Step 5 — Skill categories (multi-select)

Used to archive unused skill folders into `.claude/skills/_archived/`. Archived skills don't appear in the Claude Code skill picker, reducing cognitive load. They can be restored at any time by moving the folder back.

**Always kept regardless of category selection:**
- `get-started` (this skill — needed for re-running setup)
- `shared` (voice guide, atlassian config)
- `pm-writing-standards` (mandatory sub-skill for any prose)
- `assumption-identifier`, `success-metrics`, `product-discovery-coach`, `prompt-optimizer` (universally useful)

## Step 6 — Goals paste

Optional. If the user pastes goals, the skill structures them into `goals.md` (lowercase). The file is `.gitignore`d — never commits.

The structuring should:
- Extract goal statements
- Identify metrics where mentioned
- Identify targets where mentioned
- Identify horizons where mentioned
- Anything that looks like a real person's name → replace with `[role]`
- Anything that looks like a specific Jira key → replace with `[TICKET]`

Show the user the structured output before saving. Don't save without confirmation.
