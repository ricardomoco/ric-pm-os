# PM Competencies — Example Framework

This is a default competency framework for the `feedback-provider` skill. Replace with your company's actual framework if you have one.

## How to use

The `feedback-provider` skill maps each feedback point to one of the competencies below. Tag format in output: `[Competency Name]`.

If your company has a richer framework with levels (e.g., IC3 vs IC5), extend each competency with a `## Levels` section and the rubric for each level. The skill will use those rubrics to calibrate feedback to the colleague's seniority.

## Competencies

### Ownership
Drives outcomes end-to-end. Owns the problem, the solution, and the result. Doesn't wait for someone else to unblock the work.

### Communication
Writes and speaks clearly. Tailors message to audience. Surfaces risks early. Closes loops on decisions.

### Collaboration
Works effectively across disciplines (engineering, design, data, marketing). Brings others into the problem instead of solving in isolation. Gives credit, takes blame.

### Decision-Making
Calibrates confidence to evidence. Picks reversible vs irreversible bets correctly. Doesn't paralyze on small choices, doesn't rush on big ones.

### Strategic Thinking
Connects daily work to the company's strategy. Sees second-order effects. Identifies what NOT to build with the same rigour as what to build.

### Execution
Ships. Cuts scope intelligently when needed. Maintains quality under pressure. Tracks loose ends.

### Influence
Moves the org without authority. Changes minds with evidence. Builds coalitions for hard bets.

### Growth Mindset
Seeks feedback. Updates beliefs when evidence contradicts them. Reflects on failures honestly. Coaches others.

### Customer Focus
Anchors decisions in user truth. Knows the qualitative AND quantitative shape of the user. Resists vanity metrics.

### Technical Judgment
Understands the engineering trade-offs in their domain well enough to make informed scope and sequencing calls. Doesn't over-engineer or under-engineer the spec.

---

## Mapping common feedback to competencies

| Feedback signal | Competency |
|---|---|
| "Pushed for X but didn't drive it home" | Ownership (gap) |
| "Helped peers solve hard technical problems" | Collaboration; Empowerment |
| "Made a wrong call without checking data" | Decision-Making; Customer Focus |
| "Wrote a clear, terse PRD that engineers could ship from" | Communication; Execution |
| "Stayed open to critique on the design" | Growth Mindset |
| "Connected feature to bigger strategic bet" | Strategic Thinking |
| "Brought sceptical stakeholder around" | Influence |
| "Cut scope under time pressure without losing the core" | Execution |

The skill's `Anti-Contradiction Check` step uses this mapping to flag when a Strength competency directly contradicts a Growth Area competency on the same person.
