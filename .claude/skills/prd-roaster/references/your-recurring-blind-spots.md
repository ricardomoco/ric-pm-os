# Recurring Blind Spots — Author's PRDs

This file catalogues patterns that have appeared in **multiple** PRDs by the same author. It is the highest-leverage reference in the roast: pointing out a single mistake is constructive feedback; pointing out a pattern across PRDs reframes the author's working method.

**This file is intentionally empty in the template.** Populate it over time as you spot repeated mistakes in your own (or your team's) PRDs. The skill becomes dramatically more useful once two or three patterns are documented here.

## Rule for adding a pattern

At least **two cited PRD instances**. One sighting is a mistake. Two is a pattern. Always cite both.

## Format for each pattern

- **Name** — Short, declarative.
- **Description** — What the mistake looks like in the PRD.
- **Why it happens** (mechanism) — What pulls the author into the trap. The mechanism matters because it tells you when to be on guard.
- **Citations** (PRDs / docs where observed, with section) — Always two minimum.
- **How to detect in a new PRD** — A concrete checklist a reviewer can run.
- **How to attack in a roast** — Quote both citations + state the inconsistency. The author cannot dismiss a pattern when both instances are visible.

## Example pattern (template)

> ### Pattern: <name>
>
> **Description:** ...
>
> **Why it happens:** ...
>
> **Citations:**
> - **[Source 1]** — quote the specific section.
> - **[Source 2]** — quote the specific section.
>
> **How to detect in a new PRD:**
> 1. ...
> 2. ...
> 3. ...
>
> **How to attack in a roast:** Quote both citations side-by-side. State the inconsistency. Ask whether the author has revised the parent doc to reflect the new commitment, or is silently overriding it.

---

## Examples of patterns worth watching for (universal)

These are *categories* of recurring mistakes the literature suggests are common. Use them as starting points to spot patterns in your own work — don't list them in this file unless you've actually caught yourself making them twice.

- **Phase compression** — pulling parent-strategy Phase 2 or 3 capabilities into a near-term commitment without acknowledging the timeline shift.
- **Backend ≠ surface** — claiming a capability is "ready" because backend / data platform has shipped it, without verifying the consuming surface (iOS / Android / Web) actually consumes it.
- **Cross-team dependency hand-wave** — listing dependencies on other teams without confirmed commitments from those teams.
- **Trust-signal proliferation** — adding a new badge / indicator / tier without acknowledging the existing ones and committing to a hierarchy.
- **Metric definition drift** — using a metric name without referencing its canonical definition, leading to disputed numbers later.
- **Implicit users** — describing user behaviour without specifying the cohort (new users? returning? specific persona?).
- **Reversibility assumed** — proposing a change that is actually hard to revert (data model migrations, search ranking changes, indexed content) without flagging the irreversibility.
- **Untested with the cohort the change targets** — research findings cited from a different cohort than the one the feature targets.

Replace this list with your own observed patterns as you accumulate them.
