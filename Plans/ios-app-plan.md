# FortuneTeller iOS App — Product Plan

## Overview

A mysterious-themed fortune-teller iOS app powered by 20 classical books spanning Zi Wei (紫微斗数), BaZi (八字), Yi Jing (易经), and Western Astrology. Backed by a RAG-powered REST API server at `/Work/FortuneTeller/server/`.

**Bundle ID:** `com.binaryradish.fortuneteller`
**Platform:** iPhone only, iOS 17+
**Theme:** Mysterious — dark palette, candlelit aesthetic, ritualistic UX, ethereal motion

## Primary Screens (7 primaries + settings)

| # | Screen | Daily/Weekly Payoff | Action-Heavy? |
|---|--------|---------------------|---------------|
| 1 | **Today's Reading** | Personalized daily fortune (cross-tradition) | ✅ — multi-step hero flow |
| 2 | **Cookie Fortune** | One-sentence daily mystery reveal | ✅ — interactive tap-to-reveal |
| 3 | **Chat** | Ask any divinatory question | ✅ — multi-turn conversation |
| 4 | **Reading History** | Reflect on past fortunes, spot patterns | Read-heavy |
| 5 | **Fortune Garden** | Gamified daily ritual — garden grows with readings | ✅ — interaction-heavy |
| 6 | **Shadow Reading** | Reverse fortune — reveals what you avoid | ✅ — ritualistic multi-step |
| 7 | **Settings** | Profiles, language, preferences | Functional |
| + | **Add Profile** | Onboarding flow | — |

## Core Features

### A. Profiles (`Planned`)

Multi-profile system with one active profile. Fields determined by tradition requirements:

**Required fields (cross-tradition):**
- Name (display name)
- Gregorian birth date (YYYY-MM-DD)
- Birth hour (0-23) — critical for BaZi Hour Pillar

**Optional fields (depth bonus):**
- Birth location (city/country) — for local solar time correction
- Gender — some Zi Wei schools use for 身宫 placement
- Preferred tradition (Western / Zi Wei / BaZi / Auto)

**Storage:** `@AppStorage` + JSON file persistence. Active profile persisted to UserDefaults.

### B. Today's Reading (`Planned`)

Daily fortune reading cached per profile + date. Never changes for same profile + same date.

**Information displayed:**
- BaZi pillars for the day person (Year, Month, Day, Hour)
- Day Master element analysis
- Current year's influence on this profile
- Cross-tradition synthesis (Zi Wei + BaZi + Yi Jing + Western where applicable)
- Practical guidance for the day

**Cache strategy:** SQLite or JSON file keyed by `profile_id + date`. Fetched from REST API on first open of the day, cached thereafter.

**Visual:** Card-based layout with mystical ornamentation. Animated card reveal (fade + slide).

### C. Cookie Fortune (`Planned`)

One-sentence fortune per day per profile. Randomly generated from AI but deterministic per day.

**Design:** A glowing cookie icon that pulses. Tap → cookie cracks open (animation) → fortune sentence appears on parchment-style card.

**Storage:** Cached like daily reading. Re-rolled once daily.

### D. Chat (`Planned`)

