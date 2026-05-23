# Bug Field Mappings

Use these numeric IDs for mandatory bug-specific custom fields.

## Required Fields (All Issue Types)

These fields are required on every Jira issue. Omitting them causes a 400 Bad Request error.

| Field Name | Jira Field ID | How to Resolve |
|------------|---------------|----------------|
| Tribe | customfield_{{CUSTOM_FIELD_ID}} | Lookup in `jira-config/user-defaults.md` or `jira-config/jira-team-catalog.md` |
| Topic Team | customfield_{{CUSTOM_FIELD_ID}} | Lookup in `jira-config/user-defaults.md` or `jira-config/jira-team-catalog.md` |
| Track | customfield_{{CUSTOM_FIELD_ID}} | Lookup in `jira-config/user-defaults.md`. **Required for Epics, Stories, Experiments.** May not be required for Bugs — but include it if available. |

## Bug-Specific Fields

| Field Name | Jira Field ID | Option/Value Name | Option ID |
|------------|---------------|-------------------|-----------|
| Issue Type | - | Bug | 1 |
| Discovered in environment | customfield_{{CUSTOM_FIELD_ID}} | Production | 10542 |
| Fix Type | customfield_{{CUSTOM_FIELD_ID}} | Regular | 12486 |
| Origin | customfield_{{CUSTOM_FIELD_ID}} | Internally reported | 12951 |
| Bug Description | customfield_{{CUSTOM_FIELD_ID}} | - | [Text Field] |
| Bug/Defect Priority | customfield_{{CUSTOM_FIELD_ID}} | [Lookup in catalog] | [Lookup in catalog] |
| Type | customfield_{{CUSTOM_FIELD_ID}} | [Lookup in catalog] | [Lookup in catalog] |
| Testing evidence | customfield_{{CUSTOM_FIELD_ID}} | Evidence added | 16589 |
