# Technical Hallucinations in PRDs

Use this catalogue during Pass 3 of the roast. PMs hand-wave technical complexity in predictable ways. Each pattern below is a place where the PRD asserts technical capability without naming the actual constraint.

For each hallucination, the attack format is:

1. Quote the claim
2. Name the question it dodged
3. Demand the evidence or specification needed

---

## Data availability hallucinations

### "The API just exposes that"

**Pattern:** Assumes a data field is in the payload because it logically should be.

**Examples:**
- "The IDP can consume KYC status from the seller payload."
- "Item attributes are available via the catalog service."
- "Buyer favourites count is exposed on the IDP."

**Real questions dodged:**
- Which service? Which endpoint?
- Is the field populated for *all* sellers, or only some segments?
- What's the data freshness — real-time, eventual, batch?
- Are iOS / Android / Web all currently consuming it, or is one platform behind?

**How to attack:** Demand the service name, endpoint, and a sample payload. If the PRD can't produce that, mark it as gating frontend.

---

### "The data is in the data warehouse"

**Pattern:** "We can analyse this — the data is in [DWH / Snowflake / Amplitude / data products]."

**Examples:**
- "We'll segment by KYC status using Snowflake."
- "Amplitude has the events we need to measure this."
- "Data products has badge eligibility computed."

**Real questions dodged:**
- Is the field populated *historically* or only going forward?
- Is the join key reliable across systems?
- What's the latency from event to query availability?
- Is the field used by anyone else (so its semantics are stable) or new?

**How to attack:** Ask what query you'd write. If the PRD can't write the SQL, the data-availability claim is uncertain.

---

### "Already implemented in backend"

**Pattern:** Treats backend implementation as data readiness on the surface.

**Examples:**
- "KYC is implemented — backend confirmed."
- "DSA KYB pipeline is in place."
- "Top Profile rule engine is live."

**Real questions dodged:**
- "Implemented in backend" ≠ "exposed via API the IDP can consume"
- "Exposed" ≠ "consumed by all client platforms"
- "Consumed" ≠ "cache-coherent and refresh-respecting"

**How to attack:** Force the path: storage → service exposure → API consumed by IDP → rendered to user. Where on this path is the work actually done? The "iOS gap" pattern is exactly this.

---

## ML hallucinations

### "ML can do this"

**Pattern:** Asserts an ML capability without scoping the model class, training data, or operational constraints.

**Examples:**
- "ML photo quality scoring will rate listing photos."
- "An ML model will personalise the seller trust signals."
- "We'll use ML to predict which buyers are likely to convert."

**Real questions dodged:**
- What's the **target variable**? What does "quality" or "trust" or "likelihood" decompose to as a label?
- What's the **training set**? Where do labels come from? How many positives and negatives?
- What's the **model class**? GBT? Deep model? Why?
- What's the **feature set**? Where do those features live? Are they computable at inference time?
- What's the **inference latency budget**? On what surface?
- What's the **interpretability requirement**? Will operators / sellers need to know why a score was assigned?
- What's the **cold-start behaviour** for new sellers/listings/buyers?
- What's the **retraining cadence**? Drift monitoring?

**How to attack:** Pick the most consequential of these and demand the answer. If the PRD has no answer, ML is aspirational, not specified.

---

### "The model will personalise"

**Pattern:** "Personalisation" used as a stand-in for an unspecified ML capability.

**Examples:**
- "Recommendations will be personalised to the buyer."
- "The badge order will adapt to user context."

**Real questions dodged:**
- Personalised on what features? Past behaviour, demographics, session?
- What's the cold-start strategy for users without history?
- What's the privacy boundary?
- Does it require a logged-in identity or is it session-based?

**How to attack:** Personalisation is a UX claim. Force the underlying ML claim out.

---

### "Real-time"

**Pattern:** Claims real-time updates without latency budget.

**Examples:**
- "Badge eligibility updates in real-time when KYC completes."
- "The model scores listings in real-time."
- "Quality signals refresh in real-time on every page view."

**Real questions dodged:**
- What does "real-time" mean? Sub-second? Sub-minute? Sub-hour?
- Is it event-driven or polled?
- What's the cost per inference?
- What happens during downstream service outage?

**How to attack:** Force a number. "Real-time" without a latency budget is decoration.

---

### "We'll use feature importances to interpret the model"

**Pattern:** Treats SHAP / feature importances as user-facing explainability.

**Examples:**
- "Sellers can see which behaviours improved their score via feature importances."
- "Buyers see why a listing is recommended via the top 3 features."

**Real questions dodged:**
- Feature importance ≠ user-facing reason. They're high-dimensional, often counter-intuitive.
- How do you translate "response_time_p90 contributed +0.12 to logit" into seller-friendly copy?
- Are the importances stable across model retrainings?

**How to attack:** Ask for an example of the user-facing copy derived from the model output. The gap is usually obvious.

---

## Infrastructure hallucinations

### "It's just a feature store entry"

**Pattern:** Assumes the feature store will accommodate any feature you want to compute.

**Examples:**
- "Add 'avg photo count per seller' to the feature store."
- "Compute 'days_since_last_response' as a real-time feature."

**Real questions dodged:**
- Does the feature store support point-in-time correctness for training?
- Is the feature offline-online consistent?
- What's the backfill cost?
- Who owns the feature? Schema versioning?

**How to attack:** Ask whether anyone has shipped a feature to this feature store before. If not, infrastructure is aspirational.

---

### "We'll add it to the data pipeline"

