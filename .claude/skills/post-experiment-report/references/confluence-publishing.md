# Confluence Publishing — Post-Experiment Reports

Where the post-launch report lives in Confluence, and how to get it there. Configure your team's space and initiative parent pages in `.claude/skills/shared/atlassian-config.md` first.

## Space

- **Space name:** `{{TEAM_SPACE_NAME}}`
- **Space key:** `{{CONFLUENCE_SPACE_KEY}}`
- **Space URL:** `{{ATLASSIAN_BASE_URL}}/wiki/spaces/{{CONFLUENCE_SPACE_KEY}}/`

## Where reports should live

Each post-launch report is a child of the initiative / PRD page that drove the experiment. This keeps the evaluation narrative with the strategic brief, and avoids a flat "results dump" folder.

### Pattern

```
Team space ({{CONFLUENCE_SPACE_KEY}})
└── Pillar page
    └── Initiative / PRD page
        └── [Experiment Results] <feature> — <decision>    ← the report
```

If multiple experiments run against the same initiative, they sit as siblings under the same parent — one page per experiment, never one merged page.

## How to find the right parent page

1. From the experiment ticket, read `parent.key` (the Epic) and `parent.parent` (the Initiative if set).
2. Fetch the Epic with `getJiraIssue` and look at its description for a Confluence URL.
3. If the Epic has a remote link to a Confluence page (common pattern), use that as the parent.
4. If no linked page exists, search Confluence:
   ```
   mcp__atlassian__searchConfluenceUsingCql
   - cloudId: {{ATLASSIAN_DOMAIN}}
   - cql: space = {{CONFLUENCE_SPACE_KEY}} AND type = page AND title ~ "<initiative keyword>"
   ```
5. Present the candidate parent page to the user and confirm before creating.

## Creating the report page

```
mcp__atlassian__createConfluencePage
- cloudId: {{ATLASSIAN_DOMAIN}}
- spaceId: {{CONFLUENCE_SPACE_ID}}    # verify via getConfluenceSpaces if unsure
- parentId: <initiative page ID>
- parentType: page
- title: "[Experiment Results] <feature name> — <decision>"
- contentFormat: markdown
- body: <markdown body from the report-template.md>
```

**Title examples:**
- `[Experiment Results] Quick Filter MVP — Launch (Option B)`
- `[Experiment Results] Recommendation Slider on PDP — Launch`
- `[Experiment Results] Reserved-items hiding in search — Rollback`

## After creation

1. Log the page URL to `knowledge-base-reference.md` (read → append → write → verify, per CLAUDE.md).
2. Link the Confluence page from the Jira Experiment ticket's description (add a "Results report" line under Readouts / artifacts).
3. Include the Confluence URL in the `customfield_{{CUSTOM_FIELD_ID}}` (Results) ADF textarea so the Jira-native view cross-references the long-form write-up.

## What NOT to do

- Do NOT publish in personal space or "Drafts" — reports outside the team space are invisible to peers.
- Do NOT merge multiple experiments into one page — one experiment, one page.
- Do NOT overwrite an existing results page silently. If a page with the same title exists, fetch it, compare content, and ask the user whether to version, supersede, or append.
- Do NOT set the page to "restricted" visibility — post-launch reports should be readable across the org by convention.
