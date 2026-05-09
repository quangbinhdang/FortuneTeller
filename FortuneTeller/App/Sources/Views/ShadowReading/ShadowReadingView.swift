import SwiftUI

/// Shadow Reading — a reverse fortune ritual that reveals patterns the user might be avoiding.
/// Preparation phase: breathing guide. Revealed phase: introspective text + theme icons.
struct ShadowReadingView: View {
    @Environment(AppSettings.self) private var settings

    @State private var phase: Phase = .preparation
    @State private var reading: String?
    @State private var themes: [String] = []
    @State private var isLoading = false
    @State private var error: String?

    // Breathing animation
    @State private var breathScale: CGFloat = 1.0
    @State private var candleFlicker: CGFloat = 1.0

    private let candleColor = Color(red: 0.72, green: 0.58, blue: 0.29) // #B8944A amber-gold

    private var lang: String { settings.language }

    enum Phase {
        case preparation, revealed
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background: nearly black with subtle purple mist
                Color(red: 0.031, green: 0.008, blue: 0.063) // #080210

                VStack(spacing: 0) {
                    // Candle flame at top
                    candleFlame
                        .padding(.top, 60)

                    ScrollView {
                        VStack(spacing: 32) {
                            // Header
                            VStack(spacing: 4) {
                                Text(lang == "vi" ? "Đọc bóng tối" : "Shadow Reading")
                                    .font(.system(size: 28, weight: .medium, design: .serif))
                                    .foregroundColor(candleColor)

                                Text(lang == "vi" ? "Điều bóng tối tiết lộ" : "What the shadows reveal")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.35))
                            }
                            .padding(.top, 20)

                            switch phase {
                            case .preparation:
                                preparationContent
                            case .revealed:
                                revealedContent
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle(lang == "vi" ? "Bóng tối" : "Shadow")
            .navigationBarHidden(true)
            .onAppear {
                startCandleAnimation()
                if phase == .preparation {
                    startBreathingAnimation()
                }
            }
        }
    }

    // MARK: - Candle Flame

    private var candleFlame: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(candleColor.opacity(0.08))
                .frame(width: 120, height: 120)
                .blur(radius: 30)
                .scaleEffect(candleFlicker)

            // Inner glow
            Circle()
                .fill(candleColor.opacity(0.15))
                .frame(width: 60, height: 60)
                .blur(radius: 12)
                .scaleEffect(candleFlicker * 1.02)

