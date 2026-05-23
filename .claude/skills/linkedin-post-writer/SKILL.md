---
name: linkedin-post-writer
description: Draft a short-form LinkedIn post for distribution — either native content (a standalone observation, take, or short essay) or a teaser-and-link post that drives traffic to a longer piece (blog post on the portfolio, case study, podcast appearance). Use when the user wants to ship LinkedIn content for the personal brand. Bakes in LinkedIn-specific constraints (~1,300-char sweet spot, first-line hook before the "see more" fold, no rendered markdown, line-break-as-structure) and the brand's anti-LinkedIn-cringe rules.
metadata:
  type: writing-skill
---

# linkedin-post-writer

Short-form post drafter for the brand's LinkedIn surface. The most-used distribution skill — most weeks of the brand will produce more LinkedIn posts than blog posts.

**Mandatory pre-flight:** Load `pm-os-public/.claude/skills/shared/post-style-guide.md` — and especially §2 (the LinkedIn-cringe blocklist). Every line of `post-style-guide.md` §2 applies double on LinkedIn, because the platform is *where* the cringe patterns originated.

---

## Surface constraints (load these into the draft)

LinkedIn is a structural environment, not a typographic one. Plan around it.

| Constraint | Value | Implication |
|---|---|---|
| Total character cap | ~3,000 | Hard upper bound; almost never approach it |
| Engagement sweet spot | 1,000–1,500 chars | Drafts longer than this lose feed velocity |
| First-line "see more" fold (mobile) | ~210 chars | The first line must earn the click |
| Rendered formatting | None | No markdown bold/italic/links; bold and italic require Unicode hacks (avoid) |
| Structure mechanism | Blank lines | One blank line between paragraphs = structure; that's the only tool |
| Link rendering | Compresses to a single auto-card | One link per post (the cross-link); don't bury it |
| Hashtag positioning | End of post | 3–5 relevant; not the post's job to chase reach |

**Em-dashes:** technically render, but visually they read as "this was written by AI or copy-pasted from a blog." Use sparingly on LinkedIn — at most one per post, and only when the rhythm genuinely needs it. Replace others with periods or em-dash-style commas.

**No emoji-in-first-line.** No rocket, no fire, no 100. These are the load-bearing signals of LinkedIn-cringe. The Ricardo brand actively repels this audience.

---

## Two modes

Pick one upfront. Don't blend.

### Mode 1 — Native post

A standalone short essay or observation. The post is the artefact, not a teaser for something else. 500–1,500 chars.

**Use when:**
- The thought doesn't need a 1,500-word blog post to land.
- The observation is specific enough to stand alone.
- The brand wants to test a thesis cheaply before investing in a longform piece.

### Mode 2 — Cross-link teaser

A post that hooks the reader, gives them just enough to want more, and links to the full piece. 600–1,200 chars + one link.

**Use when:**
- A new blog post on the portfolio or a Substack cross-post has shipped.
- A podcast appearance, conference talk, or external publication has gone live.
- A case study has been published on the portfolio.

---

## Phase 0 — Intake

Ask in one batched message:

1. **Which mode?** Native post or cross-link teaser.
2. **What's the thesis or hook in one sentence?**
3. **Which tone preset?** (`verna` for opinions / takes; `ricardo` for observations and reflections — default for the brand.) **Operator-clean is not used on LinkedIn**; the platform's register is too informal for it.
4. **If cross-link mode:** What's the destination URL and the headline of the longer piece?
5. **Audience tilt for this post?** (Peer PMs, founders/hiring managers, advisory prospects, wider community.)

---

## Phase 1 — The first line

This is 60% of the post's work. The first line decides whether the rest is read.

### 1.1 First-line patterns (good)

The first line must do one of:

- **State the contrarian claim plainly.** *"Most PM career advice is written by PMs who haven't shipped in two years."*
- **State a specific number with implication.** *"I rewrote my OS three times in twelve months. Here's what each rewrite cost."*
- **Name a moment of realization, concretely.** *"I shipped a feature with +12.4% CVR. Then I watched the Slack thread where two designers argued the trade-off — and realized I hadn't shipped the feature; they had."*
- **Quote the conventional wisdom you're about to dismantle.** *"'PMs need to learn to code.' This advice was wrong in 2024, and it's wronger now."*
- **A single unadorned observation that earns the next line.** *"Wallapop's listing page loads 80% faster than it did six months ago. The buyer NPS for that page didn't move."*

### 1.2 First-line patterns (banned — these are the don'ts)

