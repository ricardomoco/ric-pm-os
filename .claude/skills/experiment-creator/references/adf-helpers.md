# ADF Helpers for Experiment Fields

All textarea custom fields on the {{COMPANY}} Experiment issue type (`12807` Context, `12808` Hypothesis, `12809` Primary Metric, `12810` Success Criteria, `12816` Additional Information, `12824` Secondary Metrics) must be passed as Atlassian Document Format (ADF) objects.

**Passing a markdown string returns a 400:** `Operation value must be an Atlassian Document (see the Atlassian Document Format)`.

## The helper pattern

Save this as a working script (e.g. `/tmp/build_payload.py`) whenever you need to build a non-trivial ADF payload. Python object construction is cleaner than hand-writing JSON and avoids the class of bugs where raw markdown is pasted inside a text node.

```python
def doc(*content):
    return {"type": "doc", "version": 1, "content": list(content)}

def p(*content):
    return {"type": "paragraph", "content": list(content)}

def t(text, marks=None):
    node = {"type": "text", "text": text}
    if marks:
        node["marks"] = marks
    return node

def bold(text):
    return t(text, [{"type": "strong"}])

def em(text):
    return t(text, [{"type": "em"}])

def code(text):
    return t(text, [{"type": "code"}])

def link(text, href):
    return t(text, [{"type": "link", "attrs": {"href": href}}])

def h(level, *content):
    return {"type": "heading", "attrs": {"level": level}, "content": list(content)}

def ul(*items):
    return {"type": "bulletList", "content": list(items)}

def ol(*items):
    return {"type": "orderedList", "content": list(items)}

def li(*content):
    return {"type": "listItem", "content": list(content)}
```

## Usage example

```python
hypothesis = doc(
    p(
        bold("We believe that "),
        t("surfacing X within Y "),
        bold("will "),
        t("increase [metric], "),
        bold("because "),
        t("[rationale]."),
    ),
    p(bold("Validated if: "), t("[quant threshold] by [date]."))
)
```

Then pass `hypothesis` as the value of `customfield_{{CUSTOM_FIELD_ID}}` in the `fields` argument to `mcp__atlassian__editJiraIssue` or `mcp__atlassian__createJiraIssue`.

## Critical rules

1. **No raw markdown inside text nodes.** `"**bold**"` as a text string renders literally — use `bold("bold")` instead.
2. **No wiki markup either.** `"h2. Title"` as a paragraph is literal text — use `h(2, t("Title"))`.
3. **Lists are nodes, not strings.** `"- item"` in a paragraph is literal text — use `ul(li(p(t("item"))))`.
4. **The description field is different.** Jira's `description` supports markdown when you pass `contentFormat: "markdown"` to `createJiraIssue` / `editJiraIssue`. Only the structured textarea **custom** fields require ADF.
5. **Test the payload before sending.** `json.dumps(payload)` should succeed and the shape should be `{"customfield_XXXXX": {"type": "doc", "version": 1, "content": [...]}}`.

---

## {{COMPANY}} Experiment textarea rendering gotcha

The Experiment issue type's textarea custom fields (`12807`, `12808`, `12809`, `12810`, `12813`, `12816`, `12819`, `12820`, `12821`, `12824`) accept ADF on input but are rendered in the Jira UI with **no rich-text renderer**. Jira internally converts ADF to wiki markup on store, and the wiki markup is then displayed as literal text.

Effect of each ADF node in the {{COMPANY}} UI:

| ADF node | Converted-to wiki | Rendered in Jira UI |
|---|---|---|
| `heading (level=2/3)` | `h2. Title` / `h3. Title` | **Shows literally as `h3. Title`** — no heading styling |
| `text` with `strong` mark | `*text*` | **Shows literally as `*text*`** — no bold |
| `text` with `em` mark | `_text_` | **Shows literally as `_text_`** — no italic |
| `text` with `code` mark | `{{text}}` | Literal braces shown |
| `bulletList` + `listItem` | `* item` per line | Mostly rendered as bullets but inconsistent — the `*` often shows literally next to each item |
| `text` with `link` mark | `[display text\|url]` | Literal brackets-and-pipe shown |
| `paragraph` with text | plain text + `<br/>` line breaks | **Renders cleanly** ✓ |
| `paragraph` with no content (empty) | blank line | **Renders cleanly** ✓ (visual separator) |
| Plain URL inside `text` (no link mark) | the URL | **Auto-linked as clickable** ✓ |

### The safe pattern for Experiment textareas

Use ONLY:
- `paragraph` nodes containing plain `text` nodes (no marks)
- Empty `paragraph` nodes as visual separators
- Plain URLs (Jira auto-links them)
- Unicode bullet `•` as a prefix inside a paragraph for list-like lines
- CAPS LABELS as pseudo-headings (or prefix `—` / section labels of your choice)

```python
# Safe for {{COMPANY}} Experiment textareas — renders cleanly in the Jira UI
doc(
    p("HEADLINE"),
    p("Observed X over N users during the run window."),
    empty_p(),
    p("NEXT STEPS"),
    p("• Test A in sprint N."),
    p("• Follow up on B: {{ATLASSIAN_BASE_URL}}/browse/{{JIRA_PROJECT_KEY}}-NNN"),
)
```

Do NOT use `h(…)`, `bold(…)`, `em(…)`, `code(…)`, `link(…)`, `ul(…)`, `li(…)` inside these fields — they produce wiki-markup artifacts that display as raw text. Those helpers are fine for ADF contexts with a proper renderer (Confluence pages, the Jira `description` field when editing via the Jira UI — but NOT these custom textareas).

### Other places rich ADF does work

- Jira `description` field (system field, not custom) — renders ADF properly.
- Confluence page bodies via `createConfluencePage` / `updateConfluencePage` — render ADF properly.
- Comments via `addCommentToJiraIssue` — render ADF properly.

Use the full helper vocabulary (`h`, `bold`, `link`, `ul`) there. Just not in {{COMPANY}} Experiment textareas.
