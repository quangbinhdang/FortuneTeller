import Foundation
import Observation

/// App-level settings and state. Persisted to UserDefaults via JSON snapshot.
/// Mirrors Magic Advisor's AppSettings pattern.
@Observable
final class AppSettings {
    /// Server URL — defaults to localhost for dev, Cloudflare tunnel for production
    var serverURL: String {
        didSet { persist() }
    }

    /// App display language: "en" or "vi"
    var language: String {
        didSet { persist() }
    }

    /// The currently active profile ID
    var activeProfileId: String? {
        didSet { persist() }
    }

    /// All user profiles
    var profiles: [Profile] {
        didSet { persist() }
    }

    var hasCompletedSetup: Bool {
        didSet { persist() }
    }

    var isConfigured: Bool {
        hasCompletedSetup && !serverURL.isEmpty && activeProfileId != nil
    }

    /// The active profile (derived)
    var activeProfile: Profile? {
        guard let id = activeProfileId else { return nil }
        return profiles.first { $0.id == id }
    }

    // MARK: - Init

    init(
        serverURL: String = "https://fortuneteller.binaryradish.com",
        language: String = "en",
        profiles: [Profile] = [],
        activeProfileId: String? = nil,
        hasCompletedSetup: Bool = false
    ) {
        self.serverURL = serverURL
        self.language = language
        self.profiles = profiles
        self.activeProfileId = activeProfileId
        self.hasCompletedSetup = hasCompletedSetup
    }

    // MARK: - Profile management

    func addProfile(_ profile: Profile) {
        profiles.append(profile)
        if activeProfileId == nil {
            activeProfileId = profile.id
        }
    }

    func updateProfile(_ profile: Profile) {
        if let idx = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles[idx] = profile
        }
    }

    func deleteProfile(_ profile: Profile) {
        profiles.removeAll { $0.id == profile.id }
        if activeProfileId == profile.id {
            activeProfileId = profiles.first?.id
        }
    }

    func setActiveProfile(_ profile: Profile) {
        activeProfileId = profile.id
    }

    // MARK: - Persistence

    private static let defaultsKey = "FortuneTeller.settings.v1"

    private struct Snapshot: Codable {
        var serverURL: String
        var language: String
        var profiles: [Profile]
        var activeProfileId: String?
        var hasCompletedSetup: Bool
    }

    static func load() -> AppSettings {
        if let data = UserDefaults.standard.data(forKey: defaultsKey),
           let snap = try? JSONDecoder().decode(Snapshot.self, from: data) {
            return AppSettings(
                serverURL: snap.serverURL.isEmpty ? "https://fortuneteller.binaryradish.com" : snap.serverURL,
                language: snap.language.isEmpty ? "en" : snap.language,
                profiles: snap.profiles,
                activeProfileId: snap.activeProfileId,
                hasCompletedSetup: snap.hasCompletedSetup
            )
        }
        return AppSettings()
    }

    private func persist() {
        let snap = Snapshot(
            serverURL: serverURL,
            language: language,
            profiles: profiles,
            activeProfileId: activeProfileId,
            hasCompletedSetup: hasCompletedSetup
        )
        if let data = try? JSONEncoder().encode(snap) {
            UserDefaults.standard.set(data, forKey: Self.defaultsKey)
        }
    }
}
