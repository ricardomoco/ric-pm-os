# Journey Stage Mapping

Every assumption must be anchored to a specific stage of the user's journey — *assuming the feature is already live*. This forces story-mapping thinking and surfaces assumptions that a flat list misses.

Use this file when you're deciding which journey stages apply to a given feature, or when you need prompts for what to look for at each stage.

---

## Why journey stages matter

A flat list of assumptions tends to cluster at "will users want this?" (pure Desirability). Walking the journey stage by stage surfaces assumptions the author never thought to articulate, because they were embedded in the seam between two stages — discovery-to-evaluation, evaluation-to-action, action-to-repeat.

The question to ask at *every* stage: **what needs to be true for the user to reach the next stage successfully?**

---

## Default generic template (fallback)

If the feature is genuinely general-purpose, use this 5-stage template:

1. **Awareness** — The user learns the feature exists.
2. **Discovery** — The user finds the entry point in-product.
3. **Evaluation** — The user decides whether to engage.
4. **Action** — The user uses the feature for the first time.
5. **Post-Action** — The user returns, repeats, or shares.

But this template is **the fallback, not the default.** Most features have a journey that deviates from this, and the deviation is where the interesting assumptions live.

---

## Adapted journey templates by feature type

### Entry-point / visibility features (badges, banners, labels)

Users don't "journey" through these — they encounter them. Adapted stages:

1. **Eligibility** — the feature applies to this item/seller/context
2. **Rendering** — the UI renders correctly in this surface and context
3. **Perception** — the user notices the element
4. **Interpretation** — the user understands what it means
5. **Behavioral impact** — the user changes their downstream action
6. **Second exposure** — the user encounters the same element again and it still works (comprehension compounds, doesn't erode)

Example: **[verified badge feature] on IDP.** Perception stage assumption: "We believe buyers scanning the IDP will notice the badge within the first 10 seconds of view time, without it competing with existing trust signals."

### Transactional / conversion-loop features (checkout, offer, unreserve)

1. **Trigger** — the state that brings the user into this flow
2. **Action initiation** — the user attempts the action
3. **System response** — success, blocked, partial
4. **Resolution path** — the user resolves or abandons
5. **Return state** — the user ends up somewhere coherent

Example: **Unreserve error bottom sheet.** Resolution path assumption: "We believe sellers who tap the CTA on the bottom sheet will successfully cancel the shipment within one session, without returning to the IDP without action."

### Organization / personalization features (Saved Items, Favorites, saved searches)

1. **Creation / setup** — the user creates the organizing container
2. **Population** — the user adds items
3. **Maintenance** — the user organizes, renames, cleans up
4. **Return / recall** — the user comes back to use it
5. **Act on** — the user converts from the organized state (transact, share, compare)

Example: **Saved Items.** Return/recall stage assumption: "We believe users who create a list will return to it within 7 days of creation at least once, rather than forgetting it exists."

### Retrieval / discovery features (search, recommendations, filters)

1. **Intent formation** — the user has a goal or query in mind
2. **Query / signal emission** — the user expresses the intent
3. **Result display** — the system returns candidates
4. **Evaluation of results** — the user scans and judges
5. **Selection or refinement** — the user clicks, refines, or abandons
6. **Post-selection outcome** — the selected result meets intent

Example: **2-line title in item cards.** Evaluation of results assumption: "We believe the longer title reduces pogo-sticking (click → bounce) because buyers have enough information to pre-qualify before opening the IDP."

### Backend / performance features (observability, rearchitecture, API changes)

The "user" is often the end-user experiencing a performance symptom, or an internal user (support, data team). Adapted stages:

1. **Precondition state** — baseline performance / behavior before the change
2. **Event / interaction** — the user does the thing that exercises the system
3. **System response** — the change fires correctly
4. **User-perceived outcome** — the change manifests (or doesn't) to the end user
5. **Aggregate effect** — across sessions, the measured improvement materializes
6. **Observability** — the team can detect regressions

Example: **IDP Performance — TTFD baseline.** Observability stage assumption: "We believe the newly instrumented TTFD metric captures the same latency user-perceived slowdowns that drove the original performance complaints, rather than a proxy that misses the actual pain."

### Trust / credibility features (verified sellers, reviews, KYC)

1. **Qualification** — the seller or content qualifies for the signal
2. **Verification** — the signal is generated correctly and is defensible
3. **Display** — the signal reaches the buyer at the right moment
4. **Buyer interpretation** — the buyer understands what the signal means
5. **Buyer behavior change** — the signal shifts the buyer's action
6. **Seller feedback loop** — the seller sees the benefit and sustains qualifying behavior

---

## Process for choosing stages

1. Read the PRD and identify the **type of feature** (map to a template above).
2. Draft the stages specific to this feature. Use the feature's actual surfaces and user actions as stage names where possible (e.g. "Create List" not "Action").
3. **State the stages at the top of your output** so the user can correct them before you proceed.
4. For each stage, ask *what needs to be true for the user to reach the next stage?* and capture 2–5 assumptions across different types.

---

## Anti-patterns

- **Stages that match the implementation, not the user.** "Backend call 1 → Backend call 2 → Render" is not a journey. The user doesn't care about your architecture.
- **One stage dominates.** If 80% of your assumptions are in "Evaluation," you didn't actually walk the journey — you wrote a flat list and attached the same stage to everything.
- **Stages too coarse.** "Use the feature" is one stage hiding five. Break it down until each stage has a distinct success condition.
- **Stages too fine.** 12 stages for a bottom sheet is over-engineering. 4–7 stages is the usual sweet spot.
