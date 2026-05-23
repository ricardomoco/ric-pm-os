# C2C Marketplace Traps

Use this catalogue during Pass 4 of the roast. {{COMPANY}} is a two-sided marketplace with a long tail of private sellers, a paid PRO segment, and verticals with very different liquidity profiles (cars vs. fashion vs. electronics). The traps below are recurrent in this category and easy to miss when a PRD is framed from one side only.

---

## Two-sided incentive misalignment

**Pattern:** A feature that helps one side actively harms the other.

**Examples:**
- A "verified" badge for buyers may erode the perceived value of a paid [premium subscription], harming seller economics.
- More aggressive listing quality nudges to sellers may lower listing volume, harming buyer choice and supply liquidity.
- Photo quality scoring helps buyers evaluate but increases time-to-list, harming seller activation.

**How to attack:** For any buyer-facing improvement, force the PRD to address the seller impact (and vice versa). If the PRD only models one side, that's the trap.

**{{COMPANY}}-specific:** The verified badge PRD pattern. Risk is well-documented — see PRD's "PRO seller perception" risk row. Equivalent risks should appear in any seller-facing feature: does this hurt buyer trust?

---

## Supply/demand asymmetry

**Pattern:** A feature optimised for the side with more leverage, ignoring the side that's actually constrained.

**Examples:**
- {{COMPANY}} growth is bottlenecked by listing supply quality, but PRDs optimise buyer evaluation as if supply were unlimited.
- In low-liquidity verticals (cars at premium price), the constraint is supply count, not buyer conversion. A buyer-side feature won't move the metric.

**How to attack:** Ask which side is the bottleneck for the metric the PRD targets. If the PRD's lever doesn't touch the bottleneck, it can't move the metric materially.

---

## Trust-signal proliferation / badge cannibalisation

**Pattern:** Adding more trust signals dilutes existing ones. Buyers stop reading any badge when there are too many.

**Examples ({{COMPANY}}):**
- IDP seller component already shows: PRO badge, Top Profile ring, Official Store icon, Official Dealership icon, Business Account text. Adding "Verified" makes 6 distinct signals — buyers won't disambiguate.
- Item card already has: free shipping badge, warranty badge, refurbished badge, condition badge. Adding listing-quality badge makes 5 — same problem.

