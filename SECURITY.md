# Security and privacy

This repo is a **public scaffold**. It is intentionally generic. If you fork it and run it against your real team's context, several files will accumulate sensitive content. They are gitignored — keep them that way.

## Files that must never be committed in your fork

| File / folder | Why it's sensitive |
|---|---|
| `goals.md` (or `GOALS.md`) | Quarterly priorities, ownership, stakeholder mapping |
| `projects/` | Active in-flight work — drafts, research, decisions in progress |
| `meetings/` | Synced meeting notes (Granola / equivalent) — verbatim quotes, decisions, names |
| `research/` and `user-research/` | Interview transcripts, recruited participant data |
| `knowledge-base-reference.md` | Auto-populated log of every external resource read in a session — includes private Confluence/Drive/Jira URLs |
| `.env`, `.env.local` | API keys, MCP tokens |
| `.claude/settings.local.json` | Per-PM permission overrides |
| `.claude/cache/`, `.claude/audit/`, `.claude/transcript-archive/`, `.claude/agent-memory/` | Runtime caches and audit logs containing prompt+response history |
| `.claude/skills/*/regression-corpus/` | Anonymized fixtures may still contain product details — review before publishing any |

All of these are blocked by the `.gitignore` shipped with the repo. Verify before pushing:

```bash
git check-ignore -v goals.md projects/ meetings/ .env .claude/cache/
```

## Best practices when sharing your fork

1. **Don't sync** sensitive folders into the public fork. Keep your real workspace separate.
2. **Redact placeholder values** with non-existent characters (e.g. `█████`, `***`, `▓▓▓`) if you must include an example that touches a sensitive surface.
3. **Strip example artefacts** of cohort sizes, p-values, real metric baselines, and named stakeholders before publishing them as skill references.
4. **Audit before push:**
   ```bash
   grep -rE "<your-company>|<team-codename>|<product-codename>|@<your-domain>" .
   ```
   Replace `<your-company>`, `<team-codename>`, etc. with your actual identifiers. Zero matches before `git push`.
5. **Run the `get-started` skill** on a fresh clone if you've been using the workspace heavily. It replaces all `{{COMPANY}}` / `{{TEAM}}` placeholders with your context cleanly, without you having to hand-edit each file.

## If you find a leak in this repo

Open an issue with the file path and line number. Do not include the leaked content in the issue itself.
