---
name: linkedin-carousel-writer
description: Draft a multi-slide LinkedIn carousel — 6–10 slides, one idea per slide, with text content per slide and a visual brief that consumes the Operator design system tokens. Use when the user wants to ship a visual-format LinkedIn post (often the highest-engagement format on the platform) for a thesis, a framework explanation, or a decomposition of a longer post. Outputs slide-by-slide copy plus a render-ready brief that can be turned into a PDF in Figma, a slide deck, or a generated HTML-to-image pipeline.
metadata:
  type: writing-skill
---

# linkedin-carousel-writer

Carousels are the highest-leverage LinkedIn format for the brand. They package one idea into a swipeable artefact that's screenshot-able, savable, and re-shareable. The format rewards visual restraint and conceptual density — which is exactly what the Operator design system is built for.

**Mandatory pre-flight:**
- Load `pm-os-public/.claude/skills/shared/post-style-guide.md` for voice rules.
- Load `brand/design-system/tokens.md` and `brand/design-system/README.md` — the visual brief consumes the system's tokens.
- Default tone preset: `ricardo` for analytical/decomposition carousels, `verna` for thesis or contrarian carousels. **`operator-clean` is not used here** — too dry for the format.

---

## Surface constraints

| Constraint | Value | Why |
|---|---|---|
| Slide count | 6–10 | < 6 underuses the format; > 10 loses attention |
| Aspect ratio | 4:5 (1080×1350px) or 1:1 (1080×1080px) | 4:5 is the native carousel ratio; 1:1 if cross-posting to Instagram |
| Words per slide | 15–60 | Reader is swiping; dense text dies |
| Cover slide work | Standalone hook | Must work as a thumbnail before the user swipes |
| Final slide work | One-line CTA | What the reader should do after consuming the carousel |
| Total reading time | ~45 seconds | The whole carousel is consumed in one sitting |
| Distribution | Posted as a PDF attachment on a regular LinkedIn post | The post body wraps the carousel; the carousel does the heavy lifting |

---

## The "one idea per slide" rule

The hardest rule. Most failed carousels have 2–3 ideas crammed onto one slide because the author tried to keep the carousel short. The right answer is more slides, not denser slides.

If a slide has more than one verb-and-object, split it. If a slide has more than two sentences, ask whether the second sentence is a different idea. If a slide has a comma followed by "and," that's almost always two ideas.

---

## Phase 0 — Intake

Ask in one batched message:

