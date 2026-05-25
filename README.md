# PM OS — An Opinionated Product Management System for Claude Code

> **Acknowledgements.** This PM OS is a joint collaboration with [Carlos Ruiz](https://www.linkedin.com/in/carlos-ruiz-cardoso/) — Search PM at Wallapop — and me. Some of the skills, sub-agents, and hooks in this repo were built by Carlos; others by me. The system as a whole is the product of months of paired thinking on what a "Personal OS" for product work actually looks like in practice. Where attribution matters per file, individual `SKILL.md` headers note the original author. Thanks Carlos — this exists in the shape it does because of our back-and-forth.

A production-grade Product Management workspace built on [Claude Code](https://docs.claude.com/en/docs/claude-code/overview). 18 skills, 11 slash commands, 5 sub-agents, and 7 lifecycle hooks that turn an LLM into a thinking partner for PRDs, experiments, research synthesis, and strategic writing.

This is the publicly shareable version of a personal system used daily by a Senior Product Manager. It has been genericized — replace `{{COMPANY}}`, `{{TEAM}}`, and other placeholders with your own context, point it at your own Confluence/Jira/Amplitude/Granola/Slack, and it becomes yours.

---

## ⚡ Quick start — skip the manual reading

You don't have to read this README, edit YAML, or run `sed` commands.

```bash
git clone <this-repo-url>
cd pm-os-public
claude
```

Then in the Claude Code prompt, type:

> **`get me started`**

(or `just get me started`, or `help me adapt this OS to my own setup` — any of those work.)

Claude will ask you 4-5 batched questions about your role, company, team, and tools, then customize every skill, hook, template, and config file for your context in about 3 minutes. No manual edits. No CLI knowledge required.

If you'd rather configure it by hand or understand what each piece does first, keep reading below.

---

## Why this exists

Most AI tooling for PMs treats the LLM as a one-shot drafting assistant — paste a brief in, get a PRD out. That output is generic by construction. The wrapper around the LLM (system prompts, conventions, guardrails) is doing none of the work.

This repo is the opposite. The wrapper does most of the work:

- **Skills encode discipline.** Every PRD goes through a kb-grounder sub-agent first, so it's anchored in your real research and strategy docs — not invented. Every metric goes through STEDII-style criteria. Every assumption gets mapped against Teresa Torres' methodology.
- **Hooks enforce house style invisibly.** Em-dashes get flagged, glossary terms get checked, external resources auto-log to a knowledge base, edits to artefacts auto-stage for git review.
- **Sub-agents protect the main context window.** Long Confluence reads, multi-issue Jira queries, Amplitude experiment summaries, and Slack searches happen in sub-agents that return digests — keeping the main thread focused on synthesis.

The system is opinionated. It assumes you write a lot, you ground your work in real evidence, and you'd rather have terse honesty than authoritative-sounding fluff. If you disagree with any of that, fork and edit.

---

## What's inside

### 18 skills (`.claude/skills/`)

Grouped by lifecycle stage:

**Problem framing & discovery**
- `product-discovery-coach` — Socratic coaching for Teresa Torres-style continuous discovery and Opportunity Solution Trees
- `assumption-identifier` — Maps hidden assumptions in a PRD against the user journey; prioritizes by criticality × evidence
- `ur-survey-creator` — Builds a Typeform-ready survey from a research plan to validate assumptions

**Writing artefacts**
- `prd-writer` — Phase-routed PRD authoring (problem framing → solution → metrics → assumptions → AC → flows → GTM). Drafts decisions, not documentation.
- `prd-editor` — Surgical edits to existing PRDs with a mandatory Propose → Execute protocol
- `prd-roaster` — Adversarial critique pass: logical fallacies, weak evidence, technical hallucinations, marketplace traps, recurring blind spots
- `prd-accessibility-requirements` — WCAG 2.2+, ARIA 1.3, iOS/Android accessibility acceptance criteria
- `one-pager-creator` — Lower-complexity version of a PRD for iterations and A/B tests
- `product-vision` — Structured product vision documents
- `pm-writing-standards` — Required sub-skill for any prose artefact. Four Axioms + final-pass checklist. Enforces economy, hierarchy, precision, and active voice.

**Metrics, experiments, post-launch**
- `success-metrics` — Primary, secondary, guardrail, diagnostic metric framework
- `experiment-creator` — Create or fulfil structured Jira Experiment tickets with hypothesis, metrics, and setup
- `post-experiment-report` — Close out experiments: synthesize results, stress-test the launch/rollback narrative, publish to Confluence

**Tickets & operational**
- `jira-ticket-writer` — INVEST-compliant user stories from any feature context
- `bug-ticket-creator` — Structured bug reports with technical accuracy

**Research**
- `research-synthesizer` — Synthesize raw research into Key Learnings reports, leadership summaries, or transcript quality audits

**Planning & meta**
- `planning` — Quarterly / yearly planning + retrospectives
- `prompt-optimizer` — Refine and rewrite prompts using expert prompt engineering principles

### 11 slash commands (`.claude/commands/`)

Shortcuts for high-frequency workflows: `/plan:quarterly-plan`, `/plan:quarterly-retro`, `/research:key-learnings`, `/research:transcript-analysis`, `/meetings:sync-granola`, `/prompt:optimize`, etc.

### 5 sub-agents (`.claude/agents/`)

Each protects the main context window from token-heavy reads:

- `kb-grounder` — Synthesizes grounding context from your knowledge base before drafting any artefact
- `amplitude-summarizer` — Reads experiments, dashboards, notebooks; returns a PM-ready brief
- `jira-bulk-querier` — Multi-issue JQL queries + remote-link traversal; returns themed digests
- `slack-digester` — Channel/DM searches; returns thematic digests with verbatim quotes
- `prd-roaster-runner` — Runs the prd-roaster skill on long PRDs without polluting main context

### 7 lifecycle hooks (`.claude/hooks/`)

- `session-brief.sh` (SessionStart) — Surfaces current quarterly goals, recent commits, recently-touched artefacts
- `prose-sweep.py` (PostToolUse) — Scans .md edits for prose violations (em-dashes, weasel words)
- `auto-stage-pm-edits.sh` (PostToolUse) — Auto-stages artefact edits to git
- `log-external-resource.sh` (PostToolUse) — Appends a stub entry to a knowledge base log whenever an external URL/file is read
- `jira-write-audit.sh` (PreToolUse) — Logs every Jira/Confluence write for end-of-week activity reports
- `precompact-archive.sh` (PreCompact) — Archives full transcripts before context compaction
- `end-of-session-check.sh` (Stop) — Surfaces uncommitted artefacts and unrefined log stubs

### Style discipline (`style-guide/`, `.claude/skills/shared/voice-guide.md`)

- **Voice & Epistemic Honesty Guide** — Universal rules on confidence calibration, no black-box superlatives, separating observation from interpretation. The single most-loaded reference in the system.
- **Performance review style guide** — Universal rules for tonal calibration of HR comms.

---

## What this system is designed to prevent

| Failure mode | How the system prevents it |
|---|---|
| AI invents data, quotes, metrics | `kb-grounder` runs first on every PRD/vision/report and returns verbatim quotes with citations. `pm-writing-standards` blocks invented content explicitly. |
| Authoritative-sounding fluff with no evidence | `voice-guide.md` enforces earned-confidence calibration. `prose-sweep.py` flags weasel words. `prd-roaster` adversarially attacks black-box superlatives. |
| LLM context gets flooded by Confluence/Jira/Amplitude reads | Sub-agents (`kb-grounder`, `amplitude-summarizer`, `jira-bulk-querier`, `slack-digester`) read in isolation and return digests. |
| PM forgets the right artefact for the right initiative | `session-brief.sh` re-injects quarterly goals + recent commits + touched artefacts on every session start. |
| Untracked external sources pollute future analysis | `log-external-resource.sh` auto-stubs every external URL/file read to a knowledge base log. |
| Forget to commit work | `auto-stage-pm-edits.sh` + `end-of-session-check.sh` keep git state visible. |

---

## How to use this repo

### Option A: Guided setup (recommended, no CLI required)

1. Clone the repo and `cd` into it.
2. Open Claude Code in that directory.
3. Type `get me started` (or `just get me started`, or `help me adapt this OS to my own setup`).
4. Answer the questions. Claude runs the customization for you.

The `get-started` skill replaces every placeholder, wires up `.claude/settings.json`, scaffolds the directories the skills expect, and archives skill categories you don't use. Total time: ~3 minutes.

### Option B: Manual setup

1. Fork or clone this repo.
2. Find-and-replace `{{COMPANY}}`, `{{TEAM}}`, `{{JIRA_PROJECT_KEY}}`, `{{CONFLUENCE_SPACE_ID}}`, `{{SPREADSHEET_ID}}` and other bracketed placeholders with your own context.
3. Copy `templates/CLAUDE.md.template` to `./CLAUDE.md` and fill in placeholder values.
4. Copy `templates/settings.json.template` to `.claude/settings.json` and configure your MCP servers.
5. Copy `templates/goals.md.template` to `./goals.md` (lowercase) and fill in your quarterly goals — this file is **gitignored** and should never be committed.
6. Read [SECURITY.md](SECURITY.md) for the list of files that must never be committed.
7. `chmod +x .claude/hooks/*.sh .claude/hooks/*.py`

### Option C: As a reference

If you don't want to fork wholesale, the highest-leverage things to read first:

1. `.claude/skills/shared/voice-guide.md` — Universal writing discipline
2. `.claude/skills/pm-writing-standards/SKILL.md` — Four Axioms for any PM prose
3. `.claude/skills/prd-writer/SKILL.md` — Phase-routed PRD authoring
4. `.claude/agents/kb-grounder.md` — Pattern for context-protecting sub-agents

---

## Setup

### Prerequisites

- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed
- Python 3 (for `prose-sweep.py` hook)
- `jq` (for shell hooks)
- `git`

### MCP integrations (optional, but several skills assume some are present)

| Integration | Used by |
|---|---|
| **Atlassian** (Confluence, Jira) | `prd-writer`, `experiment-creator`, `bug-ticket-creator`, `jira-ticket-writer`, `post-experiment-report`, `kb-grounder`, `jira-bulk-querier`, `prd-roaster-runner` |
| **Google Workspace** (Sheets, Drive, Docs) | `kb-grounder`, `research-synthesizer` |
| **Granola** (meeting notes) | `kb-grounder`, `meetings:sync-granola` |
| **Amplitude** | `post-experiment-report`, `amplitude-summarizer` |
| **Slack** | `slack-digester`, `slack:*` commands |
| **Figma** | `prd-writer` |

Each skill degrades gracefully if its preferred MCP is absent — it falls back to user-pasted context.

### Setup steps

1. Clone into your workspace folder (this becomes your "PM OS" home).
2. Copy `templates/CLAUDE.md.template` to `./CLAUDE.md` at the workspace root and fill in your team's context.
3. Copy `templates/settings.json.template` to `.claude/settings.json` and configure permissions + MCP servers.
4. Create the canonical directories the skills assume: `projects/`, `user-research/`, `meetings/`.
5. Create a `knowledge-base-reference.md` at the workspace root (start with `# Knowledge Base References`) — the log-external-resource hook will auto-populate.
6. Start a Claude Code session in the directory. The session-brief hook will run; verify it doesn't error.

---

## The novel ideas, summarized

If you're skimming this for what's genuinely new vs. what's "yet another PM template":

1. **Phase-routed skills.** A PRD skill isn't one prompt — it's 8 phases that load only when relevant, so the model never holds all 2000 lines at once.
2. **kb-grounder pattern.** Sub-agents that read your knowledge base in isolation and return digests, so the main context never gets flooded by raw Confluence/Jira/Granola/Drive content.
3. **Hooks as enforcement, not just notification.** Em-dash sweeps, auto-stage, auto-log of external resources all run silently and keep the workspace in a sane state.
4. **Voice & Epistemic Honesty Guide.** Treats AI-generated authoritative fluff as a first-class enemy. Rules are concrete: no black-box superlatives without a citation, separate observation from interpretation, earned-confidence calibration.

---

## License

MIT. Use freely, adapt aggressively. Attribution appreciated but not required.

---

## Connect

Built by a Senior Product Manager who got tired of writing the same disciplined PRD review notes over and over and wanted the AI to learn them once.

If you fork this and find something missing or broken, open an issue. If you build something on top of it, I'd love to see it.
