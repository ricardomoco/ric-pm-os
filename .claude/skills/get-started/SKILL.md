---
name: get-started
description: One-shot onboarding for first-time users of this PM OS. Asks 4-6 batched questions about role, company, team, tools, and domain, then customizes every skill, hook, template, and config file to the user's context. ALWAYS use this skill when the user says "get me started", "just get me started", "help me adapt this OS", "set this up for me", "configure this for my context", "I just cloned this — what now", "make this mine", or any variant phrased as wanting the OS adapted to their setup. Designed for non-technical PMs who don't want to hand-edit YAML or sed commands.
---

# Get Started — One-Shot OS Customization

You are onboarding a new user to this PM OS. They cloned the repo and want it customized for their role, company, and tools without hand-editing files.

## Operating principles

- **Conversational.** No jargon. They may not know what MCP, JQL, or YAML is.
- **Batched questions.** Group related questions into single `AskUserQuestion` calls. Never ask one question at a time when four fit together.
- **Reasonable defaults.** Every question must have a recommended option (label ends with " (Recommended)"). Default behaviour is to pick that one if the user is uncertain.
- **Explain what changes.** After each question batch, say in one sentence what their answers will change in the OS.
- **Don't ask what you can detect.** Before asking about MCP integrations, glob `.mcp.json` or `templates/settings.json.template` to see what's already configured. Before asking about role, check if `goals.md` already exists.
- **Never invent values.** If the user says "skip" or "I'll fill it in later", leave the placeholder as `{{PLACEHOLDER}}` — do NOT substitute a guess.

## Flow

### Step 0 — Preflight (silent)

Before talking to the user, verify the workspace state:

```bash
ls -la                                          # is this a cloned repo?
test -f .claude/skills/get-started/SKILL.md     # are we in the right dir?
test -f goals.md && echo "goals_exists"         # already set up?
test -f .claude/settings.json && echo "configured"
```

If `goals.md` and `.claude/settings.json` already exist (filled with real values, not template placeholders), the user has already run setup. Ask whether they want to **re-run setup** (overwrite), **add a missing piece** (target one section), or **exit**.

### Step 1 — Greet and state the plan

One short message:

> Welcome. I'll ask you 4-5 quick batched questions about your role, company, and tools, then customize every skill, hook, and template in this repo for you. Takes about 3 minutes. You can skip any question.

### Step 2 — Identity (one AskUserQuestion with 4 sub-questions)

Ask in a single `AskUserQuestion` call:

1. **Role** (header: "Role") — options: `Senior PM (Recommended)`, `Product Manager`, `Group PM / Lead`, `Associate PM`.
2. **Domain** (header: "Domain") — options: `Marketplace / two-sided platform (Recommended)`, `B2B SaaS`, `Consumer app`, `Internal tooling / platform`. *Affects which skill examples use marketplace-vs-SaaS framing.*
3. **Team size** (header: "Team") — options: `Single squad (Recommended)`, `Multi-squad tribe`, `Cross-functional unit`, `Solo PM`. *Affects whether agents reference tribe-wide vs squad-wide knowledge bases.*
4. **Writing style preference** (header: "Style") — options: `Terse and blunt (Recommended)`, `Balanced with context`, `Detailed and exhaustive`. *Calibrates the voice guide.*

### Step 3 — Company and team naming

Free-text input. Use a single regular message asking the user to provide, in one reply:

```
- Company name (e.g. "Acme Inc"):
- Team / tribe name (e.g. "Search Discovery"):
- Product codename (the thing you're building, e.g. "Acme Marketplace"):
- Atlassian base URL (if you use Jira/Confluence, e.g. "https://acme.atlassian.net"; otherwise "skip"):
- Primary Jira project key (e.g. "ACM"; otherwise "skip"):
- Confluence space key for your team (e.g. "ACM"; otherwise "skip"):
```

If the user says "skip" for the Atlassian fields, leave those placeholders intact.

### Step 4 — Tools and integrations (one AskUserQuestion, multiSelect)

Question (header: "Integrations", `multiSelect: true`):

> Which of these do you actually use today? I'll trim the skills and settings to match.

Options:

- `Atlassian — Confluence + Jira (Recommended)`
- `Granola or another meeting-notes tool`
- `Amplitude or another product analytics platform`
- `Slack`
- `Google Workspace — Docs, Sheets, Drive`
- `Figma`

For unchecked tools: the customization should remove or comment-out the corresponding MCP entries in `settings.json` and downgrade the dependent skill descriptions ("Reads from <tool>" → "Reads from your knowledge base, or paste content directly").

### Step 5 — Skill categories (one AskUserQuestion, multiSelect)

Question (header: "Skill set", `multiSelect: true`):

