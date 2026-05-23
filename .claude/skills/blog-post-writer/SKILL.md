---
name: blog-post-writer
description: Draft a longform blog post or essay for the personal portfolio (and cross-posting surfaces — Substack, Medium, dev.to). Use when the user wants to write a thesis post, a contrarian take, a retrospective, an industry observation, a teardown, or any longform piece intended for the brand's writing surface. Phase-routed (hook & thesis → outline → draft → sharpen → cover & metadata) with a mandatory tone preset selection (Verna / Growth Scoop, Ricardo default, or Operator-clean) before drafting.
metadata:
  type: writing-skill
---

# blog-post-writer

Phase-routed longform post drafter. Five phases, run in order. Do NOT skip phases — each phase produces an artefact the next phase consumes.

**Mandatory pre-flight:** Load `pm-os-public/.claude/skills/shared/post-style-guide.md` before any drafting. The presets and the don't-list there are enforced throughout.

**Mandatory grounding:** If the post draws on Ricardo's Wallapop work, an existing case study, or any external source, invoke the `kb-grounder` sub-agent FIRST to pull verbatim grounding context. Never invent details about Ricardo's career, metrics, or company.

---

## Phase 0 — Intake (always run)

Before any drafting starts, ask the user the following in one batched message. Do not draft until every question is answered.

1. **What's the central claim of this post?** (One sentence. If the user hesitates, the post isn't ready — coach them to find the thesis before writing.)
2. **Which tone preset?**
   - `verna` — Growth Scoop voice. For thesis posts and contrarian takes.
   - `ricardo` — Default voice. Honest + dry humour. For most posts.
   - `operator` — Operator-clean. For pitches, abstracts, and About copy.
   (Decision tree in `post-style-guide.md` §5 if the user is unsure.)
