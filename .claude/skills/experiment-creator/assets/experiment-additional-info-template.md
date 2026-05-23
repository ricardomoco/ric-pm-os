# Experiment Additional Information Template

Use this template for `customfield_{{CUSTOM_FIELD_ID}}`. Fill each section from the PRD; mark anything not yet defined as TBD.

```
## Control (Baseline)
[Describe what users in the control group see/experience — the current state before the change.]

## Variant A (Treatment)
[Describe what users in Variant A see/experience — the new solution from the PRD.]

## Experiment Key
Baseline: `[feature_slug]_control`   ← TBD: to be confirmed with engineering
Variant A: `[feature_slug]_variant_a` ← TBD: to be confirmed with engineering

## Segmentation
TBD — to be defined with Data team (trigger event, audience filters, split %)

## Min App Versions
TBD — to be confirmed at release
```

**Slug conventions:** derive a snake_case slug from the feature name.
Examples: `example_feature_v1`, `semantic_search_v2`, `seller_badge_trust`
