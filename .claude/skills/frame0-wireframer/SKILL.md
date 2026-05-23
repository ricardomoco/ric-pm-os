---
name: frame0-wireframer
description: High-fidelity product wireframing and flow mapping using Frame0. Use when visualizing user journeys, mapping PRD requirements to UI states, or creating clean, state-driven mockups for mobile and web features.
---

# Frame0 Wireframer

This skill transforms abstract product requirements (PRDs) into high-fidelity, state-driven visual flows using Frame0. It prioritizes logical clarity, precise mathematical alignment, and total requirement coverage.

## Core Principles

### 1. Atomic State Separation (Anti-Clutter)
*   **Unique Page per State**: NEVER overlap frames or elements representing different points in time on the same canvas. Use `add_page` for every distinct UI state (e.g., "Page 1: Empty", "Page 2: Error State").
*   **Frame Naming**: Every frame must have a semantic, requirement-linked name (e.g., "Frame 1: Discovery State - P0").
*   **Coordinate Integrity**: Within a frame, ensure elements do not overlap unless intended (e.g., icon on top of a button).

### 2. Precise Alignment & Grids
*   **Columnar Consistency**: Define a mathematical grid for common elements (e.g., Icons at x=15, Labels at x=45, Actions at x=280).
*   **Mathematical Spacing**: Use consistent delta-Y values for list rows (e.g., 40px height per row).
*   **Vertical Rhythm**: Align headers, inputs, and footers consistently across all pages to ensure smooth transitions when switching between states.

### 3. P0 Requirement Traceability
*   **Visual Mapping**: Every visual component must map to a specific P0 Acceptance Criteria.
*   **Technical Annotations**: Use `create_text` in a high-contrast color (e.g., #13C1AC) to label hidden or behavioral requirements (e.g., "P0: Focus transitions to Input on tap").
*   **Accessibility Labels**: Explicitly draw and label touch target hit-boxes (e.g., 44x44dp) if required by the PRD.

## Workflow

1.  **State Audit**: Extract all UI-related states from the PRD (Success, Loading, Empty, Transition, Edge Case).
2.  **Define the Grid**: Establish the X-coordinates for the feature's layout columns.
3.  **Execute State-by-State**: 
    *   Call `add_page` for State 1.
    *   Call `create_frame` (Mobile/Desktop) and build the UI.
    *   Repeat for all identified states.
4.  **Flow Mapping**: On a master canvas (or via annotations), illustrate the triggers (e.g., "Tap X -> Transitions to Page 3").
5.  **Audit**: Cross-reference the final visual set against the PRD's P0 requirements.

## Geometric Fidelity
If the icon library is insufficient for filled/empty states or custom shapes, use `create_polygon` with precise point arrays to ensure the visual logic is unmistakable.
