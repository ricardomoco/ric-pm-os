# Global Accessibility Standards (2026)

## 1. Web Standards (WCAG 2.2+ & ARIA 1.3)
The current legal and technical baseline is **WCAG 2.2 Level AA**.

### Key Technical Attributes:
*   **`aria-description` (ARIA 1.3):** Use for direct context (e.g., "Default location") without hidden elements.
*   **`AriaNotify` API:** Modern successor to `aria-live` for cleaner state change announcements. Fallback: `aria-live="polite"`.
*   **Focus Appearance:** Must meet WCAG 2.2 strict standards. Use a minimum 2px solid high-contrast border.
*   **Contrast Ratios:** Text 4.5:1, Icons/UI 3:1. Must be validated under High Contrast and System Inversion modes.

## 2. Universal Principles
*   **Color-Independent State:** Information must never be conveyed by color alone (e.g., Starred vs Unstarred must be structurally different).
*   **Visual Scaling:** Support **200% scaling** system-wide. Layouts must wrap/truncate without overlap.
*   **Touch Targets:** 
    *   **iOS:** 44x44pt minimum.
    *   **Android:** 48x48dp minimum.
*   **Bold Text Support:** Respect system-wide "Bold Text" settings without layout breakage.
