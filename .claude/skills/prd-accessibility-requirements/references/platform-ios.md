# iOS Accessibility Patterns (iOS 26)

## 1. Handling Translucency & Glass Effects
*   **Contrast Safeguards:** Maintain a 4.5:1 contrast ratio against dynamic or blurred backgrounds. Use solid or high-opacity backings for primary text and buttons.
*   **Reduced Transparency:** Components must automatically become "frostier" or fully opaque when the user enables the "Reduce Transparency" system setting.
*   **Contrast Borders:** Interactive elements should gain a 1-2px high-contrast border when "Increase Contrast" is enabled.

## 2. Interaction & Feedback
*   **Standard Haptics:** Use `UIImpactFeedbackGenerator` (.medium for state changes like Starring, .light for transactional taps) to provide tactile confirmation.
*   **Action Hints:** Use `accessibilityHint` to explain the *result* of an interaction (e.g., "Sets this location as the primary search area").
*   **Primary Labels:** Use `accessibilityLabel` for the primary description (e.g., "Madrid, Spain").
*   **Direct Touch:** Use `silentOnTouch` if the app provides custom audio feedback to prevent overlapping with VoiceOver.

## 3. Visual Layout & Scaling
*   **Accessibility Dynamic Type (AX1 - AX5):**
    *   **Range:** Features must support the full accessibility range from **AX1** (~165%) to **AX5** (~312%).
    *   **Compliance Bar (AX3):** Features must clear the **~235% scaling** threshold at AX3 to meet the global 200% accessibility mandate.
    *   **Stress Test (AX5):** Layouts must not break, overlap, or clip content at the maximum AX5 setting.
    *   **Implementation:** Do not hardcode row/container heights. Use vertical expansion and flexible containers.
*   **AssistiveAccess:** Support simplified layouts and enlarged targets when the system "Assistive Access" mode is active.
