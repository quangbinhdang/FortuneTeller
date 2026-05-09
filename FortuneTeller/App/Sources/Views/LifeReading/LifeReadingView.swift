import SwiftUI

// MARK: - Life Reading View

/// Comprehensive life trajectory reading — covers the user's entire life from birth
/// to old age, with specific ages for major milestones. Cached per profile.
struct LifeReadingView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.theme) private var theme
    @Environment(\.dismiss) private var dismiss

    @State private var answer = ""
    @State private var chart: String?
    @State private var sources: [FortuneAPI.AskResponse.SourceInfo] = []
    @State private var isLoading = false
    @State private var error: String?

    private var cacheKey: String {
        "life_reading_\(settings.activeProfileId ?? "anonymous")"
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
                            Text(lang == "vi" ? "Đang xem toàn bộ lá số..." : "Reading your entire life chart...")
                                .font(theme.bodyFont(size: 14))
                                .foregroundColor(theme.mutedStarlight)
                            Text(lang == "vi"
                                ? "Quá trình này có thể mất đến một phút để có kết quả chi tiết."
                                : "This may take up to a minute for a detailed result.")
                                .font(theme.bodyFont(size: 12))
                                .foregroundColor(theme.subtleWhite.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, minHeight: 300)
                    } else if let err = error {
                        VStack(spacing: 20) {
                            ContentUnavailableView(
                                lang == "vi" ? "Không thể tải lá số" : "Could not load life reading",
                                systemImage: "moon.zzz",
                                description: Text(err)
                            )
                            Button(lang == "vi" ? "Thử lại" : "Retry") {
                                error = nil
                                Task { await fetchLifeReading() }
                            }
                            .buttonStyle(.bordered)
                            .tint(theme.gold)
                        }
                    } else if answer.isEmpty {
                        emptyState
                    } else {
                        readingCard

                        Button(lang == "vi" ? "Xem lại" : "Refresh Life Reading") {
                            Task { await fetchLifeReading() }
                        }
                        .font(theme.labelFont(size: 14))
                        .foregroundColor(theme.mutedStarlight)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(20)
            }
            .background(theme.background)
            .navigationTitle(lang == "vi" ? "Lá số trọn đời" : "Life Reading")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(lang == "vi" ? "Đóng" : "Close") {
                        dismiss()
                    }
                    .foregroundColor(theme.gold)
                }
            }
            .onAppear {
                loadCached()
                if answer.isEmpty, error == nil, settings.activeProfile != nil {
                    Task { await fetchLifeReading() }
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 40)

            Image(systemName: "sparkle.magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(theme.gold.opacity(0.6))

            VStack(spacing: 6) {
                Text(lang == "vi" ? "Lá số trọn đời" : "Life Reading")
                    .font(theme.headlineFont(size: 22))
                    .foregroundColor(theme.starlight)

                Text(lang == "vi"
                    ? "Xem toàn bộ vận mệnh cuộc đời bạn — từ khi sinh ra đến tuổi già. Bao gồm thời điểm thành công, tình duyên, gia đình, sức khoẻ và nhiều hơn nữa."
                    : "See your entire life destiny — from birth to old age. Including success timing, love, family, health, and much more.")
                    .font(theme.bodyFont(size: 14))
                    .foregroundColor(theme.mutedStarlight)
                    .multilineTextAlignment(.center)
            }

            Button(lang == "vi" ? "Xem lá số trọn đời" : "Get Your Life Reading") {
                Task { await fetchLifeReading() }
            }
            .buttonStyle(.borderedProminent)
            .tint(theme.gold)

            Spacer().frame(height: 40)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Reading Card

    // MARK: - Reading Card

    private var readingCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            readingCardBody
            sourcesSection
        }
    }

    private var readingCardBody: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "sparkle.magnifyingglass")
                    .foregroundColor(theme.amber)
                Text(lang == "vi" ? "Lá số trọn đời" : "Life Reading")
                    .font(theme.headlineFont(size: 20))
                    .foregroundColor(theme.gold)
                Spacer()
                if let profile = settings.activeProfile {
                    Text(profile.name)
                        .font(theme.labelFont(size: 11))
                        .foregroundColor(theme.subtleWhite)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(theme.surfaceContainer.opacity(0.8))
                        .clipShape(Capsule())
                }
            }

            Divider()
                .background(theme.gold.opacity(0.2))

            chartInfo

            Divider()
                .background(theme.gold.opacity(0.2))

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
    }

    private var chartInfo: some View {
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
    }

    @ViewBuilder
    private var sourcesSection: some View {
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

    // MARK: - Chinese character stripping

    private func stripChineseIfAny(_ text: String) -> String {
        let filtered = text.unicodeScalars.filter { scalar in
            guard scalar.value >= 0x4E00 && scalar.value <= 0x9FFF else { return true }
            guard scalar.value >= 0x3400 && scalar.value <= 0x4DBF else { return true }
            return false
        }
        let result = String(String.UnicodeScalarView(filtered))
        return result.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? text : result
    }

    // MARK: - Cache

    private func loadCached() {
        guard let data = UserDefaults.standard.data(forKey: cacheKey),
              let cached = try? JSONDecoder().decode(FortuneAPI.AskResponse.self, from: data) else { return }
        answer = cached.answer
        chart = cached.chart
        sources = cached.sources
    }

    // MARK: - API fetch

    private func fetchLifeReading() async {
        guard let api = FortuneAPI(serverURL: settings.serverURL),
              let profile = settings.activeProfile else {
            error = lang == "vi" ? "Chưa chọn hồ sơ." : "No active profile set."
            return
        }
        isLoading = true; error = nil
        do {
            let resp = try await api.ask(
                question: lifePrompt(profile: profile),
                birthDate: profile.birthDateString,
                birthHour: profile.birthHour,
                birthMinute: profile.birthMinute,
                birthPlace: profile.birthPlace
            )
            answer = resp.answer
            chart = resp.chart
            sources = resp.sources
            if let data = try? JSONEncoder().encode(resp) {
                UserDefaults.standard.set(data, forKey: cacheKey)
            }
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    // MARK: - Life Reading Prompt

    private func lifePrompt(profile: Profile) -> String {
        let birthStr: String = {
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            return df.string(from: Calendar.current.date(from: DateComponents(
                year: profile.birthYear, month: profile.birthMonth, day: profile.birthDay
            )) ?? Date())
        }()
        let timeStr = String(format: "%02d:%02d", profile.birthHour, profile.birthMinute)
        let placeStr = profile.birthPlace ?? (lang == "vi" ? "không rõ" : "unknown")
        let genderStr = profile.gender ?? (lang == "vi" ? "không rõ" : "unknown")
        let ageNow = Calendar.current.component(.year, from: Date()) - profile.birthYear

        if lang == "vi" {
            return """
            Dưới đây là thông tin của tôi:
            - Tên: \(profile.name)
            - Ngày sinh: \(birthStr) lúc \(timeStr)
            - Nơi sinh: \(placeStr)
            - Giới tính: \(genderStr)
            - Tuổi hiện tại: \(ageNow)

            Hãy xem LÁ SỐ TRỌN ĐỜI cho tôi. Bao gồm TẤT CẢ các mục sau, cho biết TUỔI CỤ THỂ khi có thể:

            ### Tổng quan cuộc đời
            Mục đích sống, điểm mạnh, yếu tố ngũ hành, con đường định mệnh.

            ### Sự nghiệp & Thành công (MỐC THỜI GIAN)
            Tuổi nào sự nghiệp khởi sắc? Tuổi nào đạt thành công lớn? Ngành nghề phù hợp? Những năm đỉnh cao? Khi nào chuyển hướng nghề nghiệp?

            ### Tài chính & Các cột mốc tiền bạc
            Tuổi nào ổn định tài chính? Khi nào có vận may lớn? Chiến lược tiền bạc tốt nhất? Giai đoạn cần thận trọng?

            ### Tình duyên & Hôn nhân (MỐC THỜI GIAN)
            Tuổi nào gặp bạn đời? Khi nào kết hôn? Kiểu mẫu trong quan hệ? Loại bạn đời nào phù hợp? Bao nhiêu mối tình quan trọng?

            ### Gia đình & Con cái
            Khi nào nên xây dựng gia đình? Có bao nhiêu con? Động lực gia đình và điểm mạnh khi làm cha mẹ?

            ### Sức khoẻ & Sinh lực
            Điểm mạnh và điểm yếu về sức khoẻ. Giai đoạn sinh lực cao nhất. Tuổi cần chú ý sức khoẻ. Phương pháp chăm sóc phù hợp ngũ hành.

            ### Đỉnh cao & Thung lũng cuộc đời
            Bản đồ điểm cao và giai đoạn khó khăn. Những năm bước ngoặt quan trọng. Cách vượt qua thử thách.

            ### Giai đoạn may mắn & Thận trọng
            Những năm và thập kỷ thuận lợi. Những năm cần thận trọng.

            ### Yếu tố, Màu sắc & Hướng may mắn (TRỌN ĐỜI)
            Màu sắc may mắn cá nhân. Con số may mắn. Hướng tốt cho nhà ở, làm việc, du lịch. Yếu tố hỗ trợ.

            ### Tính cách & Định mệnh
            Đặc điểm tính cách cốt lõi. Tài năng tiềm ẩn. Con đường định mệnh.

            ### Quan hệ với người khác
            Kiểu người hợp nhất. Thách thức trong quan hệ. Cách tương tác với gia đình, bạn bè, đồng nghiệp.

            ### Tuổi già & Những năm sau này (60+)
            Cuối đời ra sao? Di sản và đóng góp. Sức khoẻ khi về già.

            ### Tổng hợp đa truyền thống
            So sánh Tử Vi, Bát Tự, Kinh Dịch, chiêm tinh phương Tây — nơi đồng ý, nơi khác biệt. Dùng TẤT CẢ kiến thức có sẵn.

            QUAN TRỌNG: Cho TUỔI CỤ THỂ và KHUNG THỜI GIAN. Đừng mơ hồ. KHÔNG dùng chữ Hán hoặc ký tự Trung Quốc. Chỉ viết tiếng Việt. CỰC KỲ chi tiết — đây là lá số TRỌN ĐỜI.
            """
        }

        return """
        Here is my profile info:
        - Name: \(profile.name)
        - Born: \(birthStr) at \(timeStr)
        - Birthplace: \(placeStr)
        - Gender: \(genderStr)
        - Current age: \(ageNow)

        Give me a COMPREHENSIVE LIFE READING. Include ALL of the following sections, with SPECIFIC AGES wherever possible:

        ### Life Overview
        Life purpose, core strengths, elemental influences, destiny path.

        ### Career & Success (TIMELINE)
        What age will my career take off? At what age major success? Best industries/roles? Peak career years? When to expect career pivots?

        ### Wealth & Financial Milestones
        When will financial stability come? When to expect windfalls? Best money strategies? Periods to be cautious?

        ### Love & Relationships (TIMELINE)
        At what age will I meet a significant partner? Best time for marriage? Relationship patterns? What kind of partner complements me? How many significant relationships?

        ### Family & Children
        When should I build a family? How many children? Family dynamics and parenting strengths.

        ### Health & Vitality
        Health strengths and vulnerabilities. Peak vitality periods. Ages to watch. Recommended wellness practices.

        ### Life Peaks & Valleys
        Map major high points and challenging periods. Turning point years. How to navigate difficulties.

        ### Lucky & Unlucky Periods
        Favorable years and decades. Years to be cautious.

        ### Lucky Elements, Colors & Directions (LIFETIME)
        Personal lucky colors. Lucky numbers. Best directions for home, work, travel. Elemental allies.

        ### Personality & Destiny
        Core personality traits. Hidden talents. Destiny path.

        ### Relationships with Others
        Best compatibility. Relationship challenges. How I relate to family, friends, colleagues.

        ### Old Age & Later Years (Ages 60+)
        What my later years hold. Legacy and contributions. Health in old age.

        ### Cross-Tradition Synthesis
        Compare Zi Wei, BaZi, Yi Jing, and Western astrology — where they agree and differ. Draw from ALL available knowledge.

        IMPORTANT: Give SPECIFIC AGES and TIMEFRAMES. Do not be vague. Do NOT include Chinese characters or Hanzi. Write only in English. Be EXTREMELY thorough — this is a LIFE READING.
        """
    }
}
