---
name: bio-writer
description: Draft an audience-tuned bio for any brand surface — the portfolio site About section, LinkedIn headline and About, Twitter/X bio, conference speaker blurb, advisory pitch one-pager opener, podcast guest intro, newsletter author bio. Use when the user needs a bio at a specific length (50 / 100 / 250 / 500 char OR word ranges) calibrated to a specific audience. Enforces lead-with-most-credible-fact, max three load-bearing claims, no AI slop, no "passionate about" / "thrilled to" / personality-quiz language.
metadata:
  type: writing-skill
---

# bio-writer

Bios are the highest-leverage 50–500 characters in the brand. The LinkedIn headline alone is seen by every recruiter, every prospective advisory client, and every reader of every LinkedIn post. The portfolio About is the second-most-visited page on the site after the landing hero. Get these wrong and the rest of the brand has to overcome the wrong first impression.

**Mandatory pre-flight:** Load `pm-os-public/.claude/skills/shared/post-style-guide.md` — especially §2 (the banned phrases list). Bios are the surface most contaminated by AI slop and LinkedIn-cringe; the blocklist applies maximally.

---

## Two universal rules

These are non-negotiable across every surface and every length.

### 1. Lead with the most credible single fact

Sentence 1 (or for ultra-short bios, the FIRST CLAUSE) names the most credible fact a stranger could verify. Credibility comes from concrete specifics: company name, role, product owned, MAU, headline outcome.

**Good (LinkedIn headline):**
> *"Senior PM at Wallapop (60M+ MAU) — Buyer Experience. Building AI-native PM craft in public."*

**Bad:**
> *"Passionate product leader helping teams build amazing experiences."*

The first version says four specific, verifiable things. The second says nothing.

### 2. Maximum three load-bearing claims

After the lead, name AT MOST two more facts. Bios that try to be everything to everyone become nothing to anyone. The discipline: pick the three claims that match the audience this bio is written for, and cut the rest.

Three claims = role + (proof point) + (positioning hook). Examples:
- *"Senior PM at Wallapop (Buyer Experience, 60M+ MAU)."* — role + scale proof point
- *"Shipped item-to-item ML similarity for +2.8% CVR; replatformed the listing detail page for 80% Time-to-Full-Load reduction."* — outcomes
- *"Writing about AI-native PM craft at ricardomoco.com."* — positioning hook

---

## Audience and surface matrix

Each surface has a target length and a different audience tilt.

| Surface | Length | Audience | Notes |
|---|---|---|---|
| Twitter/X bio | 160 chars | Mixed; skimmers | One clause, one outcome, one link. |
| LinkedIn headline | 220 chars | Recruiters, founders, peers | The most-seen bio on the brand. |
| LinkedIn About (opening) | First 300 chars | LinkedIn skimmers | Above the "see more" fold. Must work standalone. |
| LinkedIn About (full) | 500–2,000 chars | LinkedIn deep-readers | Can include the second + third claim, the positioning hook, and an advisory CTA. |
| Portfolio site Hero subtitle | ~120 chars | Site visitors | Lives under the wordmark on the landing. |
| Portfolio About page | 250–500 words | Site visitors who clicked About | Longest bio surface. Adopt Ricardo default voice. |
| Conference speaker blurb | 50–100 words | Conference attendees scanning a program | Lead with the talk's hook, not the speaker's role. |
| Podcast guest intro | 30–60 words | Listener at the start of the episode | One sentence the host can read aloud. |
| Advisory pitch opener | 50–100 words | Prospective client | Operator-clean preset. Lead with the problem solved, then the credentials. |
| Newsletter / Substack author bio | 100–250 chars | Subscribers | Tone-match the newsletter. |

---

## Phase 0 — Intake

Ask in one batched message:

1. **Which surface?** (Pick from the matrix above. If "other," describe length and audience.)
2. **Audience priority?** (Which one audience this bio is written FOR. If a bio is for multiple audiences, the LinkedIn About full version is the only one that can carry that — every other surface picks one audience.)
3. **What's the current bio on that surface, if any?** (For revision work.)
4. **Any updates to lead with?** (A new role, a new shipped outcome, a new piece of public-facing work like a talk or a podcast.)
5. **Include an advisory CTA?** (Only for full LinkedIn About + Portfolio About + Advisory pitch opener. Other surfaces don't have room.)

---

## Phase 1 — The lead

Output of this phase: **three lead-clause candidates**. The lead is the first 50–80 chars of the bio. Get this right and the rest writes itself.

### 1.1 Lead patterns (good)

- **Role + employer + scope:** *"Senior PM at Wallapop, Buyer Experience (60M+ MAU)."*
- **Role + outcome:** *"Senior PM. Shipped ML-driven listing similarity on Wallapop; +2.8% CVR."*
- **Role + thesis:** *"Senior PM building AI-native craft in public."*
- **Talk-titled** (for conference blurbs): *"On taste as the moat for AI-era PMs."*

### 1.2 Lead patterns (banned)

- *"Passionate about..."*
- *"Helping teams..."*
- *"Driving impact through..."*
- *"Obsessed with [users / craft / data]..."*
- *"Building the future of..."*
- *"Bridging the gap between..."*
- Any sentence starting with an adjective ("Curious," "Strategic," "Customer-obsessed")
- Any sentence that doesn't include a specific noun (a company, a product, a number)

### 1.3 Stop and pick

Output three lead candidates. User picks one before continuing.

---

## Phase 2 — The body

Output of this phase: **the full bio at the target length**.

### 2.1 Length budget

Allocate characters/words upfront. Example for LinkedIn headline (220 chars):
- Lead clause: ~80 chars
- Second claim: ~80 chars
- Positioning hook: ~60 chars

Example for full LinkedIn About (500–800 chars):
- Lead paragraph (2 sentences): ~200 chars
- Three-point body (3 short sentences or a list): ~300 chars
- Positioning hook + CTA: ~150 chars

### 2.2 Voice per surface

- **Twitter/X, LinkedIn headline, Hero subtitle, Conference blurb, Podcast intro:** Operator-clean preset (`post-style-guide.md` §4 Preset C). No humour, no asides, dense.
- **LinkedIn About full, Portfolio About page:** Ricardo default preset (Preset B). One dry-humour line allowed; honest descriptions of reality; one personal aside maximum.
- **Advisory pitch opener:** Operator-clean preset, restrained variant. Lead with the problem solved, not the credentials.

### 2.3 Numbers carry units

If a number appears, it includes:
- The unit (% / chars / users / countries).
- The context (which funnel step, which segment, which time window).

Bios that say "drove conversion" or "shipped impactful features" with no number have nothing in them. Bios that say "+12.4% CVR from listing click to transaction over Q3 2025" are unfakeable.

### 2.4 No emoji in any bio for this brand

Including in the LinkedIn headline. Some brands use one emoji effectively; this brand doesn't, because the positioning is anti-LinkedIn-cringe.

### 2.5 No interjection words

No "currently," "now," "today," "right now." These take a word and add nothing. The bio's tense is the present by default.

---

## Phase 3 — Anti-slop sweep

Run `post-style-guide.md` §2 against the bio:
- AI slop phrases (the LLM tells).
- LinkedIn-cringe phrases and patterns.
- Grandiose assumption patterns.
- Voice-killers.

Bios are the surface where these patterns are most concentrated. **Every match must be rewritten or deleted.** No exceptions.

Additionally, for bios specifically:
- Cut every adverb. (Almost every adverb in a bio is filler.)
- Cut every "very" / "really" / "extremely."
- Cut every adjective that doesn't change meaning.
- Cut "in" / "of" / "with" / "for" constructions when a simpler word works.

---

## Phase 4 — Final-pass checklist

- [ ] Lead clause is one of the good patterns from §1.1.
- [ ] At most three load-bearing claims.
- [ ] Every claim is concretely verifiable (company name, role, number, named output).
- [ ] Zero phrases from `post-style-guide.md` §2.
- [ ] No emoji.
- [ ] No "passionate" / "thrilled" / "humbled" / "excited" / "obsessed."
- [ ] No adjective-only sentence openers.
- [ ] Length is within target for the surface.
- [ ] If the bio has a CTA, the CTA is specific (a URL or a single action verb).
- [ ] The bio reads aloud without anyone wincing.

---

## Output package

Hand the user:

1. **The bio**, copy-paste ready.
2. **Character count.**
3. **Which surface it's calibrated for**, and a note if it WON'T work for another surface (e.g., "this LinkedIn headline is too long for a Twitter/X bio").
4. **A diff vs. the previous bio**, if revising one.

---

## Worked examples

### LinkedIn headline (220 char target)

**Bad (banned):**
> Passionate product leader helping marketplaces build amazing experiences. Currently at Wallapop. Obsessed with users, craft, and AI. Always learning. 🚀

**Good:**
> Senior PM at Wallapop, Buyer Experience (60M+ MAU). Shipped item-to-item ML similarity (+2.8% CVR), replatformed the listing page (80% TTFL reduction). Writing about AI-native PM craft.

### Twitter/X bio (160 chars)

**Good:**
> Senior PM at Wallapop. Building AI-native PM craft in public. ricardomoco.com

### Portfolio Hero subtitle (~120 chars)

**Good:**
> Senior PM at Wallapop. AI-native craft, shipped in public. Writing about taste, systems, and what the work actually costs.

### Conference speaker blurb (75 words)

**Good:**
> Ricardo Moço is a Senior PM at Wallapop, where he leads the buyer evaluation experience across listing detail, recommendations, and saved-items. He's shipped item-to-item ML similarity, replatformed the listing detail page for an 80% Time-to-Full-Load reduction on Android, and runs a context-engineered Personal OS for PM work that he publishes openly. His talks focus on AI-native PM craft — specifically, how to cultivate product taste in an era where code has become cheap.

### Advisory pitch opener (60 words, Operator-clean)

**Good:**
> Ricardo Moço advises early-stage product teams on AI-native craft: turning AI from a substitute for judgment into an amplifier of it. He works with seed-to-Series-B teams on PM operating systems, discovery practice, and metrics frameworks. Previously: Wallapop (60M+ MAU), Spotify, Intaker. Engagements are scoped 1–3 months, retainer or project. Inquire: ricardomoco.com/work-with-me.