**Pattern:** "Just add a column / event / table" with no acknowledgement of pipeline ownership.

**Examples:**
- "Log the badge tap event."
- "Add a 'verification_source' column to the seller table."
- "Track AI-prefill modification rate."

**Real questions dodged:**
- Who owns the pipeline?
- What's their backlog priority?
- What's the lead time?
- Does the event/column need cross-team schema alignment?

**How to attack:** Ask who owns it and when they're delivering. PRDs that say "we'll log this" without an owner are deferring the work to read-time.

---

## Performance hallucinations

### "The IDP doesn't degrade in performance"

**Pattern:** Adds a guardrail without specifying the budget.

**Examples:**
- "Time to Full Display must not increase."
- "No performance degradation on the IDP."
- "Latency unchanged."

**Real questions dodged:**
- What's the current LCP / TTI / TTFD baseline?
- What's the budget delta the PRD will tolerate? +0ms? +50ms? +5%?
- Per platform — iOS, Android, web?
- What's the rollback threshold if degradation is observed?

**How to attack:** Ask for the number. If "no degradation" is the budget, the rollback condition is undefined.

---

## Experiment design hallucinations

### "+X% expected uplift"

**Pattern:** Asserts an expected effect without confidence interval, sample size, or duration math.

**Examples:**
- "+1-2% CVR expected based on 2023 experiment."
- "Expected: +2% AOV per transaction."
- "+5% Purchase Intention uplift."

**Real questions dodged:**
- What's the standard error on the prior estimate?
- What sample size is needed to detect the smallest meaningful effect at 80% power, 95% confidence?
- How long does the experiment need to run at current traffic to reach that sample?
- Is the effect-size assumption transferred from a different segment / country / device?

**How to attack:** Demand the power analysis. If the PRD has no math, the expected impact is a wish.

---

### "Sample size will be sufficient"

**Pattern:** Hand-waves stats without computation.

**Examples:**
- "Sufficient sample within 14 days."
- "Power should be adequate."
- "Volume is high enough to detect."

**Real questions dodged:**
- For *which* metric? Primary, secondary, segment-level?
- Detect *what* effect size?
- At what power and confidence?

**How to attack:** Treat as a P0 gap. Sample-size hand-wave invalidates the experiment design.

---

### "We'll segment by [variable]"

**Pattern:** Promises post-hoc segmentation without acknowledging multiple-comparisons or segment-level power.

**Examples:**
- "We'll segment by category."
- "Slice by buyer type."
- "Compare verified vs non-verified."

**Real questions dodged:**
- How many segments? With what multiple-comparisons correction?
- Does each segment have enough volume to be statistically meaningful?
- Were segments pre-registered?

**How to attack:** Ask which segments are pre-registered (legitimate) vs which are post-hoc dredging (Texas sharpshooter from `fallacies.md`).

---

## Refresh & consistency hallucinations

### "Eventually consistent is fine"

**Pattern:** Doesn't specify what "eventually" means or what the staleness tolerance is.

**Examples:**
- "Badge updates after KYC completion (eventually consistent)."
- "Listing quality refreshes within an event-driven cadence."

**Real questions dodged:**
- 5 seconds? 5 minutes? 1 hour? 24 hours?
- What does the user see during the lag?
- What's the buyer-facing risk during the inconsistency window? (E.g. seller revoked but badge still shown.)

**How to attack:** Ask for the staleness tolerance and the user-facing behaviour during the lag.

---

### "Real-time revocation"

**Pattern:** Promises that bad-actor states are revoked instantly without specifying the path.

**Examples:**
- "If KYC is revoked, the badge disappears immediately."
- "Fraud-flagged sellers lose the badge in real-time."

**Real questions dodged:**
- What event triggers the revocation? Is it polled or pushed?
- What's the latency from T&S flag → IDP render?
- What's the cache invalidation strategy?

**How to attack:** Cache invalidation is one of the two hard problems in CS. Trust the PRD only when it shows the invalidation path.

---

## Dependency hallucinations

### "Coordinated with [other team]"

**Pattern:** Asserts cross-team alignment without naming the deliverable, owner, or timeline.

**Examples:**
- "Coordinated with Search team on ranking integration."
- "{{SELLER_TEAM}} will deliver the structured attributes."
- "Artisans will expose DSA KYB status."

**Real questions dodged:**
- What did the other team commit to, in writing?
- By when?
- Is it on their roadmap with a JIRA epic / quarterly goal?
- Who is the named PM/EM owner on the other side?

**How to attack:** Ask for the linked Jira / Confluence commitment from the other team. If it's only "we discussed it," the dependency is unstaffed.

---

### "Will be exposed by [team]"

**Pattern:** Assumes another team will build something on this PRD's timeline.

**Examples:**
- "DSA KYB endpoint will be exposed by Artisans."
- "Photo quality ML scoring will be built by ML team."

**Real questions dodged:**
- Is it on their backlog?
- What's their priority for it?
- Is your timeline compatible with theirs?

**How to attack:** A dependency on another team's unscheduled work means your PRD's timeline is fictional.

---

## How to deploy this catalogue in a roast

For each technical hallucination:

1. **Quote** the exact claim
2. **Name** which dodge it is (data availability, ML scoping, latency, sample size, dependency, etc.)
3. **State** the specific question the PRD didn't answer

Don't list every hallucination — pick the 3-7 most consequential. If the PRD has 20 hallucinations, the roast is "the technical scoping is incomplete; here are the 5 worst." Bury readers and they ignore the message.