Similar to Magic Advisor chat pattern:
- Message bubbles (user + assistant)
- Real-time response from REST API (`POST /ask`)
- Context-aware (includes active profile's chart data)
- Warning indicator when birth date not set

**Messages:** `[ChatMessage]` struct with id, role, content, timestamp.

### E. Settings (`Planned`)

- **Language selector** (English / Vietnamese) — affects all app text + API language
- **Active profile** picker
- **Manage profiles** (create, edit, delete)
- **Theme toggle** (light/dark — app supports system dark mode by default)
- **Server connection status** indicator
- **About / Credits**

### F. Fortune Garden (`Planned`)

A visual garden that grows as the user returns daily:

- Each daily reading waters a plant
- Different reading types grow different mystical plants
- Completing collections unlocks rare plants
- Garden becomes more elaborate over 6 months
- Visual: parallax scene with animated plant sprites

**Why it works:** Gamified daily habit without guilt. Collecting is inherently satisfying. 6-month arc matches studio vision.

### G. Shadow Reading (`Planned`)

A "reverse" fortune telling ritual:

- User enters a quiet state (timer, breathing prompt)
- AI analyzes recent chat questions + reading history
- Reveals what patterns the user might be avoiding
- Presented as a dark counterpart to the daily reading
- Visual: darker palette, slower reveal, candle flicker animation

**Why it works:** Unique differentiator. Depth beyond daily fluff. Psychological engagement.

## Interaction Verbs (across primaries)

- Compare (cross-tradition readings)
- Reveal (cookie fortune, shadow reading tap-to-reveal)
- Tend (fortune garden watering/nurturing)
- Ask (chat queries)
- Reflect (reading history review, shadow reading)
- Customize (profile settings, language)

## Motion Plan (per primary)

| Screen | Animations |
|--------|------------|
| Today's Reading | Card reveal (fade + slide-up), pillar shimmer on load, day-master glow |
| Cookie Fortune | Cookie pulse idle, crack-open animation on tap, fortune text typewriter reveal |
| Chat | Message bubble enter animation, typing indicator (three dots), scroll-to-bottom |
| Reading History | Cards slide in staggered, timeline line draws in |
| Fortune Garden | Plant growth animation, water droplet splash, parallax scroll |
| Shadow Reading | Candle flicker, slow card materialization, breathing circle animation |
| Settings | Section expand/collapse, profile list reorder animation |

## Imagery Plan (per primary)

| Screen | Custom Graphics Needed |
|--------|----------------------|
| Today's Reading | Hero illustration (mystical landscape), card background texture |
| Cookie Fortune | Cookie icon art, parchment texture, fortune paper overlay |
| Chat | Mystical message bubble style, input field ornamentation |
| Reading History | Timeline ornament nodes, scroll/folio texture |
| Fortune Garden | Plant sprites (6+), garden background, water animation frames |
| Shadow Reading | Dark landscape hero, candle illustration, shadow figure art |
| Settings | Icon set for settings rows |

## REST API Contract

Base URL: TBD (currently `http://localhost:8001`, will become `https://fortuneteller.binaryradish.com` or similar via Cloudflare Tunnel)

```
POST /ask
  Request:  { question: String, birth_date: String? (YYYY-MM-DD), birth_hour: Int? }
  Response: { answer: String, sources: [SourceInfo], chart: String?, language: String, model: String, response_time_ms: Float }

GET /health
  Response: { status: String, version: String, chroma_chunks: Int, ollama_model: String }
```

## Project Structure

```
FortuneTeller/
  App/
    Assets.xcassets/
      AppIcon.appiconset/
    Sources/
      App/
        FortuneTellerApp.swift
        AppDependencies.swift
      Models/
        Profile.swift
        DailyReading.swift
        CookieFortune.swift
        ChatMessage.swift
      Networking/
        ApiClient.swift
        ApiModels.swift
      Views/
        TodayReadingView.swift
        CookieFortuneView.swift
        ChatView.swift
        ReadingHistoryView.swift
        FortuneGardenView.swift
        ShadowReadingView.swift
        Profile/
          AddProfileView.swift
          ProfileListView.swift
        Settings/
          SettingsView.swift
          LanguagePickerView.swift
        Components/
          MysticCard.swift
          MysticButton.swift
          MysticBackground.swift
          TabBar.swift
        ContentView.swift
    Info.plist
  Tests/
    FortuneTellerTests/
    FortuneTellerUITests/
```

## Next Steps

1. ✅ Server built and pushed to GitHub
2. ✅ Book knowledge ingested into ChromaDB
3. ⬜ Design in Stitch → Figma (per `stitch-mcp-design.mdc`)
4. ⬜ Create XcodeGen project.yml
5. ⬜ Implement iOS app
6. ⬜ Test on simulator + device
7. ⬜ Deploy (Cloudflare Tunnel + App Store)
