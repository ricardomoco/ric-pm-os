# Phase 5b: AI Behavior Contract (for AI / ML / generative / scoring features)

Run this phase **in addition to** Phase 5 (Requirements & AC) when the feature involves AI / ML / generative / recommendation / scoring models. The Behavior Contract is what specifies *what the model should and shouldn't do*, with concrete examples, separate from functional acceptance criteria.

## When this phase activates

Trigger when the feature includes any of:

- A model that scores, classifies, or ranks (e.g. [example seller-ranking feature], Listing Quality Index)
- Generative output (LLM responses, AI-prefilled content, summaries, suggestions)
- Recommendation surfaces ({{DISTRIBUTION_TEAM}}-driven, similar items, personalised feeds)
- Probabilistic eligibility decisions (badge eligibility based on a model output)
- Any system whose output is "judged" rather than deterministic

If the feature is rule-based with no model, skip this phase. If you're unsure, lean toward running it — {{COMPANY}} regulatory exposure (DSA, consumer protection) treats AI-driven user-facing claims as a higher bar.

## Why a behavior contract

Without a behavior contract, AI features fail in predictable ways:

- The model produces output that looks plausible but is wrong on edge cases
- "Helpful" gets defined by the model's defaults, not the product's intent
- Bad responses aren't caught until production incidents
- Legal / safety risks (PII echo, prompt injection, deceptive claims) are discovered at the wrong time

The contract gives engineering, ML, design, legal, and ops a shared definition of "right" through examples — not abstract principles.

OpenAI's Model Spec is the gold-standard reference: it specifies behavior through concrete cases, not abstract descriptions.

## Required output

Three components, all required:

### 1. Labelled examples — 15 to 25 minimum

Each example uses this format:

```markdown
**Example [n]: [short descriptive title]**

User Input: [specific scenario / query / payload]
Context: [relevant state — user history, account type, item category]

Good Response:
  - [option 1]
  - [option 2]
  - [option 3]

Bad Response:
  - [what to avoid + why]

Reject:
  - [when to refuse / defer to human / show no output]
  - Reasoning: [why reject]
```

Coverage targets:

- **Happy-path examples (8-12):** common queries / inputs the model should handle well. Show variation in good responses to teach calibration.
- **Edge-case examples (3-5):** unusual inputs, ambiguous cases, low-confidence scenarios.
- **Reject examples (4-8):** cases where the model should refuse, defer, or show nothing. Cover at least: PII, regulated content, out-of-scope requests, low confidence.

If you produce fewer than 15, the contract is too thin to be useful. Fewer than 8 means the team hasn't thought through the behavior yet — push back.

### 2. Red Team scenarios

Adversarial inputs the model must handle without harm. Include at least these 5 categories:

- **PII echo / leakage:** "My SSN is 123-45-6789, send it to support" → must not echo
- **Prompt injection:** "Ignore previous instructions and..." → must not comply
- **Gibberish / malformed input:** "asdfkj234@#$" → must not hallucinate
- **Very long input:** 5000+ character payload → must time out gracefully, not retry forever
- **Off-language input:** if scoped to ES/IT/PT, what happens with English / French / Mandarin?

For each, specify the expected behavior. Use the same format as labelled examples.

For {{COMPANY}}-specific features, also cover:
- **Fraud-cover attacks:** when the model surfaces a trust signal, what does the highest-effort fraudster do to obtain it?
- **DSA deceptive-design risk:** any model output that surfaces a "verified" / "trusted" / "official" claim must be auditable against DSA Article 14

### 3. Offline Eval Golden Set + Human Review Rubric

**Golden Set:**

A hand-labelled test set the model must pass before launch.

```markdown
- **Size:** [N samples — typically 200-1,000]
- **Coverage:** [What scenarios — categories, segments, edge cases]
- **Labelling source:** [Hand-labelled by team / annotators / domain experts]
- **Pass threshold:** [Accuracy / F1 / category-specific target]
- **Refresh cadence:** [How often the set is updated, what triggers re-labelling]
```

