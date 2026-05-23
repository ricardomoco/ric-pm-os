# Industry / Marketplace Landmines

Use this catalogue during the roast. These are cross-team coordination patterns, regulatory pressures, and historical context that PRDs in your workspace routinely underestimate.

**This file is intentionally generic in the template.** Replace the example landmines below with your own product/industry-specific ones — your team's PSPs, your team's compliance constraints, your team's deprecated systems, the historical context PRD authors keep forgetting. The skill becomes useful in proportion to how specific these get.

The pattern is always the same: **the PRD treats a complicated cross-team or regulated capability as a simple consumable input.**

---

## Landmine categories to populate for your domain

### 1. Regulated third-party dependencies (PSPs, KYC providers, identity vendors)

If your product depends on a regulated external provider — payment service providers, KYC vendors, AML providers, identity proofing — list them here. State for each:

- What the provider's regulatory constraints are
- What capabilities your product DOES NOT control on their side
- The pattern: PRDs that treat the provider as a black box they can ask anything of

**Template:**
> **Landmine:** [Provider X] is [type], externally owned, regulated for [law/standard]. Your company does not control [Provider X]'s verification process or API contract.
>
> **Recurring patterns:** [common PRD mistakes about this provider]
>
> **How to attack:** [what to ask in the roast]

### 2. Trust signal / badge collisions

If your product surfaces multiple "trust signals" to users (verified badges, ratings, certifications, tiers, premium statuses), list them. Each new signal must (a) state the existing ones it sits next to, (b) commit to a hierarchy, (c) say what it replaces or disambiguates.

**Template:**
> **Landmine:** The [surface, e.g. PDP, search card] already carries [N] overlapping trust concepts. Each new one risks collapsing the whole hierarchy.
>
> **Current map (as of [date]):**
> - **[Signal A]** — what it means, how it appears
> - **[Signal B]** — ...
>
> **How to attack:** Any new trust signal PRD must address all [N] existing signals explicitly. PRDs that introduce signal N+1 without that triage hit cannibalisation.

### 3. Cross-team capability hand-offs

If your product has shared surfaces owned by multiple teams (e.g. item cards rendered by Search, Listings, and Recommendations teams), list the ownership boundaries.

**Template:**
> **Landmine:** [Surface X] is jointly owned by [Team A] and [Team B]. Changes to its visual / data model require alignment.
>
> **Recurring patterns:** PRDs scoped to one team's slice that quietly affect the other team's territory.
>
> **How to attack:** Ask which team owns the change. Ask whether the other team has signed off. If no, the PRD has a dependency it has not surfaced.

### 4. Deprecation cycles and overlapping systems

If your product has overlapping or transitional systems (an old badge being deprecated while a new one rolls out, an old metric being replaced by a new one), list them. PRDs frequently reference the old system without realising it's mid-deprecation.

**Template:**
> **Landmine:** [Old system X] is being deprecated. [New system Y] is the replacement. PRDs that reference X without acknowledging the deprecation set up implementation conflicts.

### 5. Historical decisions and their reasons

If your team has made strategic decisions in the past whose reasoning is not in any current doc but matters for new PRDs ("we don't show seller phone numbers because of incident X", "we don't surface raw rating averages because of the bias finding from Q2"), list them.

**Template:**
> **Landmine:** [Decision]. **Reason:** [historical incident / research finding / regulatory ruling].
>
> **How to attack:** PRDs that re-litigate this without referencing the prior decision waste cycles.

---

## How to populate this file

1. Sit with your team's tech leads, designers, and trust/safety/legal partners for 30 minutes.
2. Ask: "What are the patterns where PMs keep proposing things that miss your constraint?"
3. Capture each landmine in one of the categories above.
4. Re-read the file every quarter — add new entries, remove ones that no longer apply.

Once populated, this becomes the single highest-leverage file in the `prd-roaster` skill.
