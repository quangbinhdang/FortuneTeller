import Foundation

/// One-sentence fortune per day per profile.
/// Refreshable daily. Deterministic — same profile + same date = same fortune.
struct CookieFortune: Codable, Identifiable, Hashable {
    var id: String { "\(profileId)_\(date)" }

    let profileId: String
    let date: String          // YYYY-MM-DD
    let fortune: String        // One sentence
    let fetchedAt: Date

    /// Whether the user has "cracked open" (viewed) today's cookie
    var hasBeenRevealed: Bool
}
