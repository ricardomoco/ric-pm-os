---
name: og-card-creator
description: Generate a cover / OG card specification for a blog post, case study, podcast appearance, or LinkedIn post — consuming Operator design system tokens. Produces a layout brief, render-ready HTML+CSS for headless-browser screenshotting, and format variants (OG 1200×630, Twitter card 1200×675, Substack cover, LinkedIn 1200×627, square 1080×1080). Use when a post is ready for distribution and needs a share image; typically invoked at the end of `blog-post-writer` Phase 5 or `case-study-writer` Phase 6.
metadata:
  type: writing-skill
---

# og-card-creator

The cover image is the post's most-shared asset — it appears in every Slack share, every LinkedIn preview, every Substack email, every Twitter card. A weak cover undersells a strong post. A cover that matches the brand's visual language reinforces it.

The skill produces a spec, not a rendered image. The rendering happens via:
- Manual Figma composition using the Operator library (preferred for hand-crafted covers).
- Headless browser screenshot of the generated HTML+CSS (for programmatic pipelines, e.g., post-publish automation).
- Adapted to the user's existing tooling.

**Mandatory pre-flight:**
- Load `brand/design-system/tokens.md` and `brand/design-system/tokens.css` — the spec consumes tokens directly.
- Load `brand/brand-guideline.md` §6 (Imagery & video rules) — applies to cover images.

---

## Format variants

| Variant | Dimensions | Surfaces | Notes |
|---|---|---|---|
| `og` (default) | 1200×630 | Portfolio site OG meta, Slack, Discord, generic share | The Facebook OpenGraph default; most platforms fall back to this if not given another |
| `twitter` | 1200×675 | Twitter/X card (`summary_large_image`) | Close to OG but slightly taller |
| `linkedin` | 1200×627 | LinkedIn post preview | Subtle difference from OG; the same image renders well at this ratio |
| `substack-cover` | 1456×816 | Substack post header | Wider than OG; design for the broader canvas |
| `square` | 1080×1080 | Instagram cross-posts, LinkedIn carousel cover slide reused as a card | Different layout than OG; type stacks more |
| `portrait` | 1080×1350 | LinkedIn carousel cover, mobile-share | Carousel cover slide. Reusable as a standalone share. |

For most posts, render the **og + linkedin + square** variants. Skip Twitter unless the brand is actively Twitter-distributed (currently not).

---

## Visual templates

Three templates, each with a specific use case. Pick one upfront.

### Template 1 — Type-led

The default. Pure typography on `--bg-canvas`. The post's title or strongest pull-quote is the entire composition. Wordmark in the corner.

**Use when:** the post is a thesis or argument piece (most blog posts, especially Verna-preset).

**Layout:**
- Background: `--bg-canvas`.
- Optional 1px outer hairline border `--border-default`, inset `--space-6` from the edge.
- Main text block: top-left aligned, indented `--space-9` from the left.
- Headline: the post title OR the strongest pull-quote (≤ 16 words, ≤ 100 chars), set in `--text-5xl` or `--text-6xl`, weight 600, color `--text-primary`.
- Subtitle (optional): the post's subtitle OR a one-line POV, set in `--text-xl`, weight 400, color `--text-secondary`.
- Eyebrow (optional): a category tag in `--text-xs` uppercase, letter-spacing 0.08em, color `--text-tertiary`. Examples: "BLOG · 2026.05", "CASE STUDY", "ESSAY."
- Single accent dot (`--accent-default`, 8px circle) next to the eyebrow OR an accent underline on the most important word in the headline. Used ONCE per card.
- Wordmark: bottom-left, "Ricardo Moço" in Inter Semibold, color `--text-primary`.
- Optional URL: bottom-right, `ricardomoco.com` in `--font-mono`, color `--text-tertiary`, `--text-xs`.

### Template 2 — Eyebrow-and-title

A more restrained variant for case studies and operator-clean content.

**Use when:** the post is a case study or a piece where the framing (category, date, project) matters as much as the title.

**Layout:**
- Same background and border as Template 1.
- Eyebrow + date at the top, in `--text-xs` uppercase, `--text-tertiary` (e.g., "CASE STUDY · WALLAPOP · 2026").
- Title centered vertically, set in `--text-4xl` or `--text-5xl` depending on length.
- Subtitle below the title (one line), `--text-lg` weight 400 `--text-secondary`.
- Wordmark + URL footer same as Template 1.
- No accent color on this template (purer restraint).

### Template 3 — Diagram-led

For posts whose argument is structurally visual — a framework, a flow, a comparison.

**Use when:** the post explains a multi-component framework (e.g., "The four muscles of AI-era PM craft"). The diagram IS the cover.

**Layout:**
- Background: `--bg-canvas`.
- Top-left: small eyebrow ("FRAMEWORK") + the framework's name in `--text-xl` weight 600.
- Center: the diagram itself, rendered in Operator tokens (hairline borders, `--accent-default` for one node, neutral grays for the rest).
- Bottom: a one-line caption + wordmark.

For the diagram itself, defer to the user's renderer (Figma, hand-crafted SVG, or generated via `figma:figma-generate-diagram` skill if Figma is available). The og-card-creator just specifies the layout slots and the token language.

---

## Phase 0 — Intake

If invoked at the end of `blog-post-writer` or `case-study-writer`, the intake is automatic — those skills hand off the title, subtitle, pull-quotes, and post metadata. Otherwise, ask:

1. **What's the post's title?** (Locked.)
2. **What's the subtitle, OR the strongest single pull-quote?** (≤ 100 chars; ≤ 16 words.)
3. **What's the date?** (Defaults to today.)
4. **What's the category?** (Blog post, case study, essay, talk recap, podcast guest.)
5. **Which template?** (`type-led` default, `eyebrow-and-title` for case studies, `diagram-led` for framework posts.)
6. **Which format variants to generate?** (Default: `og`, `linkedin`, `square`.)

