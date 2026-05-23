# Frame0 Layout & Alignment Standards

## Mobile Grid (320px Frame)
Use these standard column offsets to ensure vertical rhythm across all screens.

| Alignment Role | X-Coordinate (Left) | Component Type |
| :--- | :--- | :--- |
| **Gutter/Primary Icon** | 15 | Back arrows, leading list icons. |
| **Primary Content** | 45 | Row text, list labels, input values. |
| **Secondary Action** | 250 | Checkboxes, Star toggles, status dots. |
| **Final Action** | 285 | Delete (X), chevron-right, info icons. |

## Common Component Primitives

### Standard Row
*   **Height**: 40px - 48px.
*   **Text Size**: 14px.
*   **Touch Target**: Ensure hit-area extends to 44px height.

### Input Field
*   **Tool**: `create_rectangle`.
*   **Corners**: `[20, 20, 20, 20]` (Rounded Pill style).
*   **Height**: 44px.
*   **Fill**: `#F2F2F2`.

### Primary Button
*   **Tool**: `create_rectangle`.
*   **Corners**: `[25, 25, 25, 25]`.
*   **Fill**: `#13C1AC` (Brand Teal).
*   **Text Color**: `#FFFFFF`.

## Technical Annotation Style
When highlighting P0 requirements that are not visually obvious:
*   **Color**: `#13C1AC` (Solid) for text.
*   **Transparency**: `#13C1AC22` for hit-box rectangle overlays.
*   **Font Size**: 10px - 12px.
