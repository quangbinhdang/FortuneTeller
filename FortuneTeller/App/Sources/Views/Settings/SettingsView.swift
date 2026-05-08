import SwiftUI

/// App settings: language, profiles, server status.
struct SettingsView: View {
    @Environment(AppSettings.self) private var settings
    @State private var showAddProfile = false
    @State private var editingProfile: Profile?
    @State private var serverStatus: ServerStatus = .checking

    enum ServerStatus { case checking, online, offline }

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            List {
                // MARK: - Language
                Section(loc("Language", "Ngôn ngữ", language: lang)) {
                    Picker("Display Language", selection: Binding(
                        get: { settings.language },
                        set: { settings.language = $0 }
                    )) {
                        Text("English").tag("en")
                        Text("Tiếng Việt").tag("vi")
                    }
                    .pickerStyle(.segmented)
                }

                // MARK: - Active Profile
                Section(loc("Active Profile", "Hồ sơ đang dùng", language: lang)) {
                    if let active = settings.activeProfile {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(active.name).font(.headline)
                                Text(active.birthDisplay)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.purple)
                        }
                    } else {
                        Label(
                            loc("No profile selected", "Chưa chọn hồ sơ", language: lang),
                            systemImage: "person.crop.circle.badge.exclamationmark"
                        )
                        .foregroundStyle(.secondary)
                    }
                }

                // MARK: - Manage Profiles
                Section(loc("Profiles", "Hồ sơ", language: lang)) {
                    ForEach(settings.profiles) { profile in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(profile.name).font(.body)
                                Text(profile.birthDisplay)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            if settings.activeProfileId == profile.id {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundStyle(.purple)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture { editingProfile = profile }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                settings.deleteProfile(profile)
                            } label: {
                                Label(
                                    loc("Delete", "Xoá", language: lang),
                                    systemImage: "trash"
                                )
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                settings.setActiveProfile(profile)
                            } label: {
                                Label(
                                    loc("Set Active", "Đặt làm chính", language: lang),
                                    systemImage: "star"
                                )
                            }
                            .tint(.purple)
                        }
                    }

                    Button {
                        showAddProfile = true
                    } label: {
                        Label(
                            loc("Add Profile", "Thêm hồ sơ", language: lang),
                            systemImage: "person.badge.plus"
                        )
                    }
                }

                // MARK: - Server
                Section(loc("Server", "Máy chủ", language: lang)) {
                    HStack {
                        Label(
                            loc("Connection", "Kết nối", language: lang),
                            systemImage: serverIcon
                        )
                        Spacer()
                        Text(serverText)
                            .font(.caption)
                            .foregroundStyle(serverColor)
                    }
                    HStack {
                        Text(loc("Server URL", "URL máy chủ", language: lang))
                        Spacer()
                        Text(displayURL)
                            .font(.caption.monospaced())
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                }

                // MARK: - About
                Section(loc("About", "Thông tin", language: lang)) {
                    LabeledContent(loc("Version", "Phiên bản", language: lang), value: "0.1.0")
                    LabeledContent(
                        loc("Powered by", "Cung cấp bởi", language: lang),
                        value: "20 classical texts"
                    )
                }
            }
            .navigationTitle(loc("Settings", "Cài đặt", language: lang))
            .sheet(isPresented: $showAddProfile) {
                AddProfileView()
            }
            .sheet(item: $editingProfile) { profile in
                EditProfileView(profile: binding(for: profile))
            }
            .task { await checkServer() }
        }
    }

    // MARK: - Server status

    private var serverIcon: String {
        switch serverStatus {
        case .checking: return "hourglass"
        case .online: return "checkmark.icloud.fill"
        case .offline: return "xmark.icloud.fill"
        }
    }

    private var serverText: String {
        switch serverStatus {
        case .checking: return loc("Checking...", "Đang kiểm tra...", language: lang)
        case .online: return loc("Connected", "Đã kết nối", language: lang)
        case .offline: return loc("Offline", "Mất kết nối", language: lang)
        }
    }

    private var serverColor: Color {
        switch serverStatus {
        case .checking: return .secondary
        case .online: return .green
        case .offline: return .red
        }
    }

    private var displayURL: String {
        guard let url = URL(string: settings.serverURL) else { return settings.serverURL }
        return url.host ?? settings.serverURL
    }

    private func checkServer() async {
        guard let api = FortuneAPI(serverURL: settings.serverURL) else {
            serverStatus = .offline
            return
        }
        do {
            _ = try await api.health()
            serverStatus = .online
        } catch {
            serverStatus = .offline
        }
    }

    private func binding(for profile: Profile) -> Binding<Profile> {
        Binding(
            get: { profile },
            set: { settings.updateProfile($0) }
        )
    }
}

// MARK: - Add Profile