3. **What evidence anchors the post?** (Up to 5 items. Real metrics, named artefacts, links to research, named experts whose work is referenced, real personal anecdotes. The post will be built around these — vague evidence produces vague posts.)
4. **Target length and surface?** (Default: 1,200–1,800 words for `verna` or `ricardo`, posted to portfolio site + cross-posted to LinkedIn/Substack. Override if different.)
5. **Audience priority for this post?** (Senior PMs, founders/hiring managers, prospective advisory clients, wider PM community — pick top one or two. Affects what's assumed vs. explained.)

If the post is the **"Taste is the moat" thesis post** specifically (referenced in `brand/brand-guideline.md` §1), default answers: thesis = "in the AI era, code is cheap and taste is the moat, cultivated through four muscles," preset = `verna`, evidence = the four-muscle taxonomy from the brand guideline, length = 1,500 words, audience = senior PMs + wider PM community.

---

## Phase 1 — Hook & thesis

Output of this phase: **the first 80 words of the post** + **a one-sentence thesis statement** + **a working title and subtitle**.

### 1.1 Draft three opening candidates

Write three distinct openings. Each must:
- State the contrarian or specific claim the post will defend.
- Earn the second paragraph (i.e., it must be IMPOSSIBLE for a reader to skim past it without losing the argument).
- NOT be a definitional preamble, scene-setting illustration, rhetorical question, famous quote, or stat-without-context (see `post-style-guide.md` §3.1).

For `verna` preset, the openings should pattern-match these Verna openers:
- *"For anyone working in tech, I'm sorry to say this, but..."* (direct second-person, contrarian)
- *"Getting to the top of the corporate ladder used to be the goal. ... Now, the real flex is..."* (was/now contrast)
- *"For years, [conventional wisdom]. But that playbook isn't working anymore."* (historical setup → contrarian flip)

For `ricardo` preset, the openings should pattern-match these:
- A specific, concrete observation that the thesis emerges from by paragraph 2.
- A specific number with full context that frames the post's stakes.
- A measured statement of the unconventional view as fact, no dramatic setup.

For `operator` preset, the opening IS the thesis statement, stated in sentence 1.

### 1.2 State the thesis

Below the opening candidates, state the post's thesis in one sentence. The user must be able to summarize the post in this sentence after reading it. If you can't write it cleanly, the post isn't ready.

### 1.3 Working title and subtitle

Draft three title candidates and one subtitle.

For `verna` preset, Verna-pattern titles:
- Declarative claims, often slightly aggressive: *"You'll lose your job in 2027"*, *"IC work is the new career flex"*, *"Company blogs are no longer worth the investment."*
- Subtitles tighten the claim or add a wink: *"Assume that your current role is close to its expiration date"*, *"The rise of the High-impact Individual Contributor (HI-C!)"*.

For `ricardo` preset:
- Observational or argumentative — *"What I learned from"* and *"How I X"* titles are banned.
- Specific: *"Taste is the moat"*, *"Replatforming took fourteen months — here's the part most write-ups skip"*, *"The four muscles of AI-era PM craft."*

For `operator` preset:
- Stated thesis as title. No clever, no rhetorical.

### 1.4 Stop and wait

Output the three openings, the thesis, the three title candidates, and the subtitle. **Wait for user selection or feedback before drafting the rest of the post.** Do not proceed to Phase 2 until the user picks an opening, a title, and confirms the thesis is right.

---

## Phase 2 — Outline

Output of this phase: **a structured outline at section-heading level**, with **one-bullet evidence anchor per section**.

### 2.1 Pick the body structure

From `post-style-guide.md` §3.3, pick ONE of:
- Setup → flip
- Problem → solution
- Origin → lesson
- List with throughline

Don't mix structures. Don't propose a "hybrid" — that's how posts lose their spine.

### 2.2 Draft 4–6 section headings

Each section heading is a short declarative phrase, not a question. For `verna` preset, headings are bold short phrases (e.g., *"The old promotion ladder was dumb"*, *"What's a HI-C?"*, *"I'm living this world: I'm an IC again."*). For `ricardo` preset, headings are flatter and more descriptive (*"What replatforming actually cost"*, *"The four muscles, in order of cultivation difficulty"*).

### 2.3 Pin one evidence anchor per section

Under each heading, write a single bullet stating *what concrete artefact, metric, named source, or specific anecdote anchors this section*. Sections without an evidence anchor get cut, not padded.

### 2.4 Add the counterargument section

One section, always present, often second-to-last. Heading patterns:
- *"What this isn't claiming"*
- *"Two caveats"*
- *"Where this argument breaks down"*

### 2.5 Add the closing

One short section. Type:
- **Action close** — single specific verb the reader should do next.
- **Rallying close** — short declarative sentence the reader can quote.

### 2.6 Stop and wait

Output the full outline (headings + evidence anchors). **Wait for user approval before drafting Phase 3.** This is the cheapest place to redirect the post; do not skip the pause.

---

## Phase 3 — Draft

Output of this phase: **the full draft of the post**, following the outline, in the chosen preset's voice.

### 3.1 Drafting rules

- Write the post section by section in the order of the outline. Do NOT jump around.
- Each section opens with its strongest sentence (BLUF within the section).
- Each section ends with a transition into the next that doesn't telegraph ("In the next section..." is banned).
- The evidence anchor for each section MUST appear in the section's prose, not just gestured at.
- Paragraph rhythm per preset (see `post-style-guide.md` §4):
  - `verna`: 1–3 sentence paragraphs dominant; 3–6 single-sentence punctuation paragraphs in the post.
  - `ricardo`: 2–4 sentence paragraphs dominant; 1–2 single-sentence paragraphs total.
  - `operator`: tight 2-sentence paragraphs throughout, no single-sentence punctuation paragraphs.
- Bold and emphasis usage:
  - `verna`: 2–5 bold one-liners as pull-quote-able assertions. ALL CAPS 0–2 times. Italics for self-talk.
  - `ricardo`: bold only for terms-of-art being defined. Italics for titles of works and very mild emphasis.
  - `operator`: no bold or italics except for terms-of-art.

### 3.2 No invented content

If a section's evidence anchor refers to something that needs grounding (a real metric from Wallapop, a specific quote from a research interview, a citation to an external article), STOP and request the grounding from the user OR invoke `kb-grounder`. **Never invent the number, the quote, the attribution, or the company name.**

### 3.3 Length check

Target the user's stated length. If the draft is going to overshoot by >20%, stop at the overshoot point and ask the user whether to cut or extend. If undershooting by >30%, the post is probably thin — ask the user if there's missing evidence rather than padding.

---

## Phase 4 — Sharpen

Output of this phase: **a revised draft** with each item below explicitly addressed.

### 4.1 Anti-slop sweep

Search the draft for every phrase in `post-style-guide.md` §2 (AI slop blocklist, LinkedIn-cringe phrases, grandiose patterns, voice-killers). For each match, rewrite or delete. Show the user a diff or a list of changes made.

### 4.2 Earned-confidence sweep

For every claim that uses words like "the most," "always," "every," "never," or any superlative: either add a citation, soften the claim, or cut it. State to the user which claims were softened and why.

### 4.3 Pull-quote selection

Identify 3–5 sentences in the draft that work as standalone pull-quotes. These are the candidates for:
- The cover image text (Phase 5).
- LinkedIn distribution (the `linkedin-post-writer` skill will use these).
- OG card subtitle.

A good pull-quote is a complete sentence, ≤ 22 words, that makes the reader want to read the full post.

### 4.4 Counterargument check

Confirm the counterargument / limitation paragraph exists and is honest. A token "of course there are other views" is not a real counterargument. Re-strengthen if weak.

### 4.5 Read-aloud check

Read the post aloud or have it read back. Flag any sentence that:
- Makes you wince.
- Trips on its own grammar.
- Uses two words where one would do.
- Sounds like an LLM.

Rewrite each flagged sentence.

### 4.6 Final checklist

Run the §8 checklist from `post-style-guide.md`. All items pass before exit.

---

## Phase 5 — Cover & metadata

Output of this phase: **a publishing-ready package**: title, subtitle, slug, OG card brief, SEO description, three pull-quote-ready sentences, and the file structure for the portfolio site.

### 5.1 Title and subtitle (final)

Lock in the title and subtitle from Phase 1, revised if the draft moved the thesis. The title is the post's most-used asset (URLs, OG cards, LinkedIn share text) — make it work standalone.

### 5.2 Slug

URL-safe slug, lowercase, hyphenated, ≤ 60 chars. Example: `taste-is-the-moat`. The portfolio site's `/writing/:slug` route consumes it.

### 5.3 OG card brief

Hand off to the `og-card-creator` skill. Include:
- Title (locked from §5.1).
- Subtitle OR best pull-quote (whichever reads stronger as a sub-headline).
- Author byline: `Ricardo Moço · {date}`.
- Suggested visual hook (any specific image, diagram, or wordmark variant the post calls for).

### 5.4 SEO description (~150–160 chars)

A single sentence that states the thesis without clickbait. Used as the meta description and the share-card snippet on platforms that don't render the OG image.

### 5.5 Three pull-quote sentences

Lifted from Phase 4. Used by `linkedin-post-writer` and `linkedin-carousel-writer` to derive distribution variants.

### 5.6 File structure for the portfolio site

Output the suggested file path and the data-shape entry for the site. Pattern (pending the `posts.js` data source — see `personal/portfolio/CLAUDE.md` planned evolution):

```js
// personal/portfolio/src/data/posts.js
{
  slug: 'taste-is-the-moat',
  title: 'Taste is the moat',
  subtitle: 'In an era where code is cheap, the bottleneck is product judgment.',
  date: '2026-05-22',
  kind: 'post',
  preset: 'verna',
  readingTime: 7,
  description: '...', // §5.4
  body: [
    { heading: 'The four muscles' },
    { paragraphs: ['...', '...'] },
    // etc.
  ],
}
```

If `posts.js` doesn't exist yet on the site, flag that to the user and propose the data shape decision (parallel `posts.js` vs. a `kind` discriminator on `caseStudies.js` — see `personal/portfolio/CLAUDE.md` planned evolution). Do not silently create the file; let the user make the data-shape call.

---

## Exit criteria

The skill is done when:
- Phase 0–5 are all complete.
- The §8 checklist in `post-style-guide.md` is all passed.
- The user has the final draft + the publishing package in hand.
- A note has been added to `knowledge-base-reference.md` logging any external sources cited (the `log-external-resource.sh` hook auto-stubs this — refine the stub).

**Do not declare done if any phase was skipped.** Especially not Phase 0 (intake) and Phase 4.6 (final checklist).
