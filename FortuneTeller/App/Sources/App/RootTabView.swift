import SwiftUI

enum AppTab: Hashable { case today, cookie, chat, garden, shadow, settings }

struct RootTabView: View {
    @Environment(AppSettings.self) private var settings
    @State private var selectedTab: AppTab = .today

    private var lang: String { settings.language }

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayReadingView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Hôm nay" : "Today",
                        systemImage: "moon.stars.fill"
                    )
                }
                .tag(AppTab.today)
            CookieFortuneView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Bánh quy" : "Cookie",
                        systemImage: "sparkles"
                    )
                }
                .tag(AppTab.cookie)
            ChatView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Trò chuyện" : "Chat",
                        systemImage: "bubble.left.and.text.bubble.right"
                    )
                }
                .tag(AppTab.chat)
            FortuneGardenView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Vườn" : "Garden",
                        systemImage: "leaf.fill"
                    )
                }
                .tag(AppTab.garden)
            ShadowReadingView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Bóng tối" : "Shadow",
                        systemImage: "eye.fill"
                    )
                }
                .tag(AppTab.shadow)
            SettingsView()
                .tabItem {
                    Label(
                        lang == "vi" ? "Cài đặt" : "Settings",
                        systemImage: "gearshape.fill"
                    )
                }
                .tag(AppTab.settings)
        }
    }
}
