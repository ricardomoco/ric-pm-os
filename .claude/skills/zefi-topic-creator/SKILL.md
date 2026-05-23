---
name: zefi-topic-creator
description: Guide any {{COMPANY}} PM through creating well-structured Zefi feedback monitoring topics. Use when setting up a new topic or subtopic in Zefi, writing a topic description, or deciding how to structure a team's taxonomy.
---

# Zefi Topic Creator

This skill helps any PM at {{COMPANY}} set up Zefi feedback monitoring topics that will auto-classify accurately. It encodes the rules and best practices from Zefi's own documentation so you don't need to figure them out from scratch.

## How Zefi Works

Zefi's auto-classification engine reads each piece of incoming feedback and maps it to the most relevant topic. The quality of your **topic description** is what determines how accurate that mapping is. A vague description = poor tagging. A specific, example-rich description = reliable signal.

## Hard Constraints

| Rule | Detail |
|---|---|
| Max topics per taxonomy | ~20 |
| Max subtopics per topic | 5 |
| Save | Applies to future feedback only |
| Save & Retrigger | Applies retroactively to the last 2 weeks of data — use this on first setup or after major changes |

## Workflow

1. **Understand the domain**: Ask the user what product area or team they are setting up monitoring for. If they haven't shared context, ask: *What kinds of user feedback are you trying to track?*
2. **Propose topic structure**: Based on the domain, suggest a topic name and up to 5 subtopics that cover the main feedback themes without overlap.
3. **Draft the topic description**: Write a description that is specific, enumerates concrete examples of feedback that belongs there, and is detailed enough for an algorithm to use as a classifier. See the [description writing guide](references/description-guide.md) for rules and examples.
4. **Validate constraints**: Confirm the topic count and subtopic count are within limits.
5. **Present the output**: Show the topic in the copy-ready format below.
6. **Advise on Save & Retrigger**: Remind the user to use Save & Retrigger on first setup to backfill 2 weeks of data.

## Output Format

Present each topic ready to copy into Zefi:

```
TOPIC: [Topic Name]

DESCRIPTION:
[Full description paragraph — this is what drives auto-classification. Copy verbatim into Zefi.]

SUBTOPICS:
1. [Subtopic Name] — [One-line description of what feedback belongs here]
2. [Subtopic Name] — [One-line description]
...
```

## Behavioral Guardrails

- **Never invent feedback themes.** Only suggest topics grounded in the user's stated product area or context they've provided.
- **Push back on vague descriptions.** If a topic description is too short or abstract, flag it and rewrite it with concrete examples before presenting it as final.
- **Flag constraint violations.** If a requested structure exceeds 5 subtopics or ~20 total topics, say so and propose a consolidation before proceeding.
- **Don't manage a central registry.** This skill helps create topics — where and how the user stores or tracks them in Zefi is their responsibility.

## Reference Materials
- [Description Writing Guide](references/description-guide.md): Rules and examples for writing high-quality Zefi topic descriptions.
