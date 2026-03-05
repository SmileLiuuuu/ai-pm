# Design & Handoff Reference

Conventions for visual mockups, design tokens, iteration workflow, and development handoff.

---

## Core Principle: Physical Isolation

Design files and production code are always separate artifacts:

```
docs/03_DESIGN/          ← visual iteration happens here
  design-tokens.md
  screens/
    home.html
    detail.html
    settings.html
  handoff/
    home.md
    detail.md

src/                     ← only touched after design is confirmed
```

Visual changes → edit `docs/03_DESIGN/` only.
Production implementation → only after the screen's handoff note exists and is confirmed.

---

## Design Tokens

Start every project by defining `docs/03_DESIGN/design-tokens.md`. All mockups reference these values — never hardcode one-off colors or sizes in individual screens.

```markdown
# Design Tokens — {project_id}

## Color
- Primary: #______
- Primary hover: #______
- Surface: #______
- Surface raised: #______
- Border: #______
- Text primary: #______
- Text secondary: #______
- Text disabled: #______
- Destructive: #______
- Success: #______

## Typography
- Font family: ______
- Size scale: 12 / 14 / 16 / 20 / 24 / 32px
- Weight: Regular (400) / Medium (500) / Bold (700)
- Line height: 1.4 body / 1.2 headings

## Spacing
- Base unit: 4px
- Scale: 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64px

## Border radius
- Small: ___px (inputs, chips)
- Medium: ___px (cards)
- Large: ___px (modals, sheets)

## Elevation / Shadow
- Level 1 (card): ______
- Level 2 (dropdown): ______
- Level 3 (modal): ______
```

---

## Screen Mockup Format

Each screen is one self-contained HTML file. Rules:

- **All styles inline** — no external CSS, no build tools
- **Static only** — interactions described in text comments, not implemented in JS
- **Opens in any browser** — no dependencies
- **References tokens** — use CSS variables at the top of the `<style>` block

File naming: `{screen-name}.html`
Examples: `home.html`, `onboarding-step-1.html`, `settings-notifications.html`

### HTML template

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{Screen Name} — {Project}</title>
  <style>
    /* Design tokens */
    :root {
      --color-primary: #_____;
      --color-surface: #_____;
      --color-text-primary: #_____;
      --color-text-secondary: #_____;
      --color-border: #_____;
      --radius-md: ___px;
      --space-4: 4px;
      --space-8: 8px;
      --space-16: 16px;
      --space-24: 24px;
    }

    /* Screen styles */
    body { margin: 0; font-family: ____; background: var(--color-surface); }
    /* ... */
  </style>
</head>
<body>
  <!-- Screen content -->

  <!-- INTERACTION NOTES:
    - Tapping [X] opens the detail sheet
    - Pull-to-refresh triggers data reload
    - Long-press on list item reveals delete action
  -->
</body>
</html>
```

---

## Visual Quality Standard

Mockups should be **opinionated and specific** — not wireframes, not generic UI. Apply a clear aesthetic direction:

- Choose a visual tone and commit to it (minimal / editorial / utilitarian / etc.)
- Typography choices should feel intentional — avoid system fonts
- Color usage should create hierarchy, not just fill space
- Spacing should feel designed, not default

The goal: a stakeholder looking at the mockup should immediately understand what the product feels like, not just what it contains.

---

## Iteration Workflow

```
1. Scene 3 (Interaction Design) + Scene 4 (Entity Definition) produce: page list, information hierarchy, entity model
        ↓
2. Scene 5 produces: design-tokens.md + first-pass HTML mockups
        ↓
3. Visual review: open in browser, discuss, edit HTML only
        ↓
4. Design confirmed: write handoff note in docs/03_DESIGN/handoff/
        ↓
5. Development: dev agent reads handoff note + mockup, implements in src/
        ↓
6. If visual tweaks needed post-implementation: update mockup first, then src/
```

Never jump from step 3 to step 5 without a handoff note.

---

## Handoff Note Format

File: `docs/03_DESIGN/handoff/{screen-name}.md`

```markdown
# Handoff: {Screen Name}

**Mockup:** `docs/03_DESIGN/screens/{screen-name}.html`
**Status:** Ready for development / Needs revision

## Components
- [ ] {Component name}: {brief description}
- [ ] {Component name}: {brief description}

## Key Interactions
- {Trigger} → {Result}: {any relevant state change}
- {Trigger} → {Result}: {any relevant state change}

## Entities & State Changes
- {EntityName}.{field} changes from {A} to {B} when {action}
- Reads: {list of entities/fields displayed}
- Writes: {list of entities/fields modified}

## Edge Cases
- {Condition}: {how to handle}
- {Condition}: {how to handle}

## Open Questions
- [ ] {Question that needs resolution before or during development}
```

---

## Scene 3/4 → Scene 5 Transition

Before starting mockups, confirm this checklist is complete from Scene 3 (Interaction Design) and Scene 4 (Entity Definition):

- [ ] Screen list defined (from Screen Tree in Framework PRD)
- [ ] Each screen's information hierarchy described
- [ ] Primary interactions per screen listed
- [ ] Entity model defined and validated against page structure
- [ ] Design tokens drafted (colors, type, spacing)

If any item is missing, return to the relevant scene before generating HTML.