1. **What's the carousel's central thesis or framework?** (One sentence. The carousel's job is to decompose this into 6–10 slides.)
2. **Which tone preset?** (`ricardo` default; `verna` for thesis/contrarian carousels.)
3. **Source material?**
   - Decomposition of a blog post (paste the post or point to the file).
   - A standalone framework explanation (provide the framework's structure).
   - A retrospective with N learnings.
   - Other (describe).
4. **Target slide count?** (Default: 8.)
5. **CTA?** (Where does the carousel send the reader? Portfolio site, full blog post, newsletter signup, advisory page.)

---

## Phase 1 — Slide map

Output of this phase: **the slide-by-slide skeleton**, before drafting copy. Get sign-off here; do not draft the full carousel until the map is approved.

### 1.1 Slide structure templates

Pick one. Don't blend.

**Template A — Thesis decomposition** (best for arguments like "Taste is the moat")

| Slide | Purpose |
|---|---|
| 1 | Cover: the thesis in one declarative sentence. |
| 2 | The conventional view (what most people believe). |
| 3 | The flip (the contrarian thesis). |
| 4–7 | One slide per supporting argument or component (e.g., one per "muscle"). |
| 8 | The counterargument (what this isn't claiming). |
| 9 | The implication (what to do with this). |
| 10 | CTA: read the full post / follow / work with me. |

**Template B — Framework explanation** (best for the four taste muscles, the OS architecture, the brand thesis pillars)

| Slide | Purpose |
|---|---|
| 1 | Cover: framework name + one-line elevator. |
| 2 | Why this framework exists (the problem it solves). |
| 3–N | One slide per component, with the same visual treatment. |
| N+1 | A worked example showing the framework applied. |
| Last | CTA. |

**Template C — Numbered retrospective** (best for case-study extractions, "X lessons from Y")

| Slide | Purpose |
|---|---|
| 1 | Cover: project name + headline outcome. |
| 2 | Context: what was the situation. |
| 3–N | One numbered lesson per slide, with one piece of concrete evidence per lesson. |
| Last | What didn't transfer + CTA. |

### 1.2 Write each slide's purpose in one line

Output the map as a table: slide number → purpose → key sentence or concept. No prose yet.

### 1.3 Stop and wait

User signs off before Phase 2.

---

## Phase 2 — Slide copy

Output of this phase: **the text content for every slide**.

### 2.1 Per-slide content rules

Each slide has at most:
- **One headline** (1–8 words, the slide's title).
- **One body** (1–3 sentences OR a 2–4 item list, never both).
- **One visual element** (described in the visual brief, Phase 3): an icon, a chart, a diagram, a screenshot, or just typography.
- **Optional small footer** (the brand's wordmark + slide number, e.g., "Ricardo Moço · 03/08").

### 2.2 Cover slide (slide 1) is special

It must work as a standalone thumbnail in the LinkedIn feed without context. Three patterns:

- **Big claim, no decoration.** A single sentence set in `--text-5xl` over `--bg-canvas`. Wordmark in the corner. The most Attio-aligned option.
  - Example cover text: *"Taste is the moat in the AI era."*
- **Numbered teaser.** *"4 muscles every AI-era PM is building"* — only if the numbered framework is what the carousel argues.
- **Provocation.** *"You'll lose your PM job in 2027. Probably."* — Verna preset only; rare.

The cover NEVER includes the words "Swipe ➡" or "Read more" — that's LinkedIn-cringe. The format already implies the swipe.

### 2.3 Body slides

For each body slide, draft:
- **Headline:** declarative, ≤ 8 words, no question marks unless the carousel's structure genuinely depends on it.
- **Body:** 1–3 short sentences OR a 2–4 item list. Numbers and concrete examples beat abstract claims.

### 2.4 Counter / caveat slide

Always include a slide that names what the carousel ISN'T claiming. This is the credibility signal — without it, carousels read as overclaiming. Even Verna's most punchy posts have a "Two things to be clear about" beat.

### 2.5 Final slide (CTA)

One short sentence + the link or instruction. Patterns:

- *"Full post: ricardomoco.com/writing/taste-is-the-moat"*
- *"More on AI-native PM craft → ricardomoco.com"*
- *"Have a feature you'd like a second opinion on? ricardomoco.com/work-with-me"*

Never:
- *"Follow me for more!"*
- *"Tag a PM who needs this!"*
- *"What would you add? Drop a comment ↓"*

### 2.6 Stop and wait

Output all slide copy. User signs off before Phase 3.

---

## Phase 3 — Visual brief

Output of this phase: **a render-ready specification** that consumes Operator design tokens. The output is a designer brief (for hand-rendering in Figma) AND a generated HTML/CSS that could be screenshotted to image, depending on the user's preferred workflow.

### 3.1 Visual rules (Operator-aligned)

| Element | Token | Treatment |
|---|---|---|
| Background | `--bg-canvas` (light mode) | All slides default to light mode. The brand's surface is light. |
| Slide border | `--border-default` | Optional 1px outer hairline border; brings the system feel. |
| Headline type | `--text-5xl` cover, `--text-3xl` body slides | Inter, weight 600, letter-spacing per token. |
| Body type | `--text-md` or `--text-lg` | Inter, weight 400, color `--text-primary` for body, `--text-secondary` for supporting. |
| Accent usage | `--accent-default` for ONE element per slide | Underline on a key word, a single icon, a number, a status dot. Restraint. |
| Eyebrow / category | `--text-xs` uppercase, `--text-tertiary` | Optional. "MUSCLE 03 / 04" pattern. |
| Padding | `--space-9` to `--space-11` | Slides breathe. |
| Wordmark | Bottom-left corner | "Ricardo Moço" in Inter Semibold 16px, `--text-primary`. |
| Slide indicator | Bottom-right corner | "03 / 08" in `--font-mono`, `--text-tertiary`, `--text-xs`. |

### 3.2 What NOT to do

- No gradients on slides (matches `brand-guideline.md` §3).
- No glassmorphism / backdrop-blur on slides.
- No stock photos behind text.
- No emoji in the headline of any slide.
- No more than two type sizes per slide.
- No multi-color treatments — neutral grayscale + one accent dot.
- No carousel-template aesthetics ("Welcome to slide 3 of 8! 👋").

### 3.3 Reference HTML/CSS for a slide

For users who want to render via headless browser screenshot, provide a reference slide HTML using the tokens directly. Example for a Template A body slide:

```html
<!doctype html>
<html data-theme="light">
<head>
  <link rel="stylesheet" href="/path/to/brand/design-system/tokens.css">
  <style>
    body { margin: 0; }
    .slide {
      width: 1080px;
      height: 1350px;
      background: var(--bg-canvas);
      color: var(--text-primary);
      font-family: var(--font-sans);
      padding: var(--space-11);
      box-sizing: border-box;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      border: 1px solid var(--border-default);
      border-radius: var(--radius-2xl);
    }
    .eyebrow {
      font-size: var(--text-xs-size);
      line-height: var(--text-xs-lh);
      text-transform: uppercase;
      letter-spacing: 0.08em;
      font-weight: var(--font-weight-semibold);
      color: var(--text-tertiary);
    }
    .headline {
      font-size: var(--text-3xl-size);
      line-height: var(--text-3xl-lh);
      letter-spacing: var(--text-3xl-ls);
      font-weight: var(--font-weight-semibold);
      margin-top: var(--space-3);
      margin-bottom: var(--space-6);
    }
    .body {
      font-size: var(--text-lg-size);
      line-height: var(--text-lg-lh);
      letter-spacing: var(--text-lg-ls);
      color: var(--text-secondary);
      max-width: 60ch;
    }
    .footer {
      display: flex;
      justify-content: space-between;
      align-items: end;
      color: var(--text-tertiary);
      font-size: var(--text-xs-size);
    }
    .wordmark { color: var(--text-primary); font-weight: var(--font-weight-semibold); }
    .slide-num { font-family: var(--font-mono); }
    .accent { color: var(--accent-default); }
  </style>
</head>
<body>
  <div class="slide">
    <div>
      <p class="eyebrow">Muscle 03 / 04</p>
      <h2 class="headline">Cross-industry benchmarking</h2>
      <p class="body">Most product breakthroughs are <span class="accent">imports</span>, not inventions. The best PMs study how unrelated industries solve adjacent problems — fintech, gaming, logistics — and bring the patterns that translate.</p>
    </div>
    <div class="footer">
      <span class="wordmark">Ricardo Moço</span>
      <span class="slide-num">03 / 08</span>
    </div>
  </div>
</body>
</html>
```

For a Figma-first workflow, the same content drops into an Operator master frame with the tokens already bound.

### 3.4 Cover slide reference

The cover slide uses a larger type size (`--text-5xl` or `--text-6xl`) and no body — just the thesis sentence and the wordmark. Same template, larger headline, no body block.

---

## Phase 4 — Wrapping post body

The carousel ships INSIDE a regular LinkedIn post. The post body is the wrapper. Draft a short wrapper (200–400 chars) that:

- Restates the thesis in one sentence (different phrasing from the cover slide; otherwise the post is repetitive).
- Promises one specific takeaway the reader gets from the carousel.
- No "swipe right ➡" / "check the slides ↓" — the format implies it.
- Hashtags at the end (3–5, specific).

Hand off to `linkedin-post-writer` if the wrapper is going to be longer than 400 chars (then it's a native post that happens to attach a carousel, not a carousel post).

---

## Phase 5 — Final-pass checklist

- [ ] 6–10 slides, no fewer, no more.
- [ ] Each slide has one idea, not two.
- [ ] Cover slide works standalone as a thumbnail.
- [ ] Counter / caveat slide is present.
- [ ] Final slide has a specific CTA, not a follow-prompt.
- [ ] All slides consume Operator tokens; no hardcoded hex or pixel values.
- [ ] No gradient, no glassmorphism, no stock photo, no emoji in headlines.
- [ ] Accent color used at most once per slide.
- [ ] Wordmark + slide indicator present in every body slide.
- [ ] Wrapper post body ≤ 400 chars, no LinkedIn-cringe patterns.
- [ ] Hashtags specific (3–5), not generic.

---

## Output package

Hand the user:

1. **Slide copy** as a numbered list (slide 1 → N).
2. **Visual brief** with token references per slide.
3. **HTML/CSS reference** for the chosen template (one slide as the master; the user can adapt).
4. **Wrapper post body** + hashtags.
5. **Suggested file structure** for the carousel artefacts (e.g., `personal/portfolio/public/carousels/<slug>/slide-01.png` through `slide-N.png` + a single combined `<slug>.pdf` for upload).

If the user wants to render via a headless browser pipeline, point them at a script (not part of this skill — they'll set up `puppeteer` or similar). If they want to render in Figma, point them at the Operator Figma library (to be built; until then, the user manually mirrors `tokens.css` into Figma variables).
