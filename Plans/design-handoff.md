# FortuneTeller — Design Handoff

## Stitch Project

- **Resource name**: `projects/3416260557519304676`
- **Numeric ID**: `3416260557519304676`
- **Title**: FortuneTeller
- **Visibility**: Private
- **Device type**: MOBILE

## Design System

- **Asset ID**: `assets/bb0c547e7bf2459598808d5061677dc7`
- **Display Name**: "The Design System"
- **Design Language**: "Ethereal Ritualism" — Glassmorphism, candlelit sanctuary, celestial wonder
- **Color Mode**: DARK (with light variant for splash)
- **Headline Font**: EB Garamond (serif, elegant)
- **Body Font**: Manrope (sans-serif, legible)
- **Label Font**: Manrope
- **Roundness**: ROUND_EIGHT (16px corner radius)
- **Primary Color**: #D4A76A (Golden)
- **Secondary**: #1A0B2E (Deep Violet)
- **Tertiary**: #F4EBD0 (Starlight)
- **Neutral**: #0C0418 (Midnight)
- **Background**: #180f24

### Key Tokens

| Token | Value |
|-------|-------|
| `primary` | #f2c283 |
| `primary-container` | #d4a76a |
| `surface` | #180f24 |
| `surface-container` | #251b31 |
| `on-surface` | #eddcfb |
| `on-surface-variant` | #d3c4b5 |
| `secondary` | #d3beeb |
| `secondary-container` | #524267 |

## Screens Generated

### App Icon
- **Screen ID**: `b89bd7f196304828ae4c2d80c8283e6d`
- **Type**: IMAGE (1024×1024 square)
- **Description**: Midnight-purple background with golden celestial compass-rose emblem (starburst + moon crescents + runes). Full-bleed, iOS squircle safe.
- **Export**: ✅ Exported → `Assets.xcassets/AppIcon.appiconset/AppIcon.png` (1024×1024, upscaled from Stitch 512×512 download — quality debt: re-export native 1024×1024 when available)
- **Status**: Done

### Splash / Launch Screen (Dark)
- **Screen ID**: `22dd8d970c534d78ac8555c83fbede3e`
- **Type**: DESIGN (MOBILE portrait, 706×1600)
- **Description**: Midnight-purple background with constellation pattern, "Fortune Teller" wordmark in EB Garamond gold with glow, celestial astrolabe illustration below, "The stars know" tagline at bottom.
- **Export**: ✅ Exported → `Design/splash-dark.png` (160 KB)
- **Status**: Done