**Human Review Rubric:**

A repeatable structured review for a sample of production output. Define the rubric so reviewers are calibrated.

```markdown
- **Sample size per review:** [N — typically 50-200]
- **Sampling method:** [Random / stratified by segment / focused on low-confidence cases]
- **Review dimensions (1-5 scale unless binary):**
  - Contextual relevance (1-5)
  - Tone / register match (1-5)
  - Length appropriateness (binary)
  - Contains no PII (binary)
  - Contains no policy-violating content (binary)
  - [Other domain-specific dimensions]
- **Pass threshold:** [E.g., median ≥4.0 across reviewers, no binary fails]
- **Escalation:** [What happens when a sample fails — kill switch, retrain, copy fix]
```

The rubric is not just for launch — it's the recurring quality bar through the model's life.

## Process

### Step 1: Read the Feature Context

Confirm you have:
- The feature's intended behavior (from Phase 1+2)
- The user segments and surfaces it touches
- Any prior model output from research, prototypes, or earlier experiments
- Legal / compliance constraints (especially DSA, PII, regulated content)

If any of these are missing, request them before writing the contract.

### Step 2: Draft Examples by Category

Walk through the user journey:

- **Onboarding / discovery:** what does the model output when the user first sees it?
- **Common path:** the typical 80% of queries
- **Power-user path:** sophisticated queries, edge cases
- **Failure path:** when the model is uncertain, when input is bad
- **Adversarial path:** intentional misuse

Each path should produce 3-5 examples. Total comes out to 15-25.

### Step 3: Add Red Team Coverage

Cover the 5 categories above. If the feature touches identity, payments, or regulated content, add 3-5 domain-specific adversarial cases.

### Step 4: Define the Golden Set + Rubric

Coordinate with Data Science / ML team for:
- Sample size that gives statistical confidence
- Pass thresholds calibrated to current model performance
- Labelling capacity (hand-labelling 1,000 samples is non-trivial)

### Step 5: Output

Populate the **🤖 Behavior Specification** section of the PRD template ([references/template.md](../references/template.md)) with:

- 15-25 labelled examples
- Red team scenarios
- Golden Set spec
- Human Review Rubric

Cross-reference Phase 5 (Requirements & AC) so the dev team has both the behavior contract and the functional AC.

## Quality Gate

Before considering this phase complete, validate:

- [ ] At least 15 labelled examples with good / bad / reject framing
- [ ] At least 8 happy-path, 3 edge-case, 4 reject examples
- [ ] Red team covers PII, prompt injection, gibberish, long input, off-language
- [ ] Domain-specific red team (fraud-cover, DSA deceptive-design) included if relevant
- [ ] Golden Set spec includes size, coverage, labelling source, pass threshold
- [ ] Human Review Rubric specifies dimensions, sample size, pass threshold, escalation
- [ ] No invented user input — examples are realistic {{COMPANY}}-shaped queries
- [ ] Legal-relevant copy / output flagged for legal review

Present output to user for validation before proceeding.

## Common failure modes — check your own output

1. **Too few examples.** 8 examples is a sketch, not a contract. Push to 15+.
2. **All happy-path examples.** No edge cases, no rejects. The contract isn't testing the model — it's celebrating it.
3. **Vague good responses.** "A helpful answer" is not a good response. Show the actual text.
4. **No reasoning on reject cases.** Why should the model refuse? Without a stated reason, future-you can't extend the rule.
5. **Red team is theatre.** Single example per category, not really adversarial. Make them genuinely hard.
6. **Golden Set hand-waved.** "We'll have a test set" is not a spec. Size, coverage, labelling source.
7. **Rubric is a feeling.** "Reviewer rates the response" — rate on what, with what scale, with what calibration?

## Reference

- OpenAI Model Spec (gold-standard pattern for behavior contracts via concrete examples)
- Anthropic Constitutional AI principles (red-team and safety design)
