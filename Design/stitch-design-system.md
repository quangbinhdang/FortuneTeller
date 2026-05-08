---
name: The Design System
colors:
  surface: '#180f24'
  surface-dim: '#180f24'
  surface-bright: '#3f354c'
  surface-container-lowest: '#130a1f'
  surface-container-low: '#21172d'
  surface-container: '#251b31'
  surface-container-high: '#30253c'
  surface-container-highest: '#3b3048'
  on-surface: '#eddcfb'
  on-surface-variant: '#d3c4b5'
  inverse-surface: '#eddcfb'
  inverse-on-surface: '#362c43'
  outline: '#9b8f81'
  outline-variant: '#4f453a'
  surface-tint: '#eebe7f'
  primary: '#f2c283'
  on-primary: '#452b00'
  primary-container: '#d4a76a'
  on-primary-container: '#5b3c07'
  inverse-primary: '#7b5822'
  secondary: '#d3beeb'
  on-secondary: '#38294d'
  secondary-container: '#524267'
  on-secondary-container: '#c4b0dd'
  tertiary: '#d2cab0'
  on-tertiary: '#35301e'
  tertiary-container: '#b6af96'
  on-tertiary-container: '#47422f'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffddb3'
  primary-fixed-dim: '#eebe7f'
  on-primary-fixed: '#291800'
  on-primary-fixed-variant: '#60400c'
  secondary-fixed: '#eddcff'
  secondary-fixed-dim: '#d3beeb'
  on-secondary-fixed: '#231437'
  on-secondary-fixed-variant: '#4f4065'
  tertiary-fixed: '#ebe2c8'
  tertiary-fixed-dim: '#cec6ad'
  on-tertiary-fixed: '#1f1c0b'
  on-tertiary-fixed-variant: '#4c4733'
  background: '#180f24'
  on-background: '#eddcfb'
  surface-variant: '#3b3048'
typography:
  display-lg:
    fontFamily: EB Garamond
    fontSize: 48px
    fontWeight: '500'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: EB Garamond
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
  headline-md:
    fontFamily: EB Garamond
    fontSize: 24px
    fontWeight: '400'
    lineHeight: 32px
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.1em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  margin-safe: 24px
  gutter: 16px
  section-gap: 48px
---

## Brand & Style

This design system is built upon a foundation of "Ethereal Ritualism." It seeks to bridge the gap between the ancient arcane and modern luxury, creating an environment that feels like a private, candlelit sanctuary. The brand personality is wise, serene, and profoundly premium, avoiding the tropes of dark occultism in favor of celestial wonder.

The visual style employs a refined **Glassmorphism** approach combined with **Tactile** elements. Interface surfaces should feel like semi-translucent obsidian or smoked glass, allowing subtle, animated "starlight" and "constellation" patterns to bleed through from the background. The emotional goal is to evoke a sense of quiet introspection and the feeling that the user is interacting with something sacred and rare.

## Colors

The palette is rooted in the depth of the night sky and the warmth of a flickering flame. 

- **Primary (Gold):** Used for critical actions, headings, and significant iconography. It represents the "light" of knowledge.
- **Secondary (Deep Violet):** A transitional shade for container backgrounds and elevated surfaces to prevent the UI from feeling flatly black.
- **Tertiary (Starlight):** A very soft, warm off-white used for high-readability body text and subtle dividers.
- **Neutral (Midnight):** The absolute background foundation.

Gradients should be used sparingly, primarily as radial "candlelight" glows (#D4A76A at 10% opacity) behind key focal points to simulate the soft illumination of a ritual space.

## Typography

The typographic hierarchy centers on the contrast between the historic weight of a serif and the clarity of a modern sans-serif. 

**EB Garamond** is utilized for all display and headline roles. It should be treated with generous leading to maintain a poetic, airy feel. For the most prominent titles, a slight negative letter-spacing adds a contemporary editorial touch.

**Manrope** provides the functional backbone for the design system. Its geometric yet friendly structure ensures that complex readings or celestial data remain legible even on smaller mobile screens. All labels and instructional micro-copy use Manrope with increased letter-spacing to mirror the precision of astronomical charts.

## Layout & Spacing

This design system utilizes a **fixed-width container** model for mobile-first delivery, with a 12-column fluid grid for tablet and desktop views. The spacing rhythm is strictly based on an 8px scale.

To reinforce the premium aesthetic, "White Space" (or rather, "Midnight Space") is treated as a primary design element. Margins are intentionally wide (24px) to prevent the UI from feeling cluttered. Elements should be grouped into logical "clusters" separated by significant vertical gaps to allow the background constellation patterns to breathe and act as visual anchors.

## Elevation & Depth

Hierarchy in this design system is achieved through **translucency and outer glows** rather than traditional drop shadows.

- **Level 1 (Base):** The #0C0418 midnight background.
- **Level 2 (Containers):** Semi-transparent #1A0B2E (60% opacity) with a 12px backdrop blur. Borders are 0.5px solid gold (#D4A76A) at 30% opacity.
- **Level 3 (Interactive/Active):** Surfaces that are being interacted with gain a subtle "Golden Aura"—a soft radial outer glow of #D4A76A with a 20px spread and 15% opacity.

Avoid harsh, opaque cards. Elements should appear to float within the space, overlapping like veils of smoke or silk.

## Shapes

The shape language is "Sophisticated Softness." Corners are never sharp (which feels aggressive) nor fully circular (which feels too playful/app). 

A consistent **16px (1rem)** corner radius for cards and major containers provides a modern, high-end feel. For interactive elements like buttons, a slightly more pronounced radius is used to invite touch, while maintaining the geometric elegance of the overall system. Dividers should never be solid lines; they are either 1px paths that fade out at the edges or thin constellation lines with "star" nodes at the intersections.

## Components

### Buttons
Primary buttons feature a ghost-style gold border (1px) with a subtle inner glow. The text is always in the primary gold. Upon hover or press, the button fills with a soft, semi-transparent gold gradient (10% opacity) to simulate a glowing ember.

### Cards & Ritual Slots
Cards use the Glassmorphism specification. For "Tarot" or "Rune" slots, use a 1px dashed gold border to represent an empty space waiting to be filled. When filled, the card should have a soft "aura" glow.

### Input Fields
Inputs are underlined rather than boxed, using a 1px gold line that glows slightly when focused. Labels float above the line in the "label-sm" Manrope style.

### Constellation Progress Bars
Instead of a solid bar, progress is shown as a thin gold line connecting points (stars). As progress increases, the stars light up and the line becomes solid gold.

### Navigation
The navigation bar is a floating glass element at the bottom of the screen, utilizing gold iconography with a "halo" effect on the active state. Icons should be thin-line style to match the celestial theme.