import SwiftUI

@main
struct FortuneTellerApp: App {
    @State private var settings = AppSettings.load()
    private let theme = AppVisualTheme()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(settings)
                .environment(\.theme, theme)
                .tint(theme.gold)
                .preferredColorScheme(.dark)
        }
    }
}

struct RootView: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        Group {
            if settings.isConfigured {
                RootTabView()
            } else {
                SetupWizardView()
            }
        }
    }
}
