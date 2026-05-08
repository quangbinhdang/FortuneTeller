import SwiftUI

/// Tap-to-reveal cookie fortune: one sentence per day per profile.
struct CookieFortuneView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.theme) private var theme

    @State private var fortune: CookieFortune?
    @State private var isRevealed = false
    @State private var isLoading = false
    @State private var cookiePhase: CGFloat = 1.0
    @State private var sparkleAngle: Double = 0

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()

                VStack(spacing: 40) {
                    Spacer()

                    // Cookie button
                    Button {
                        cookieTapped()
                    } label: {
                        ZStack {
                            // Glow halo
                            Circle()
                                .fill(theme.gold.opacity(0.15))
                                .frame(width: 200, height: 200)
                                .blur(radius: 20)

                            // Cookie circle
                            Circle()
                                .fill(theme.gold.gradient)
                                .frame(width: 140, height: 140)
                                .shadow(color: theme.gold.opacity(0.3), radius: 30)
                                .scaleEffect(cookiePhase)

                            // Sparkle particles
                            ForEach(0..<8, id: \.self) { i in
                                let angle = Double(i) / 8 * .pi * 2 + sparkleAngle
                                Circle()
                                    .fill(theme.starlight.opacity(0.6))
                                    .frame(width: 3, height: 3)
                                    .offset(
                                        x: cos(angle) * 90,
                                        y: sin(angle) * 90
                                    )
                            }

                            Image(systemName: isRevealed ? "sparkles" : "circle.dotted")
                                .font(.system(size: 52))
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(isLoading)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            cookiePhase = isRevealed ? 1.0 : 1.06
                        }
                        withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                            sparkleAngle = .pi * 2
                        }
                    }

                    // Fortune text
                    if let f = fortune {
                        if isRevealed {
                            Text(f.fortune)
                                .font(theme.headlineFont(size: 20))
                                .foregroundColor(theme.starlight)
                                .multilineTextAlignment(.center)
                                .padding(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(theme.surfaceContainer.opacity(0.6))
                                        .background(.ultraThinMaterial)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(theme.gold.opacity(0.15), lineWidth: 0.5)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.horizontal, 24)
                                .transition(.scale.combined(with: .opacity))
                        } else if !isLoading {
                            // Cookie loaded but not revealed — show hint
                            Text(lang == "vi" ? "Chạm vào bánh để mở" : "Tap the cookie to reveal")
                                .font(theme.bodyFont(size: 14))
                                .foregroundColor(theme.mutedStarlight)
                                .transition(.opacity)
                        }
                    }

                    if isLoading {
                        HStack(spacing: 10) {
                            ProgressView()
                                .tint(theme.gold)
                            Text(lang == "vi" ? "Đang nướng bánh..." : "Baking your fortune...")
                                .font(theme.bodyFont(size: 14))
                                .foregroundColor(theme.mutedStarlight)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle(lang == "vi" ? "Bánh quy may mắn" : "Cookie Fortune")
            .onAppear {
                if fortune == nil { fetchCached() }
            }
        }
    }

    // MARK: - Tap logic

    private func cookieTapped() {
        if isRevealed {
            // Already revealed — reset and fetch a new one
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isRevealed = false
            }
            // Task must be outside withAnimation to work correctly
            Task { await fetchFortune() }
        } else if isLoading {
            // Ignore taps while loading
            return
        } else {
            // Reveal the loaded fortune
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isRevealed = true
                cookiePhase = 1.0
            }
            // Mark cached as revealed
            if let f = fortune {
                saveFortune(f, revealed: true)
            }
        }
    }

    // MARK: - Caching

    private func fetchCached() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let today = df.string(from: Date())
        let key = "cookie_\(settings.activeProfileId ?? "")_\(today)"
        if let data = UserDefaults.standard.data(forKey: key),
           let cached = try? JSONDecoder().decode(CookieFortune.self, from: data) {
            fortune = cached
            isRevealed = cached.hasBeenRevealed
        } else {
            Task { await fetchFortune() }
        }
    }

    // MARK: - API

    private func fetchFortune() async {
        guard let api = FortuneAPI(serverURL: settings.serverURL),
              let profile = settings.activeProfile else { return }
        isLoading = true
        do {
            let prompt = settings.language == "vi"
                ? "Cho tôi một lời khuyên ngắn một câu hôm nay. KHÔNG dùng chữ Hán. Chỉ viết bằng tiếng Việt."
                : "Give me one sentence of encouragement or awareness for today. Do NOT include Chinese characters. Write only in English."
            let resp = try await api.ask(question: prompt, birthDate: profile.birthDateString, birthHour: profile.birthHour, birthMinute: profile.birthMinute)
            let firstSentence = resp.answer.components(separatedBy: ".").first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? resp.answer
            let df = DateFormatter(); df.dateFormat = "yyyy-MM-dd"
            let f = CookieFortune(
                profileId: profile.id,
                date: df.string(from: Date()),
                fortune: firstSentence,
                fetchedAt: Date(),
                hasBeenRevealed: false
            )
            saveFortune(f, revealed: false)
            fortune = f
            // Auto-reveal after successful fetch
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isRevealed = true
            }
        } catch {
            let fallback = CookieFortune(
                profileId: profile.id,
                date: "today",
                fortune: settings.language == "vi" ? "Hãy tin vào trực giác của bạn hôm nay." : "Trust your intuition today.",
                fetchedAt: Date(),
                hasBeenRevealed: false
            )
            fortune = fallback
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isRevealed = true
            }
        }
        isLoading = false
    }

    private func saveFortune(_ f: CookieFortune, revealed: Bool) {
        var updated = f
        updated.hasBeenRevealed = revealed
        let key = "cookie_\(f.profileId)_\(f.date)"
        if let data = try? JSONEncoder().encode(updated) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
