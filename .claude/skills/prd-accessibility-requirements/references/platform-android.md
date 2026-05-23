# Android Accessibility Patterns (Android 16/17)

## 1. UI & Semantics
*   **Pane Identification:** Use `setAccessibilityPaneTitle()` (or `paneTitle` in Compose) to identify dynamic menus or list updates to TalkBack.
*   **Button Descriptions:** Provide localized `contentDescription` for all interactive icons.
*   **Focus Management:** Ensure focus moves logically to the next item or header after an action (like deletion) rather than resetting.

## 2. Adaptive & Dynamic UI
*   **Adaptive Layouts:** Build using **Window Size Classes**. Orientation locks (portrait only) are deprecated.
*   **Dynamic Color:** Use **Material 3 Dynamic Color** tokens to automatically maintain contrast across system-defined themes (Dark/Light/High Contrast).
*   **Predictive Back:** Support the system-wide predictive back gesture for consistent navigation.
