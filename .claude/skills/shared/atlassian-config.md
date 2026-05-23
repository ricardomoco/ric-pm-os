# Atlassian Configuration

Replace all placeholders below with values from your own Atlassian Cloud instance before using the publishing skills (`post-experiment-report`, `prd-writer`, etc.).

## Jira Defaults

- **Cloud ID / Base URL**: `{{ATLASSIAN_BASE_URL}}`
- **Primary Project Key**: `{{JIRA_PROJECT_KEY}}`

## Confluence Spaces

List the Confluence spaces your skills publish into. Look up the `spaceId` via `getConfluenceSpaces`:

| Space name | spaceId |
|---|---|
| {{TEAM_SPACE_NAME}} | `{{CONFLUENCE_SPACE_ID}}` |

## Publishing Guide (template)

This is the template shape your team's publishing guide should fill in. The full version was stripped during sanitization — see the section below for what to populate.

### Space Structure

Map your team's Confluence tree. A typical pattern:

```
{{TEAM_SPACE_NAME}} Home ({{CONFLUENCE_PAGE_ID}})
├── Product Vision & Strategy
├── Quarterly Roadmaps
├── Strategic Pillars
│   ├── Pillar A — <name>
│   ├── Pillar B — <name>
│   └── Pillar C — <name>
├── Ways of Working
├── Metrics & Goals
└── Archived
```

### Where to Publish by Document Type

| Document type | Default parent | Rationale |
|---|---|---|
| **PRD** | Initiative folder under its Strategic Pillar | Keeps the PRD next to research and GTM artefacts for that initiative |
| **Vision document** | Pillar page or top-level Vision & Strategy | Pillar-scoped vs cross-pillar |
| **Research / User testing** | Initiative folder → `Research/` subpage | Co-located with the initiative |
| **GTM plan** | Initiative folder → `GTM/` subpage | Co-located with the initiative |
| **Experiment results** | Initiative folder | Sibling to the PRD that drove the experiment |
| **Metrics / analytics doc** | Metrics & Goals page | Cross-initiative reusable definitions |
| **Process / Ways-of-Working doc** | Ways of Working page | Team processes and decision logs |
| **Quarterly roadmap** | Quarterly Roadmaps page | Quarterly planning artefacts |

### Initiative Folder Pattern

Each initiative under a pillar follows this structure:

```
[Initiative Name]/
├── PRD or Product Brief (page)
├── Research/ (folder)
├── GTM/ (folder)
├── Exploratory Testing/ (folder)
└── [Other artifacts as needed]
```

When creating a new initiative, create the folder under the relevant pillar first, then add the document inside it.

### How to populate this file

1. Open Confluence, navigate to your team's space.
2. Note the `spaceId` (visible in the URL or via `getConfluenceSpaces`).
3. List the top-level pages and their `pageId`s (visible via `getConfluencePageDescendants`).
4. Map your strategic pillars to parent page IDs.
5. Fill in the tables above.

This file is a per-team configuration — keep it in version control alongside your skills.