- "Today I want to share..."
- "Excited to..."
- "Three things every PM should know about..."
- "I just realized..."
- Any opener that includes "🚀", "💯", "🔥", "✨", or "👇"
- "Most people think X. But the truth is Y." (the format is so overused it's a tell)
- "Last [day of week]..."
- "I had a meeting with [seniority] who told me..."

### 1.3 Draft three candidates

Always three. Pick one with the user before continuing.

---

## Phase 2 — Body

The body delivers on the first line. It does not waste characters on:
- Saying what the first line already said.
- Promising what's coming ("Here's what I learned:" — just say it).
- Setup paragraphs ("So I was thinking about X the other day, and...").

### 2.1 Length per mode

- **Native:** 500–1,500 chars. Most posts land at 800–1,100.
- **Cross-link teaser:** 600–1,200 chars including the link line. Most land at 800.

### 2.2 Structure patterns

Pick one — these match the structure presets in `post-style-guide.md` §3.3, scaled down:

- **Three-point list with throughline.** Three short bullets/lines, each starting with a bold lead-in *concept* (no bold formatting; the lead-in is structural). Each item has one concrete example.
- **Observation → implication.** Two-paragraph structure. First paragraph names the observation with specifics. Second paragraph extracts the implication. End.
- **Setup → flip → consequence.** Three short paragraphs. The flip is one line; the consequence is one line.
- **Personal anecdote → transferable lesson.** One paragraph of concrete anecdote. One paragraph of lesson. The lesson must explicitly state what *doesn't* transfer to other contexts.

### 2.3 Paragraph rhythm

LinkedIn rewards short paragraphs. Default: 1–2 sentences per paragraph, with blank lines between. Three-sentence paragraphs are okay if the content earns it. Four or more sentences in one paragraph rarely earns the reader's persistence on this platform.

### 2.4 No invented details

Same rule as blog posts. Numbers cited must be real, units included, time window stated. If a real number isn't available, drop the number and make the qualitative point.

---

## Phase 3 — Close

The close depends on mode.

### 3.1 Native post close

Two options:

- **One-line declarative close.** A short, quotable sentence that summarizes the argument.
  - *"The PMs who shine in 2027 won't be the ones who use the most tools. They'll be the ones with the most taste."*
- **One-sentence directive.** A specific verb the reader could act on this week.
  - *"This week: take one product you actually love, and write down three choices the team made that you wouldn't have. That's the entire taste exercise."*

Never close with:
- "Agree?"
- "Thoughts?"
- "Let me know in the comments."
- "What would you add?"
- A list of related posts.

### 3.2 Cross-link teaser close

One short line of context + the link. Pattern:
> *"Full write-up on my site: [link]"*
> *"More on this in my latest: [link]"*
> *"Wrote a longer piece about this — [link]"*

Don't apologize for the link ("If you found this interesting, you might enjoy..."). Don't hard-sell ("Click here to read the FULL article!").

---

## Phase 4 — Hashtags

Three to five hashtags. Specific to the post, not generic.

**Good:** `#ProductManagement`, `#AINativePM`, `#ContinuousDiscovery`, `#PortfolioCareers`, `#Marketplaces`.

**Bad:** `#Leadership`, `#Innovation`, `#Inspiration`, `#Motivation`, `#Success`, `#Growth` — these are the trash-hashtag tells.

If no hashtag fits naturally, ship without. Hashtags are a discoverability tool, not a brand signal. Empty hashtag strings are worse than none.

---

## Phase 5 — Anti-slop check

Before declaring done:

- [ ] First line is one of the good patterns from §1.1, none of the banned from §1.2.
- [ ] Zero phrases from `post-style-guide.md` §2 (AI slop, LinkedIn-cringe, grandiose, voice-killers).
- [ ] No "I'm humbled" / "I'm thrilled" / "Excited to" / "Today I want to share."
- [ ] No emoji in the first line. Emoji elsewhere: max 1 per post, and only when load-bearing (e.g., a checkmark in a list of items genuinely shipped).
- [ ] Character count is in the engagement sweet spot for the chosen mode.
- [ ] Em-dashes ≤ 1.
- [ ] No "click here" / "swipe up" / "DM me" prompts.
- [ ] The close is declarative or directive — not "what do you think?"

---

## Phase 6 — Output package

Hand off:

1. **The post text**, copy-paste ready, with blank lines preserved.
2. **Character count.**
3. **Suggested OG card / image** for the post: either an existing post's cover (cross-link mode) or a sentence-as-image (native mode). For native mode, surface the strongest single sentence from the body as a candidate cover image text — `og-card-creator` can take it from there.
4. **Suggested first comment** *only if* there's a genuinely useful expansion the user wants to drop as a first comment (e.g., "for the curious: here's the breakdown of [related thing]"). Don't generate a placeholder first comment for engagement-farming.

---

## A worked example (Ricardo preset, native mode)

**First line:**
> Most PM career advice in 2026 is written by people who haven't shipped a feature in two years.

**Body:**
> The advice tracks: more frameworks, more meetings, more alignment, more strategy decks.
>
> The shipping work tracks differently: more research, more prototypes, more decisions made at low altitude with people closer to the problem.
>
> The two don't reconcile. PMs reading the first set of advice while doing the second set of work get told the gap is their problem. It isn't — the advice is.

**Close:**
> The PMs who are going to do the best work in the next two years are the ones who quietly ignore the career-stage advice and just keep shipping.

**Hashtags:**
> #ProductManagement #AINativePM #PMcraft

**Character count:** ~700. Sweet spot.

**Cover image suggestion:** Hand to `og-card-creator` with title "Most PM career advice is written by people who haven't shipped in two years" and subtitle "—".