**How to attack:** Count the existing signals on the surface. If the PRD adds one without explaining what it removes (or why it's the new top of the hierarchy), badge cannibalisation is real.

---

## Power-law user distribution (median user vs top 1%)

**Pattern:** The PRD's user model implicitly assumes a typical user, but the marketplace is power-law distributed. The top 1% of sellers list >50% of items; the top 1% of buyers transact >50% of GMV.

**Examples:**
- "Sellers will appreciate the new dashboard" — depends on segment. PRO sellers vs casual sellers have radically different needs.
- "Buyers will use comparison features" — but most buyers transact <2 items/year and have no comparison need; the heavy buyers do.

**How to attack:** Ask which segment of the power-law distribution the feature targets, and what % of GMV that segment represents.

---

## Liquidity vs quality trade-off

**Pattern:** Quality improvements reduce supply quantity, which reduces liquidity, which can hurt the marketplace more than the quality gain helps it.

**Examples:**
- Mandatory photo standards may improve listing quality but kill activation rates.
- Requiring multi-dimensional condition input may improve buyer evaluation but reduce listing volume in fashion (low-stake category).
- Verifying sellers reduces fraud but slows new-seller onboarding.

**How to attack:** Demand the guardrail metric. "Listing completion rate must not drop >X%" is the right shape. PRDs without this guardrail haven't addressed the trade-off.

---

## Categorical heterogeneity (treating cars like books)

**Pattern:** A one-size-fits-all design ignores that categories have radically different evaluation needs.

**Examples:**
- A photo quality scoring model trained on fashion may misclassify cars (different aspect ratios, different "good" criteria).
- A listing quality threshold calibrated globally may exclude valid listings in low-volume categories.
- A condition taxonomy that works for phones (battery, screen, housing) is wrong for furniture (wear, fabric, frame, structural).

**How to attack:** Pick three {{COMPANY}} categories — cars, fashion, books — and ask whether the feature works in all three. If the PRD's design has implicit category assumptions, name them.

---

## Cross-side externalities

**Pattern:** A feature on one side creates side effects on the other that aren't accounted for.

**Examples:**
- Showing seller response time on the IDP creates buyer expectation; sellers can't reply within an SLA they didn't sign up for.
- Verified badges raise the floor of buyer expectation, making non-verified sellers look worse than before the badge existed.
- AI-generated listing descriptions improve completeness but homogenise seller voice, reducing the trust signal of authentic phrasing.

**How to attack:** For any feature on side A, ask what behavior changes on side B as a side effect.

---

## Network effects and cold-start

**Pattern:** Features that work at scale fail at the margin.

**Examples:**
- A listing quality model trained on category percentiles needs minimum volume per category — fails for rare collectibles.
- Recommendation personalisation needs user history — useless for new buyers.
- Verified badges on a small % of sellers create stigma for the unverified majority.

**How to attack:** Identify the cold-start case. Ask what the user experience is at week 1 vs at scale.

---

## AI-generated content displacing authentic seller voice

**Pattern:** AI features improve completeness or speed but reduce the authentic signals (first-person language, honest defect disclosure, reason-for-selling) that drive C2C trust.

**Examples:**
- AI-prefilled descriptions sound generic; buyers can't distinguish trustworthy sellers from spammy ones.
- AI-suggested titles produce keyword-stuffed listings that look like SEO bait.

**How to attack:** Ask whether the feature has a way to preserve or amplify authentic seller voice. If the metric is "completeness" alone, the trade-off is unaddressed.

---

## Goodhart-on-marketplace KPIs

**Pattern:** Marketplace metrics are particularly gameable because both sides have agency.

**Examples:**
- "Optimise badge coverage" → sellers complete fake KYC fields.
- "Optimise time-to-first-message" → automated empty messages from sellers.
- "Optimise listing photos count" → sellers add duplicate or irrelevant photos.

**How to attack:** Ask what gaming the metric would look like from each side. Sellers and buyers will both find the cheapest path to the metric.

---

## Trust-and-safety / fraud asymmetry

**Pattern:** Trust signals create attractive targets for sophisticated fraud.

**Examples:**
- A verified-seller badge is the ideal cover for a scammer who completes KYC then sells fake goods.
- Top Profile algorithms can be gamed by sellers who optimise the visible criteria without underlying trust.
- "{{COMPANY}} Pick" or quality badges become attack surfaces for listing-quality manipulation.

**How to attack:** For any trust signal, ask: what does the highest-effort fraudster do to obtain this signal? If the PRD has no answer, T&S risk is unaddressed.

---

## Review system reliability

**Pattern:** Reviews are widely treated as a trust signal, but C2C reviews have specific failure modes that PRDs ignore.

**Examples:**
- Non-transactional reviews (sellers reviewing sellers, friends reviewing each other).
- Review reciprocity (positive reviews exchanged).
- Recency bias (one bad recent review obscures hundreds of good older ones).
- Self-selection (only happy buyers leave reviews).

**How to attack:** If the PRD treats review counts or scores as a trust input, ask what fraction of reviews are transactional, what % of buyers leave reviews, and how the PRD weights recency.

---

## Pricing dynamics & price wars

**Pattern:** Features that surface price comparisons can create downward price pressure that hurts seller economics.

**Examples:**
- "Below market" indicators prompt buyers to wait for further drops.
- Price benchmarks anchor expectations, compressing margins.
- "Similar items at €X" creates a race to the bottom for sellers competing on the same SKU.

**How to attack:** Any price-transparency feature should have a "seller economics" guardrail. PRDs with only buyer-side metrics miss the supply collapse risk.

---

## Verticalisation drag

**Pattern:** {{COMPANY}} is a horizontal marketplace adding vertical-specific UX (cars, real estate, fashion). PRDs designed for one vertical may break in others.

**Examples:**
- Cars need ITV date, km, accident history. Fashion needs size system, material.
- Photo aspect ratios differ (cars horizontal, fashion vertical).
- Logistics differ (F2F for furniture, shipping for electronics).

**How to attack:** Pick the vertical the PRD didn't mention. Ask whether it works there.

---

## "Why now" without macro context

**Pattern:** PRD asserts strategic urgency without macro evidence.

**Examples:**
- "Trust is more important than ever."
- "Competitor X is making moves."
- "AI is reshaping listing creation."

**How to attack:** Demand the data. What changed in the last 6 months that wasn't true before? If the answer is "nothing measurable," the urgency is internally generated.

---

## How to deploy this catalogue in a roast

For each marketplace trap:

1. **Name** the trap (e.g. "trust-signal proliferation")
2. **Quote** the section where it surfaces
3. **State** the side effect or constraint the PRD missed

Pick the 1-3 most relevant traps for the specific PRD. Don't list all 14 — that's noise. If the PRD targets buyers without addressing seller impact, lead with two-sided incentive misalignment. If it adds a badge, lead with cannibalisation. Match the trap to the PRD's actual move.