### Splash / Launch Screen (Light)
- **Screen ID**: `466b83be6cb246419a73587466b78135`
- **Type**: DESIGN (MOBILE portrait, 780×1768)
- **Description**: Warm ivory background (#F4EBD0) with faint golden constellation pattern, "Fortune Teller" wordmark in deep midnight-purple (#3B1F6E) serif with subtle shadow, amber-gold astrolabe line-art at 60% opacity, "The stars know" tagline in soft purple (#6B5485).
- **Export**: Screenshot available (not yet exported to file)
- **Status**: Generated ✅, needs PNG export → `Design/splash-light.png`

### Today's Reading
- **Screen ID**: `649b44f523224f8abbcc5296f213dfcb`
- **Type**: DESIGN (MOBILE portrait, 780×2358)
- **Description**: "Today's Fortune" in EB Garamond gold with glow, date label, large glassmorphism fortune card (semi-transparent violet, gold border) containing paragraph of mystical guidance + BaZi chart summary (Day Master/Pillars), source chips showing book names with relevance, ghost-style "Refresh Reading" button, floating glass bottom nav.
- **Export**: Screenshot available
- **Status**: Generated ✅

### Cookie Fortune
- **Screen ID**: `5b9eea280ff046188b7ca45bcfe57462`
- **Type**: DESIGN (MOBILE portrait, 780×1768)
- **Description**: Centered radial golden candlelight glow, "Cookie Fortune" headline, date label, large 160px circular golden amber "cookie" button with mystical rune + "Tap to reveal" text, glassmorphism fortune card with single-line fortune in golden Manrope body-lg, floating glass bottom nav with Cookie active (halo).
- **Export**: Screenshot available
- **Status**: Generated ✅

### Chat
- **Screen ID**: `b3b452538d604c7eaa4b16848d300aca`
- **Type**: DESIGN (MOBILE portrait, 780×1884)
- **Description**: "Chat" headline + "Ask the oracle anything" subtitle, message list with right-aligned user bubbles (solid purple) and left-aligned assistant bubbles (glassmorphism, gold border) with source chips, "Consulting..." typing indicator with golden dots, ghost-style composer input with gold underline + send button, floating glass bottom nav.
- **Export**: Screenshot available
- **Status**: Generated ✅

### Fortune Garden
- **Screen ID**: `feade102c1be4a7e958bcd0a0dcd4ecc` (UI) + `b87212286d1b4e908e89551d5a1e3a44` (illustration)
- **Type**: DESIGN (MOBILE portrait, 780×2300) + IMAGE (848×1264 garden scene)
- **Description**: "Fortune Garden" headline with plant count subtitle, magical garden illustration (midnight-to-forest-green gradient, moonflower, star-bloom, constellation vine, fireflies, glowing crystals), 3 glassmorphism plant progress cards with constellation-style star trackers, "Return daily to water your garden" tip, floating glass bottom nav.
- **Export**: Screenshots available
- **Status**: Generated ✅

### Shadow Reading
- **Screen ID**: `440f9557524444ce9615b92269e50e58`
- **Type**: DESIGN (MOBILE portrait, 780×3116)
- **Description**: Nearly-black background (#080210) with subtle purple mist, single flickering golden candle flame at top, "Shadow Reading" in amber-gold (#B8944A), preparation state with pulsing breathing ring + "Take a deep breath" + "Begin Reading" ghost button, revealed state with dark glass card showing introspective shadow reading text + 3 constellation theme icons (Patience, Self-care, Honesty), floating glass bottom nav.
- **Export**: Screenshot available
- **Status**: Generated ✅

### Settings
- **Screen ID**: `d47a4ee3da8d45feacd2155913d652c3`
- **Type**: DESIGN (MOBILE portrait, 780×2878)
- **Description**: "Settings" headline, Profiles section (active profile glass card + "Manage Profiles" ghost button), Language section (English | Tiếng Việt segmented picker with gold highlight), Appearance section (gold toggles for Dark Mode, Constellation Background, Haptic Feedback), Data section (danger ghost buttons for cache clear + reset), About section (version, server, privacy/terms rows with chevrons), floating glass bottom nav.
- **Export**: Screenshot available
- **Status**: Generated ✅

## Supplementary Assets

### Celestial Astrolabe Illustration
- **Screen ID**: `761cf68185f8439ab9524a4be572be5c`
- **Type**: IMAGE (800×800)
- **Description**: Delicate line-art illustration of a celestial compass / stargazer's astrolabe in muted gold-amber tones.
- **Export**: ✅ Exported → `Design/astrolabe-illustration.png` (97 KB)
- **Status**: Done

### Design System
- **Export**: ✅ Exported → `Design/stitch-design-system.md` (7.4 KB)

## Screen Summary

| # | Screen | Screen ID | Light | Dark | Status |
|---|--------|-----------|-------|------|--------|
| 1 | App Icon | `b89bd7f...` | N/A | ✅ | Exported |
| 2 | Splash (Dark) | `22dd8d97...` | — | ✅ | Exported |
| 3 | Splash (Light) | `466b83be...` | ✅ | — | Needs PNG export |
| 4 | Today's Reading | `649b44f5...` | — | ✅ | Generated |
| 5 | Cookie Fortune | `5b9eea28...` | — | ✅ | Generated |
| 6 | Chat | `b3b45253...` | — | ✅ | Generated |
| 7 | Fortune Garden | `feade102...` | — | ✅ | Generated |
| 8 | Shadow Reading | `440f9557...` | — | ✅ | Generated |
| 9 | Settings | `d47a4ee3...` | — | ✅ | Generated |

## Next Design Steps

1. Export light-mode splash screen PNG → `Design/splash-light.png`
2. Export remaining screen screenshots/backgrounds manually as needed
3. Sync all screens to Figma for refinement and developer handoff
4. Create `Design/asset-manifest.md` tracking all exported assets

## Repository Paths

- **App Icon**: `FortuneTeller/App/Resources/Assets.xcassets/AppIcon.appiconset/`
- **Launch Screen**: `FortuneTeller/App/Resources/LaunchScreen.storyboard`
- **Asset Manifest**: `Design/asset-manifest.md` (TBD — create when assets are exported)
