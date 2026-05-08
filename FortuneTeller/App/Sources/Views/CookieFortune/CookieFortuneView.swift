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

                    // Cookie button — pulse animation
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            if isRevealed {
                                // Reset: fetch new
                                isRevealed = false
                                Task { await fetchFortune() }
                            } else {
                                isRevealed = true
                                cookiePhase = 1.0
                            }
                        }
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
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            cookiePhase = isRevealed ? 1.0 : 1.06
                        }
                        withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                            sparkleAngle = .pi * 2
                        }
                    }

                    // Fortune text
                    if isRevealed, let f = fortune {
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
            let key = "cookie_\(profile.id)_\(f.date)"
            if let data = try? JSONEncoder().encode(f) {
                UserDefaults.standard.set(data, forKey: key)
            }
            fortune = f
        } catch {
            fortune = CookieFortune(
                profileId: profile.id,
                date: "today",
                fortune: settings.language == "vi" ? "Hãy tin vào trực giác của bạn hôm nay." : "Trust your intuition today.",
                fetchedAt: Date(),
                hasBeenRevealed: false
            )
        }
        isLoading = false
    }
}