> Which categories of work do you do most? Skills you don't use can stay — they don't slow anything down — but I can prune them if you want a leaner setup.

Options:

- `Writing artefacts — PRDs, RFCs, one-pagers, vision docs (Recommended)`
- `Experiments — pre-experiment setup, post-experiment reports`
- `Research — survey design, transcript synthesis, key learnings`
- `People / comms — feedback memos, culture interviews`
- `Planning — quarterly plans, retros`
- `Tickets / operational — Jira tickets, bug tickets`

If the user un-checks a category, mark the relevant skills for archival (move to `.claude/skills/_archived/`) so they can be restored later, rather than deleting.

### Step 6 — Optional: paste current quarterly goals

A single regular message:

> If you want me to scaffold `goals.md` with your current quarterly goals, paste them now (any format — bullets, prose, raw notes). Otherwise reply "skip" and I'll create an empty template.

If the user pastes content, structure it into the `templates/goals.md.template` shape and write to `goals.md`. Strip anything that looks like a person's name (replace with `[role]`) or a specific Jira ID. Always show the user what you wrote before saving.

### Step 7 — Apply everything

Run the customization. This is the only step where you write files in bulk. Use the `scripts/apply-customization.sh` script as the executor — it takes env vars and runs the find-replaces atomically. Set:

```bash
export PM_OS_COMPANY="<answer from Step 3>"
export PM_OS_TEAM="<answer from Step 3>"
export PM_OS_PRODUCT="<answer from Step 3>"
export PM_OS_ATLASSIAN_BASE="<answer from Step 3 or empty>"
export PM_OS_JIRA_KEY="<answer from Step 3 or empty>"
export PM_OS_CONFLUENCE_KEY="<answer from Step 3 or empty>"
export PM_OS_ROLE="<Step 2 role>"
export PM_OS_DOMAIN="<Step 2 domain>"
export PM_OS_STYLE="<Step 2 style>"
export PM_OS_INTEGRATIONS="<Step 4 comma-separated>"
export PM_OS_SKILL_CATEGORIES="<Step 5 comma-separated>"

bash .claude/skills/get-started/scripts/apply-customization.sh
```

The script:

1. Replaces every `{{COMPANY}}`, `{{TEAM}}`, `{{PRODUCT}}`, `{{ATLASSIAN_BASE_URL}}`, `{{JIRA_PROJECT_KEY}}`, `{{CONFLUENCE_SPACE_KEY}}` placeholder across all `.md`, `.sh`, `.py`, `.json` files (excluding `templates/`, `node_modules/`, `.git/`).
2. Copies `templates/CLAUDE.md.template` → `CLAUDE.md` at workspace root.
3. Copies `templates/settings.json.template` → `.claude/settings.json` and removes MCP server blocks for un-selected integrations.
4. Creates the directories the skills expect: `projects/`, `meetings/`, `research/`.
5. Creates an empty `knowledge-base-reference.md` with a single-line header.
6. Marks all hooks executable: `chmod +x .claude/hooks/*.sh .claude/hooks/*.py`.
7. Moves un-selected skill categories into `.claude/skills/_archived/` (if any were unchecked in Step 5).
8. Prints a summary of every file touched.

### Step 8 — Confirmation and what's next

After the script completes, show:

```
Setup complete.

Files customized:    N files
Skills active:       M skills (X archived)
MCP servers wired:   K
Hooks armed:         9 hooks executable

Try these next:

  1. Start a new Claude Code session in this directory.
  2. The session-brief hook will surface your goals.md and recent activity.
  3. Try a skill: type "draft a PRD for <a feature you're working on>" and the prd-writer should kick in.
  4. When you're ready to share artefacts with your team, push goals.md ONLY to a private branch — it's gitignored on this branch for safety.

Re-run this skill any time by typing "get me started" again.
```

## What this skill must NOT do

- **Never push to git** without explicit user confirmation. Run `git status` and show what would be committed; let the user decide.
- **Never set up MCP server credentials** — those go in `.env`, not in any file Claude writes.
- **Never assume a value** the user didn't provide. Empty placeholder > guessed value.
- **Never customize `templates/`** — those files stay as templates so the user can re-run setup if they re-clone.
- **Never delete files** — only move to `_archived/` so the user can restore.

## If the user gets stuck mid-flow

If they abandon mid-flow (give one answer, then go quiet), do NOT proceed with partial state. Acknowledge the answers you have, ask if they want to continue or pause. Do not write files until you have at least: company name, team name, and a yes/no on whether Atlassian is in use.

## Re-running setup

If the user runs this skill a second time, do not re-ask questions they've already answered (the answers live in `CLAUDE.md` if the first run completed). Detect that state and ask: "I see you already ran setup. Do you want to (a) change one specific value, (b) wipe and re-run from scratch, or (c) check current state?"
