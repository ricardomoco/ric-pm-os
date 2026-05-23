# Contributing

This repo is a public scaffold for an opinionated PM workflow on Claude Code. Contributions are welcome — especially new skills that encode discipline other PMs would benefit from, or fixes to genericization gaps the maintainer missed.

## Ways to contribute

### Open an issue

- A skill is broken or makes a bad assumption — file an issue with the skill name, the input that produced the bad output, and what you expected.
- A genericization gap — you spotted a residual `{{COMPANY}}` reference, a hardcoded ID, or a real name. File and I'll patch.
- A workflow idea — describe the PM task and the recurring failure mode you'd want a skill to encode.

### Submit a pull request

- **New skill:** add under `.claude/skills/<skill-name>/SKILL.md`. Follow the structure of an existing skill (frontmatter with `name:` and `description:`, a clear `## When to use` section, phase or routing logic if it's complex).
- **New hook:** add under `.claude/hooks/<name>.sh` or `.py`. Make it best-effort (always exit 0; never block tool calls). Document the matcher in the file header.
- **New sub-agent:** add under `.claude/agents/<name>.md` with frontmatter (`name`, `description`, `tools`, `model`, `color`). Sub-agents are for protecting main context — they should return digests, not raw data.
- **Improvement to an existing skill:** make sure your change does not regress the skill's other outputs. The `regression-testing-skills` meta-skill exists precisely for this; ideally add a fixture under `regression-corpus/` (anonymized).

## Sanitization rules

This is a public repo. Every contribution must:

1. **No real company names.** Use `{{COMPANY}}`, `{{TEAM}}`, or generic terms.
2. **No real person names.** Use `[Designer]`, `[Tech Lead]`, etc., or illustrative placeholder names like `Alex`, `Sam`, `Jordan`.
3. **No real IDs.** Confluence space/page IDs, Jira project keys, Google Spreadsheet IDs — use `{{CONFLUENCE_SPACE_ID}}`, `{{JIRA_PROJECT_KEY}}`, `{{SPREADSHEET_ID}}`.
4. **No real URLs.** Use placeholder hosts.
5. **No real metrics.** If you cite a number in an example, mark it as synthetic.

Run this grep before submitting:

```bash
grep -rE "<your-company>|<your-team>|<your-product-codename>" .
```

## Style

Documentation in this repo follows the same Voice & Epistemic Honesty rules the skills themselves enforce. In particular:

- No "AI slop" prose. Be direct.
- Earned confidence: assertion strength matches evidence.
- Active voice. Concrete nouns.
- No black-box superlatives ("the most critical", "the single biggest") without a citation.

See `.claude/skills/shared/voice-guide.md`.

## Development loop

1. Clone the repo. Run `chmod +x .claude/hooks/*.sh`.
2. Copy `templates/CLAUDE.md.template` to `CLAUDE.md` and fill in placeholder values for your environment.
3. Copy `templates/settings.json.template` to `.claude/settings.json` and configure MCP servers.
4. Open the repo in Claude Code. The session-brief hook should run on session start. Verify with `/help` that skills are listed.
5. Try one skill end-to-end before contributing changes.
