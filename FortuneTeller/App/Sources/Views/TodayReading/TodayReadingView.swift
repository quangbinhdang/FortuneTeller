import SwiftUI

// MARK: - Markdown-rendered text view

private struct MarkdownText: View {
    let markdown: String
    var body: some View {
        if let attr = try? AttributedString(
            markdown: markdown,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            Text(attr)
        } else {
            Text(.init(markdown))
        }
    }
}

// MARK: - Today's Reading View

/// Today's fortune reading — fetched once per day per profile, cached locally.
struct TodayReadingView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.theme) private var theme

    @State private var answer = ""
    @State private var chart: String?
    @State private var sources: [FortuneAPI.AskResponse.SourceInfo] = []
    @State private var isLoading = false
    @State private var error: String?

    private var todayKey: String {
        let df = DateFormatter(); df.dateFormat = "yyyy-MM-dd"
        return "reading_\(settings.activeProfileId ?? "")_\(df.string(from: Date()))"
    }

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                                .tint(theme.gold)
                            Text(lang == "vi" ? "Đang xem tử vi..." : "Consulting the stars...")
                                .font(theme.bodyFont(size: 14))
                                .foregroundColor(theme.mutedStarlight)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                    } else if let err = error {
                        ContentUnavailableView(
                            lang == "vi" ? "Không thể tải tử vi" : "Could not load reading",
                            systemImage: "moon.zzz",
                            description: Text(err)
                        )
                    } else if answer.isEmpty {
                        emptyState
                    } else {
                        // Reading card
                        readingCard

                        // Retry button
                        Button(lang == "vi" ? "Xem lại" : "Refresh Reading") {
                            Task { await fetchReading() }
                        }
                        .font(theme.labelFont(size: 14))
                        .foregroundColor(theme.mutedStarlight)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(20)
            }
            .background(theme.background)
            .navigationTitle(lang == "vi" ? "Hôm nay" : "Today")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if answer.isEmpty, error == nil, settings.activeProfile != nil {
                    Task { await fetchReading() }
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 40)

            Image(systemName: "moon.stars.fill")
                .font(.system(size: 48))
                .foregroundColor(theme.gold.opacity(0.6))

            VStack(spacing: 6) {
                Text(lang == "vi" ? "Tử vi hôm nay" : "Today's Reading")
                    .font(theme.headlineFont(size: 22))
                    .foregroundColor(theme.starlight)

                Text(lang == "vi"
                    ? "Tử vi hàng ngày của bạn sẽ xuất hiện ở đây."
                    : "Your daily fortune will appear here.")
                    .font(theme.bodyFont(size: 14))
                    .foregroundColor(theme.mutedStarlight)
                    .multilineTextAlignment(.center)
            }

            Button(lang == "vi" ? "Xem tử vi hôm nay" : "Get Today's Reading") {
                Task { await fetchReading() }
            }
            .buttonStyle(.borderedProminent)
            .tint(theme.gold)

            Spacer().frame(height: 40)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Reading Card

    private var readingCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header card
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack(spacing: 8) {
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(theme.amber)
                    Text(lang == "vi" ? "Tử vi hôm nay" : "Today's Fortune")
                        .font(theme.headlineFont(size: 20))
                        .foregroundColor(theme.gold)
                    Spacer()
                    // Today's date badge
                    Text(todayFormatted)
                        .font(theme.labelFont(size: 11))
                        .foregroundColor(theme.subtleWhite)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(theme.surfaceContainer.opacity(0.8))
                        .clipShape(Capsule())
                }

                Divider()
                    .background(theme.gold.opacity(0.2))

                // Chart data (birth info)
                VStack(alignment: .leading, spacing: 4) {
                    Text(lang == "vi" ? "Dựa trên lá số:" : "Based on chart:")
                        .font(theme.labelFont(size: 11))
                        .foregroundColor(theme.subtleWhite)

                    if let profile = settings.activeProfile {
                        Text(profile.birthDisplay)
                            .font(theme.monoFont(size: 13))
                            .foregroundColor(theme.mutedStarlight)
                    }

                    if let chart = chart, !chart.isEmpty {
                        Text(chart)
                            .font(theme.monoFont(size: 11))
                            .foregroundColor(theme.subtleWhite.opacity(0.6))
                            .padding(.top, 2)
                    }
                }
                .padding(10)
                .background(theme.surface.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Divider()
                    .background(theme.gold.opacity(0.2))

                // The reading itself — markdown rendered
                MarkdownText(markdown: stripChineseIfAny(answer))
                    .font(theme.bodyFont(size: 15).leading(.loose))
                    .foregroundColor(theme.starlight)
                    .textSelection(.enabled)
                    .lineSpacing(5)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(theme.surfaceContainer.opacity(0.6))
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(theme.gold.opacity(0.15), lineWidth: 0.5)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))

            // Sources consulted
            if !sources.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text(lang == "vi" ? "Nguồn tham khảo" : "Sources consulted")
                        .font(theme.labelFont(size: 12))
                        .foregroundColor(theme.subtleWhite.opacity(0.6))

                    ForEach(sources.prefix(5), id: \.file) { s in
                        HStack(spacing: 6) {
                            Image(systemName: "book.pages")
                                .font(.caption2)
                                .foregroundColor(theme.subtleWhite.opacity(0.4))
                            Text(s.file)
                                .font(.system(size: 11, design: .monospaced))
                                .foregroundColor(theme.subtleWhite.opacity(0.5))
                                .lineLimit(1)
                            Spacer()
                            Text("\(Int(s.relevance * 100))%")
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(theme.amber.opacity(0.5))
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }

    // MARK: - Date formatting

    private var todayFormatted: String {
        let df = DateFormatter()
        df.dateFormat = lang == "vi" ? "dd/MM/yyyy" : "MMM d, yyyy"
        return df.string(from: Date())
    }

    // MARK: - Chinese character stripping

    /// Removes CJK Unified Ideographs (U+4E00–U+9FFF) from the response.
    /// Falls back to the original string if nothing remains.
    private func stripChineseIfAny(_ text: String) -> String {
        let filtered = text.unicodeScalars.filter { scalar in
            guard scalar.value >= 0x4E00 && scalar.value <= 0x9FFF else { return true }
            // Also strip CJK extension A
            guard scalar.value >= 0x3400 && scalar.value <= 0x4DBF else { return true }
            return false
        }
        let result = String(String.UnicodeScalarView(filtered))
        return result.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? text : result
    }

    // MARK: - API fetch

    private func fetchReading() async {
        guard let api = FortuneAPI(serverURL: settings.serverURL),
              let profile = settings.activeProfile else {
            error = lang == "vi" ? "Chưa chọn hồ sơ." : "No active profile set."
            return
        }
        isLoading = true; error = nil
        do {
            let resp = try await api.ask(
                question: languagePrompt(profile: profile),
                birthDate: profile.birthDateString,
                birthHour: profile.birthHour,
                birthMinute: profile.birthMinute
            )
            answer = resp.answer
            chart = resp.chart
            sources = resp.sources
            // Cache to UserDefaults
            if let data = try? JSONEncoder().encode(resp) {
                UserDefaults.standard.set(data, forKey: todayKey)
            }
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    private func languagePrompt(profile: Profile) -> String {
        let todayStr: String = {
            let df = DateFormatter()
            df.dateFormat = lang == "vi" ? "'ngày' dd/MM/yyyy" : "MMMM d, yyyy"
            return df.string(from: Date())
        }()
        let birthStr: String = {
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            return df.string(from: Calendar.current.date(from: DateComponents(
                year: profile.birthYear, month: profile.birthMonth, day: profile.birthDay
            )) ?? Date())
        }()
        let timeStr = String(format: "%02d:%02d", profile.birthHour, profile.birthMinute)

        if lang == "vi" {
            return """
            Hôm nay là \(todayStr).

            Đọc tử vi cho tôi ngày hôm nay, dựa trên lá số của tôi:
            - Ngày sinh: \(birthStr) lúc \(timeStr)
            - Nơi sinh: \(profile.birthPlace ?? "không rõ")

            Phân tích chi tiết từng khía cạnh: công việc, tình cảm, sức khỏe, tài chính.

            QUAN TRỌNG: KHÔNG sử dụng chữ Hán hoặc ký tự Trung Quốc. Chỉ viết bằng tiếng Việt.
            """
        }

        return """
        Today is \(todayStr).

        Read my fortune for TODAY ONLY, based on my birth chart:
        - Born: \(birthStr) at \(timeStr)
        - Birthplace: \(profile.birthPlace ?? "unknown")

        Cover these areas in detail: career, relationships, health, finances.

        IMPORTANT: Do NOT include Chinese characters (Hanzi) or any non-English text. Write only in English.
        """
    }
}