            // Flame shape
            Image(systemName: "flame.fill")
                .font(.system(size: 28))
                .foregroundColor(candleColor.opacity(0.9))
                .scaleEffect(candleFlicker)
        }
        .frame(height: 80)
    }

    private func startCandleAnimation() {
        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            candleFlicker = 0.85
        }
    }

    // MARK: - Preparation Phase

    private var preparationContent: some View {
        VStack(spacing: 48) {
            Spacer().frame(height: 20)

            // Breathing ring
            ZStack {
                Circle()
                    .stroke(candleColor.opacity(0.15), lineWidth: 2)
                    .frame(width: 180, height: 180)

                Circle()
                    .stroke(candleColor.opacity(0.35), lineWidth: 1.5)
                    .frame(width: 180, height: 180)
                    .scaleEffect(breathScale)

                VStack(spacing: 8) {
                    Text(lang == "vi" ? "Hít thở sâu" : "Take a deep breath")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)

                    Text(lang == "vi" ? "Hít vào..." : "Inhale...")
                        .font(.caption)
                        .foregroundColor(candleColor.opacity(0.6))
                }
            }

            // Description
            Text(lang == "vi"
                ? "Bóng tối nắm giữ những điều bạn đang tránh né. Nghi thức này tiết lộ những mẫu hình cần sự chú ý của bạn."
                : "The shadows hold what you've been avoiding. This ritual reveals patterns that need your awareness.")
                .font(.callout)
                .foregroundColor(.white.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            Spacer().frame(height: 12)

            // Begin button
            Button {
                Task { await performReading() }
            } label: {
                HStack(spacing: 8) {
                    if isLoading {
                        ProgressView()
                            .tint(candleColor)
                    }
                    Text(isLoading
                        ? (lang == "vi" ? "Đang xem..." : "Consulting...")
                        : (lang == "vi" ? "Bắt đầu đọc" : "Begin Reading"))
                        .font(.callout)
                }
                .foregroundColor(candleColor)
                .padding(.horizontal, 32)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(candleColor.opacity(0.4), lineWidth: 1)
                        .background(candleColor.opacity(0.06))
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(isLoading)

            if let err = error {
                Text(err)
                    .font(.caption)
                    .foregroundColor(.red.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
        }
    }

    private func startBreathingAnimation() {
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            breathScale = 1.15
        }
    }

    // MARK: - Revealed Phase

    private var revealedContent: some View {
        VStack(spacing: 24) {
            // Shadow reading card
            VStack(spacing: 16) {
                if let reading {
                    Text(reading)
                        .font(.body)
                        .foregroundColor(Color(red: 0.784, green: 0.722, blue: 0.847)) // #C8B8D8 muted starlight
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(6)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.055, green: 0.020, blue: 0.098).opacity(0.8)) // #0E051A
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.06), lineWidth: 0.5)
                    )
            )

            // Theme icons
            if !themes.isEmpty {
                VStack(spacing: 12) {
                    Text(lang == "vi" ? "Chủ đề nhận thấy" : "Themes noticed")
                        .font(.caption)
                        .foregroundColor(candleColor.opacity(0.5))

                    HStack(spacing: 24) {
                        ForEach(Array(themes.prefix(3).enumerated()), id: \.offset) { _, theme in
                            VStack(spacing: 6) {
                                Image(systemName: themeIcon(for: theme))
                                    .font(.title3)
                                    .foregroundColor(candleColor.opacity(0.7))

                                Text(theme)
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.4))
                            }
                        }
                    }
                }
            }

            // try again
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    phase = .preparation
                    reading = nil
                    themes = []
                    error = nil
                    startBreathingAnimation()
                }
            } label: {
                Text(lang == "vi" ? "Thử lại" : "Try another reading")
                    .font(.caption)
                    .foregroundColor(candleColor.opacity(0.5))
            }
            .padding(.top, 8)
        }
    }

    private func themeIcon(for theme: String) -> String {
        let lower = theme.lowercased()
        if lower.contains("patient") || lower.contains("wait") { return "hourglass" }
        if lower.contains("care") || lower.contains("self") { return "heart.fill" }
        if lower.contains("honest") || lower.contains("truth") { return "eye.fill" }
        if lower.contains("courage") || lower.contains("brave") { return "shield.fill" }
        if lower.contains("let go") || lower.contains("release") { return "leaf.arrow.circlepath" }
        return "sparkles"
    }

    // MARK: - API

    private func performReading() async {
        guard let api = FortuneAPI(serverURL: settings.serverURL),
              let profile = settings.activeProfile else {
            error = lang == "vi" ? "Chưa chọn hồ sơ." : "No active profile set."
            return
        }

        isLoading = true
        error = nil

        do {
            let prompt = settings.language == "vi"
                ? "Tên tôi là \(profile.name), sinh ngày \(profile.birthDateString) lúc \(String(format: "%02d:%02d", profile.birthHour, profile.birthMinute)) tại \(profile.birthPlace ?? "không rõ"), giới tính \(profile.gender ?? "không rõ"). Hãy tiết lộ một điều tôi đang tránh né hôm nay. Chỉ một đoạn ngắn, đầy suy ngẫm và nhẹ nhàng. Liệt kê 3 chủ đề (từ đơn) như 'Kiên nhẫn, Tự chăm sóc, Trung thực'. KHÔNG dùng chữ Hán. Chỉ viết bằng tiếng Việt."
                : "My name is \(profile.name), born \(profile.birthDateString) at \(String(format: "%02d:%02d", profile.birthHour, profile.birthMinute)) in \(profile.birthPlace ?? "unknown"), gender \(profile.gender ?? "unknown"). Reveal something I may be avoiding today. Keep it short, introspective, and gentle. Include 3 single-word themes like 'Patience, Self-care, Honesty.' Do NOT include Chinese characters. Write only in English."

            let resp = try await api.ask(
                question: prompt,
                birthDate: profile.birthDateString,
                birthHour: profile.birthHour,
                birthMinute: profile.birthMinute,
                birthPlace: profile.birthPlace
            )

            reading = resp.answer
            themes = extractThemes(from: resp.answer)

            withAnimation(.easeInOut(duration: 0.6)) {
                phase = .revealed
            }
        } catch {
            // Fallback reading for offline / error
            reading = settings.language == "vi"
                ? "Bạn đã tránh sự tĩnh lặng. Các vì sao khuyên bạn hãy ngồi lại với sự yên tĩnh hôm nay."
                : "You have been avoiding stillness. The stars ask you to sit with the quiet today."
            themes = ["Patience", "Self-care", "Honesty"]

            withAnimation(.easeInOut(duration: 0.6)) {
                phase = .revealed
            }
        }

        isLoading = false
    }

    private func extractThemes(from answer: String) -> [String] {
        // Try to find a line with comma-separated themes
        let candidates: [String]
        if answer.contains("Patience") || answer.contains("Self-care") {
            // Try to parse "Patience, Self-care, Honesty" pattern
            let lines = answer.components(separatedBy: .newlines)
            for line in lines {
                let parts = line.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines.union(.punctuationCharacters)) }
                let filtered = parts.filter { $0.count >= 3 && $0.count <= 20 }
                if filtered.count >= 2 {
                    candidates = filtered
                    return Array(candidates.prefix(3))
                }
            }
        }
        return ["Patience", "Self-care", "Honesty"]
    }
}

#Preview {
    ShadowReadingView()
        .environment(AppSettings())
        .preferredColorScheme(.dark)
}
