import SwiftUI

// MARK: - Visual Theme

/// Semantic design tokens derived from the Stitch "Ethereal Ritualism" design system.
/// Immutable value type — hand a single instance through the environment.
struct AppVisualTheme: Sendable {
    // MARK: - Color tokens

    /// Midnight-purple base (#0C0418 → hex approx)
    let background: Color

    /// Surface / card background (#180f24)
    let surface: Color

    /// Elevated container (#251b31)
    let surfaceContainer: Color

    /// Primary gold (#D4A76A / #F2C283)
    let gold: Color

    /// Muted amber (#B8944A)
    let amber: Color

    /// Deep violet (#1A0B2E / #524267)
    let violet: Color

    /// Starlight text (#EDDCFB)
    let starlight: Color

    /// Muted starlight (#C8B8D8) — for secondary / shadow reading text
    let mutedStarlight: Color

    /// Subtle white at low opacity
    let subtleWhite: Color

    /// Danger / destructive tint
    let danger: Color

    // MARK: - Font roles

    /// EB Garamond serif for headlines and display text
    func headlineFont(size: CGFloat, weight: Font.Weight = .medium) -> Font {
        .custom("EBGaramond-Medium", size: size).weight(weight)
    }

    /// Manrope for body text
    func bodyFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Manrope-Regular", size: size).weight(weight)
    }

    /// Manrope for labels
    func labelFont(size: CGFloat, weight: Font.Weight = .semibold) -> Font {
        .custom("Manrope-SemiBold", size: size).weight(weight)
    }

    /// Monospaced font for chart data
    func monoFont(size: CGFloat) -> Font {
        .system(size: size, design: .monospaced)
    }

    // MARK: - Initializer

    init(accentColor: Color = .purple) {
        self.background = Color(red: 0.047, green: 0.016, blue: 0.094) // #0C0418
        self.surface = Color(red: 0.094, green: 0.059, blue: 0.141)   // #180f24
        self.surfaceContainer = Color(red: 0.145, green: 0.106, blue: 0.192) // #251b31
        self.gold = Color(red: 0.831, green: 0.655, blue: 0.416)       // #D4A76A
        self.amber = Color(red: 0.722, green: 0.580, blue: 0.290)      // #B8944A
        self.violet = Color(red: 0.102, green: 0.043, blue: 0.180)     // #1A0B2E
        self.starlight = Color(red: 0.929, green: 0.863, blue: 0.984)  // #EDDCFB
        self.mutedStarlight = Color(red: 0.784, green: 0.722, blue: 0.847) // #C8B8D8
        self.subtleWhite = .white.opacity(0.35)
        self.danger = Color(red: 0.729, green: 0.267, blue: 0.267)     // muted red
    }

    // MARK: - Convenience view modifiers

    /// Applies the midnight background + glassmorphism card style
    func cardBackground<V: View>(_ content: V) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(surfaceContainer.opacity(0.6))
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(gold.opacity(0.15), lineWidth: 0.5)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    func screenBackground<V: View>(_ content: V) -> some View {
        content.background(background)
    }
}

// MARK: - Environment Key

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppVisualTheme = AppVisualTheme()
}

extension EnvironmentValues {
    var theme: AppVisualTheme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
