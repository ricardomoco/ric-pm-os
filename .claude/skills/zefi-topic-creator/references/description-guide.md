# Zefi Topic Description Writing Guide

A topic description is the core input to Zefi's auto-classification algorithm. The quality of the description directly determines how accurately feedback gets tagged.

## What Makes a Good Description

A good topic description does three things:

1. **States the general theme** — what product area or experience this topic covers.
2. **Enumerates concrete feedback examples** — specific things a user might say or complain about that belong here.
3. **Draws boundaries** — makes it clear what does *not* belong, especially if adjacent topics exist.

## Rules

- **Be specific, not abstract.** "Issues with search" is bad. "Feedback about search results being irrelevant, wrong, or not matching the query" is good.
- **Use the user's language.** Write from the perspective of what a frustrated or happy user would say, not internal product terminology.
- **Cover the range.** Include both positive and negative feedback examples so Zefi doesn't only tag complaints.
- **Avoid overlap.** If two topic descriptions could both claim the same feedback, one of them is too broad. Tighten the boundaries.
- **Length:** 2–4 sentences. Long enough to be specific, short enough to stay focused.

## Template

```
Feedback about [general theme]. Includes [specific example 1], [specific example 2], [specific example 3], and [specific example 4]. Also captures [edge case or adjacent feedback type that belongs here].
```

## Example: Search Topic ({{COMPANY}})

**Topic:** Search

**Description:**
Feedback about the search experience on {{COMPANY}}. Includes results being irrelevant or not matching the query, difficulty using filters or sorting options, problems with location and distance settings, slow loading or errors in search, and complaints about item cards not showing enough information to evaluate a listing without opening it.

**Why this works:**
- Names five distinct sub-themes explicitly → subtopics map cleanly to them
- Uses everyday language ("not matching the query", "slow loading") → matches how users write reviews
- Scoped to the finding experience → doesn't bleed into checkout or chat

## Common Mistakes

| Mistake | Example | Fix |
|---|---|---|
| Too vague | "Problems with the app" | Name the specific feature or flow |
| Internal jargon | "SERP relevance degradation" | "Search results that don't match what the user was looking for" |
| Too narrow | "Crashes on search results page on iOS 17" | Keep topics at a theme level, not a specific bug |
| No examples | "Feedback about filters" | "Filters that are missing, broken, reset unexpectedly, or hard to find" |