---

## Phase 1 — Layout brief

Output a written brief that a designer or a developer could implement. Include:

- Selected template name.
- Background color (token).
- All text content: eyebrow, headline, subtitle, wordmark, URL.
- Type sizes and weights (with token references).
- Accent placement (if any).
- Padding and inset values (with token references).
- Optional notes for visual polish.

This brief is the canonical artefact. Render derivatives (HTML, Figma, JPEG) are derived from it.

---

## Phase 2 — Render-ready HTML+CSS

Output a single-file HTML page that renders the card at the selected variant size. Use the brand's `tokens.css` directly via `<link rel="stylesheet">` or inlined.

### Reference example — Template 1, OG variant (1200×630), Verna-preset blog post

```html
<!doctype html>
<html data-theme="light" lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="/brand/design-system/tokens.css">
  <style>
    body { margin: 0; }
    .og {
      width: 1200px;
      height: 630px;
      background: var(--bg-canvas);
      color: var(--text-primary);
      font-family: var(--font-sans);
      padding: var(--space-9);
      box-sizing: border-box;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      position: relative;
    }
    .og::before {
      content: '';
      position: absolute;
      inset: var(--space-6);
      border: 1px solid var(--border-default);
      border-radius: var(--radius-2xl);
      pointer-events: none;
    }
    .top { display: flex; align-items: center; gap: var(--space-2); }
    .accent-dot {
      width: 8px;
      height: 8px;
      background: var(--accent-default);
      border-radius: var(--radius-full);
    }
    .eyebrow {
      font-size: var(--text-xs-size);
      text-transform: uppercase;
      letter-spacing: 0.08em;
      font-weight: var(--font-weight-semibold);
      color: var(--text-tertiary);
    }
    .headline {
      font-size: var(--text-5xl-size);
      line-height: var(--text-5xl-lh);
      letter-spacing: var(--text-5xl-ls);
      font-weight: var(--font-weight-semibold);
      max-width: 22ch;
      margin: 0;
    }
    .footer {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      color: var(--text-tertiary);
      font-size: var(--text-xs-size);
    }
    .wordmark { color: var(--text-primary); font-weight: var(--font-weight-semibold); }
    .url { font-family: var(--font-mono); }
  </style>
</head>
<body>
  <div class="og">
    <div>
      <div class="top">
        <span class="accent-dot"></span>
        <span class="eyebrow">Essay · 2026.05</span>
      </div>
      <h1 class="headline" style="margin-top: var(--space-5)">
        Taste is the moat in the AI era.
      </h1>
    </div>
    <div class="footer">
      <span class="wordmark">Ricardo Moço</span>
      <span class="url">ricardomoco.com</span>
    </div>
  </div>
</body>
</html>
```

### Generating the variants

The same template adapts to each variant by changing the outer `.og` width and height:
- `og`: 1200×630
- `linkedin`: 1200×627 (~same; one CSS swap)
- `square`: 1080×1080 — type stacks more; headline shrinks to `--text-4xl` to fit.
- `portrait`: 1080×1350 — headline at `--text-5xl`, eyebrow and wordmark have more breathing room.
- `substack-cover`: 1456×816 — increase padding, keep typography proportional.

Each variant gets its own `.og` block in the output file or its own page; the user picks the rendering pipeline.

### Rendering the image

Either:
- Open the HTML in a browser and screenshot (manual, fine for occasional posts).
- Use Playwright / Puppeteer to render headlessly at the exact viewport (for automation).
- Drop the brief into Figma using the Operator library (preferred for posts that need extra polish).

---

## Phase 3 — Final-pass checklist

- [ ] Only Operator tokens used; no hardcoded hex or px.
- [ ] Headline fits in the canvas at the selected size (no clipping).
- [ ] Accent color used at most once.
- [ ] Wordmark present in every variant.
- [ ] No gradient, no glassmorphism, no stock photo behind text.
- [ ] No emoji.
- [ ] Eyebrow category matches the post type (don't label a case study "ESSAY").
- [ ] All variants generated (og, linkedin, square at minimum).
- [ ] File naming convention: `<post-slug>-<variant>.png` (e.g., `taste-is-the-moat-og.png`, `taste-is-the-moat-linkedin.png`, `taste-is-the-moat-square.png`).
- [ ] Output saved to `personal/portfolio/public/covers/<slug>/` for the portfolio site to reference.

---

## Output package

1. **Layout brief** (the human-readable spec).
2. **Render-ready HTML** for each variant (or one HTML file with all variants stacked).
3. **File naming + suggested path** for the rendered images.
4. **Frontmatter snippet** to add to the post's data entry, pointing at the cover image:
   ```js
   coverImage: '/covers/taste-is-the-moat/og.png',
   coverImageVariants: {
     og: '/covers/taste-is-the-moat/og.png',
     linkedin: '/covers/taste-is-the-moat/linkedin.png',
     square: '/covers/taste-is-the-moat/square.png',
   },
   ```

---

## Do not

- Do not generate decorative gradients, particles, abstract shapes, or 3D renders on a cover. The brand is restraint.
- Do not use stock photography of any kind. The brand is anti-stock.
- Do not include faces, hands, brains, or AI-themed visual metaphors. The brand is anti-AI-stock.
- Do not stack more than 22 characters per line at the headline size.
- Do not use more than one accent color element per card.
- Do not exceed two type sizes per card (headline + footer; or headline + subtitle + wordmark counts as three only if needed).