struct AddProfileView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var birthYear = 1990
    @State private var birthMonth = 1
    @State private var birthDay = 1
    @State private var birthHour = 12
    @State private var birthMinute = 0
    @State private var birthPlace = ""
    @State private var gender = ""
    @State private var preferredTradition = "auto"

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            Form {
                Section(loc("Basic Info", "Thông tin cơ bản", language: lang)) {
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

                    DatePicker(
                        loc("Birth time", "Giờ sinh", language: lang),
                        selection: birthTimeBinding(
                            hour: $birthHour,
                            minute: $birthMinute
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .environment(\.locale, Locale(identifier: "en_GB"))
                }

                Section(loc("Details (optional)", "Chi tiết (tuỳ chọn)", language: lang)) {
                    PlacePickerView(selection: $birthPlace)
                    Picker(loc("Gender", "Giới tính", language: lang), selection: $gender) {
                        Text(loc("Not set", "Không đặt", language: lang)).tag("")
                        Text(loc("Male", "Nam", language: lang)).tag("male")
                        Text(loc("Female", "Nữ", language: lang)).tag("female")
                    }
                    Picker(loc("Tradition", "Truyền thống", language: lang), selection: $preferredTradition) {
                        Text(loc("Auto", "Tự động", language: lang)).tag("auto")
                        Text("Zi Wei").tag("ziwei")
                        Text("BaZi").tag("bazi")
                        Text("Western").tag("western")
                    }
                }
            }
            .navigationTitle(loc("New Profile", "Hồ sơ mới", language: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(loc("Cancel", "Huỷ", language: lang)) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(loc("Save", "Lưu", language: lang)) {
                        let profile = Profile(
                            name: name.isEmpty ? (lang == "vi" ? "Không tên" : "Unnamed") : name,
                            birthYear: birthYear,
                            birthMonth: birthMonth,
                            birthDay: birthDay,
                            birthHour: birthHour,
                            birthMinute: birthMinute,
                            birthPlace: birthPlace.isEmpty ? nil : birthPlace,
                            gender: gender.isEmpty ? nil : gender,
                            preferredTradition: preferredTradition
                        )
                        settings.addProfile(profile)
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Edit Profile

struct EditProfileView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    @State private var name: String
    @State private var birthYear: Int
    @State private var birthMonth: Int
    @State private var birthDay: Int
    @State private var birthHour: Int
    @State private var birthMinute: Int
    @State private var birthPlace: String
    @State private var gender: String
    @State private var preferredTradition: String

    private var lang: String { settings.language }

    init(profile: Binding<Profile>) {
        self._profile = profile
        _name = State(initialValue: profile.wrappedValue.name)
        _birthYear = State(initialValue: profile.wrappedValue.birthYear)
        _birthMonth = State(initialValue: profile.wrappedValue.birthMonth)
        _birthDay = State(initialValue: profile.wrappedValue.birthDay)
        _birthHour = State(initialValue: profile.wrappedValue.birthHour)
        _birthMinute = State(initialValue: profile.wrappedValue.birthMinute)
        _birthPlace = State(initialValue: profile.wrappedValue.birthPlace ?? "")
        _gender = State(initialValue: profile.wrappedValue.gender ?? "")
        _preferredTradition = State(initialValue: profile.wrappedValue.preferredTradition)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(loc("Basic Info", "Thông tin cơ bản", language: lang)) {
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

                    DatePicker(
                        loc("Birth time", "Giờ sinh", language: lang),
                        selection: birthTimeBinding(
                            hour: $birthHour,
                            minute: $birthMinute
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .environment(\.locale, Locale(identifier: "en_GB"))
                }

                Section(loc("Details (optional)", "Chi tiết (tuỳ chọn)", language: lang)) {
                    PlacePickerView(selection: $birthPlace)
                    Picker(loc("Gender", "Giới tính", language: lang), selection: $gender) {
                        Text(loc("Not set", "Không đặt", language: lang)).tag("")
                        Text(loc("Male", "Nam", language: lang)).tag("male")
                        Text(loc("Female", "Nữ", language: lang)).tag("female")
                    }
                    Picker(loc("Tradition", "Truyền thống", language: lang), selection: $preferredTradition) {
                        Text(loc("Auto", "Tự động", language: lang)).tag("auto")
                        Text("Zi Wei").tag("ziwei")
                        Text("BaZi").tag("bazi")
                        Text("Western").tag("western")
                    }
                }
            }
            .navigationTitle(loc("Edit Profile", "Sửa hồ sơ", language: lang))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(loc("Cancel", "Huỷ", language: lang)) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(loc("Save", "Lưu", language: lang)) {
                        profile.name = name
                        profile.birthYear = birthYear
                        profile.birthMonth = birthMonth
                        profile.birthDay = birthDay
                        profile.birthHour = birthHour
                        profile.birthMinute = birthMinute
                        profile.birthPlace = birthPlace.isEmpty ? nil : birthPlace
                        profile.gender = gender.isEmpty ? nil : gender
                        profile.preferredTradition = preferredTradition
                        settings.updateProfile(profile)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppSettings())
}
