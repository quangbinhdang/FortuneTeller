import SwiftUI

// MARK: - Setup Wizard View

/// Onboarding wizard: set up profile + server connection.
struct SetupWizardView: View {
    @Environment(AppSettings.self) private var settings
    @State private var name = ""
    @State private var birthYear = 1990
    @State private var birthMonth = 1
    @State private var birthDay = 1
    @State private var birthHour = 12
    @State private var birthMinute = 0
    @State private var birthPlace = ""
    @State private var serverURL = "https://fortuneteller.binaryradish.com"

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            Form {
                Section(loc("Your Profile", "Hồ sơ của bạn", language: lang)) {
                    TextField(loc("Name", "Tên", language: lang), text: $name)
                    HStack {
                        Picker(loc("Year", "Năm", language: lang), selection: $birthYear) {
                            ForEach(1900...2026, id: \.self) { y in
                                Text(verbatim: "\(y)").tag(y)
                            }
                        }
                        Picker(loc("Month", "Tháng", language: lang), selection: $birthMonth) {
                            ForEach(1...12, id: \.self) { m in
                                Text(verbatim: "\(m)").tag(m)
                            }
                        }
                        Picker(loc("Day", "Ngày", language: lang), selection: $birthDay) {
                            ForEach(1...31, id: \.self) { d in
                                Text(verbatim: "\(d)").tag(d)
                            }
                        }
                    }

                    // 24h time picker with minute precision
                    DatePicker(
                        loc("Birth time", "Giờ sinh", language: lang),
                        selection: birthTimeBinding(
                            hour: $birthHour,
                            minute: $birthMinute
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .environment(\.locale, Locale(identifier: "en_GB")) // force 24h

                    PlacePickerView(selection: $birthPlace)
                }

                Section(loc("Server", "Máy chủ", language: lang)) {
                    TextField(loc("Server URL", "URL máy chủ", language: lang), text: $serverURL)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }

                Section {
                    Button(loc("Get Started", "Bắt đầu", language: lang)) {
                        let profile = Profile(
                            name: name.isEmpty ? (lang == "vi" ? "Tôi" : "Me") : name,
                            birthYear: birthYear,
                            birthMonth: birthMonth,
                            birthDay: birthDay,
                            birthHour: birthHour,
                            birthMinute: birthMinute,
                            birthPlace: birthPlace.isEmpty ? nil : birthPlace
                        )
                        settings.serverURL = serverURL.isEmpty ? "https://fortuneteller.binaryradish.com" : serverURL
                        settings.addProfile(profile)
                        settings.hasCompletedSetup = true
                    }
                }
            }
            .navigationTitle(loc("Welcome", "Chào mừng", language: lang))
        }
    }
}
