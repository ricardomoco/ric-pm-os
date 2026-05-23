---
name: prd-accessibility-requirements
description: Generate high-quality, adapted, and prioritized accessibility acceptance criteria for {{COMPANY}} features using 2026 standards (WCAG 2.2+, ARIA 1.3, iOS 19/20, Android 16/17).
---

# PRD Accessibility Requirements Skill

This skill helps {{COMPANY}} PMs and AI agents scan feature descriptions or PRDs to generate standardized, platform-specific accessibility Acceptance Criteria (AC).

## Workflow

1.  **Analyze Feature:** Identify all interactive elements (buttons, inputs, sliders, lists), dynamic state changes (starred, deleted, filtered), and visual information.
2.  **Select Platforms:** Determine if the feature applies to Web, iOS, and/or Android.
3.  **Cross-Reference Standards:** 
    *   Load [standards-2026.md](references/standards-2026.md) for universal and Web (ARIA 1.3) requirements.
    *   Load [platform-ios.md](references/platform-ios.md) for iOS 19/20 specific patterns.
    *   Load [platform-android.md](references/platform-android.md) for Android 16/17 specific patterns.
4.  **Generate AC Table:** Create a table with the following mandatory columns:
    *   **Requirement:** The accessibility goal.
    *   **User Story:** "As a [user type], I want [action] so that [benefit]."
    *   **Platform:** Web, iOS, Android, or All.
    *   **Importance:** P0 (Blocker) to P2.
    *   **Acceptance Criteria:** Specific, testable technical requirements (e.g., specific ARIA attributes or platform APIs).
    *   **Notes:** Contextual rationale (e.g., why .medium haptic was chosen).

## Core Principles to Enforce

*   **No Binary States:** State changes (Success/Error/Saved) must have both visual and non-visual (audio/tactile) confirmation.
*   **Semantic Weight:** Use heavier feedback (e.g., .medium haptics or higher priority announcements) for persistent state changes (like Starring) vs. transactional ones.
*   **Adaptive by Default:** Ensure ACs mandate support for 200% scaling and system-wide high contrast modes.
*   **Localized Semantics:** ACs must specify that all screen reader labels (`aria-label`, `contentDescription`) must be localized.

## Example Output Format

| Requirement | User Story | Platform | Importance | Acceptance Criteria | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Dynamic Announcements** | **As a** screen reader user, **I want** to hear when an item is saved... | **All** | **P1** | State changes must be announced. (Web) Use `AriaNotify` API. (Android) Use `setAccessibilityPaneTitle`. (iOS) Trigger `.medium` impact haptic. | .medium used for state-change weight. |
