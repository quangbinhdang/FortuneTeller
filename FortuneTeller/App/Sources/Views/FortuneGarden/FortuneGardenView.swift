import SwiftUI

// MARK: - Plant Model

struct GardenPlant: Identifiable, Codable {
    let id: String
    var name: String
    var stage: Int       // 0–5
    var maxStage: Int    // typically 5
    var lastWatered: Date?
    var icon: String     // SF Symbol name
    var colorHex: String // hex for the accent color

    var progress: Double {
        Double(stage) / Double(maxStage)
    }

    var stageLabel: String {
        "Stage \(stage)/\(maxStage)"
    }

    var stageLabelVi: String {
        "Giai đoạn \(stage)/\(maxStage)"
    }
}

struct GardenState: Codable {
    var plants: [GardenPlant]
    var gardenDay: Int

    static func `default`() -> GardenState {
        GardenState(
            plants: [
                GardenPlant(id: "moonflower", name: "Moonflower", stage: 2, maxStage: 5, lastWatered: nil, icon: "moon.stars.fill", colorHex: "#D4A76A"),
                GardenPlant(id: "starbloom", name: "Star-bloom", stage: 1, maxStage: 5, lastWatered: nil, icon: "sparkles", colorHex: "#C8B8D8"),
                GardenPlant(id: "vine", name: "Constellation Vine", stage: 3, maxStage: 5, lastWatered: nil, icon: "point.topleft.down.to.point.bottomright.curvepath.fill", colorHex: "#8B7DAA"),
            ],
            gardenDay: 0
        )
    }
}

// MARK: - Fortune Garden View

struct FortuneGardenView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.theme) private var theme

    @State private var garden: GardenState = .default()
    @State private var showFlourish = false

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 4) {
                        Text(lang == "vi" ? "Vườn may mắn" : "Fortune Garden")
                            .font(theme.headlineFont(size: 28))
                            .foregroundColor(theme.gold)

                        HStack(spacing: 6) {
                            Image(systemName: "leaf.fill")
                                .font(.caption)
                                .foregroundColor(theme.gold.opacity(0.6))
                            Text(lang == "vi"
                                ? "\(garden.plants.filter { $0.stage > 0 }.count) cây đang lớn"
                                : "\(garden.plants.filter { $0.stage > 0 }.count) plants growing")
                                .font(.caption)
                                .foregroundColor(theme.subtleWhite)
                        }
                    }
                    .padding(.top, 8)

                    // Garden illustration area
                    gardenIllustration

                    // Plant progress cards
                    VStack(spacing: 12) {
                        ForEach($garden.plants) { $plant in
                            plantCard($plant)
                        }
                    }

                    // Tip
                    Text(lang == "vi"
                        ? "Quay lại mỗi ngày để tưới vườn"
                        : "Return daily to water your garden")
                        .font(.caption)
                        .foregroundColor(theme.subtleWhite.opacity(0.5))
                        .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .background(theme.background)
            .navigationTitle(lang == "vi" ? "Vườn" : "Garden")
            .navigationBarHidden(true)
            .onAppear { loadGarden() }
        }
    }

    // MARK: - Garden Scene

    private var gardenIllustration: some View {
        ZStack {
            // Gradient soil → night sky
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.039, green: 0.102, blue: 0.059), // #0A1A0F forest floor
                    theme.background,
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            // Decorative elements
            VStack(spacing: 0) {
                Spacer()

                // Plants row
                HStack(alignment: .bottom, spacing: 20) {
                    plantSprite(icon: "moon.stars.fill", color: Color(hex: "#D4A76A") ?? theme.gold, size: 60)
                    plantSprite(icon: "sparkles", color: Color(hex: "#C8B8D8") ?? theme.mutedStarlight, size: 50)
                    plantSprite(icon: "point.topleft.down.to.point.bottomright.curvepath.fill", color: Color(hex: "#8B7DAA") ?? theme.violet, size: 55)
                }

                // Ground
                Rectangle()
                    .fill(Color(red: 0.039, green: 0.082, blue: 0.047))
                    .frame(height: 8)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Spacer().frame(height: 12)
            }

            // Fireflies / floating particles
            ForEach(0..<8, id: \.self) { i in
                Circle()
                    .fill(theme.gold.opacity(0.5))
                    .frame(width: 3, height: 3)
                    .blur(radius: 1)
                    .offset(
                        x: CGFloat.random(in: -140...140),
                        y: CGFloat.random(in: -80...60)
                    )
                    .opacity(showFlourish ? 0.7 : 0.2)
            }
        }
        .frame(height: 200)
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                showFlourish = true
            }
        }
    }

    private func plantSprite(icon: String, color: Color, size: CGFloat) -> some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: size + 20, height: size + 20)
                .blur(radius: 12)

            // Icon
            Image(systemName: icon)
                .font(.system(size: size * 0.5))
                .foregroundColor(color)
                .scaleEffect(showFlourish ? 1.0 : 0.9)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: showFlourish)
        }
    }

    // MARK: - Plant Card

    private func plantCard(_ plant: Binding<GardenPlant>) -> some View {
        let color = Color(hex: plant.wrappedValue.colorHex) ?? theme.gold

        return HStack(spacing: 14) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)

                Image(systemName: plant.wrappedValue.icon)
                    .font(.title3)
                    .foregroundColor(color)
            }

            // Info + progress
            VStack(alignment: .leading, spacing: 4) {
                Text(plant.wrappedValue.name)
                    .font(.body.weight(.medium))
                    .foregroundColor(theme.starlight)

                Text(lang == "vi" ? plant.wrappedValue.stageLabelVi : plant.wrappedValue.stageLabel)
                    .font(.caption)
                    .foregroundColor(theme.subtleWhite)
            }

            Spacer()

            // Constellation-style progress
            constellationProgress(
                current: plant.wrappedValue.stage,
                max: plant.wrappedValue.maxStage,
                color: color
            )
            .frame(width: 140)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.surfaceContainer.opacity(0.5))
                .background(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.2), lineWidth: 0.5)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        // Water on tap
        .onTapGesture {
            waterPlant(plant)
        }
    }

    // MARK: - Constellation Progress Bar

    private func constellationProgress(current: Int, max: Int, color: Color) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<max, id: \.self) { i in
                // Star dot
                Circle()
                    .fill(i < current ? color : color.opacity(0.15))
                    .frame(width: i < current ? 10 : 6, height: i < current ? 10 : 6)

                // Connector line
                if i < max - 1 {
                    Capsule()
                        .fill(i < current ? color.opacity(0.5) : color.opacity(0.08))
                        .frame(height: 1.5)
                }
            }
        }
    }

    // MARK: - Water Logic

    private func waterPlant(_ plant: Binding<GardenPlant>) {
        guard plant.wrappedValue.stage < plant.wrappedValue.maxStage else { return }

        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            plant.wrappedValue.stage += 1
            plant.wrappedValue.lastWatered = Date()
        }
        saveGarden()
    }

    // MARK: - Persistence

    private func loadGarden() {
        let key = "garden_\(settings.activeProfileId ?? "default")"
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode(GardenState.self, from: data) {
            garden = saved
        }
    }

    private func saveGarden() {
        let key = "garden_\(settings.activeProfileId ?? "default")"
        if let data = try? JSONEncoder().encode(garden) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

// MARK: - Color Hex Extension

private extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        guard Scanner(string: hex).scanHexInt64(&int) else { return nil }
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default: return nil
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1.0
        )
    }
}

#Preview {
    FortuneGardenView()
        .environment(AppSettings())
        .environment(\.theme, AppVisualTheme())
        .preferredColorScheme(.dark)
}
