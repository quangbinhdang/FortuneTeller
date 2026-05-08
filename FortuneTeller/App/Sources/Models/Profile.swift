import Foundation

/// User profile with birth information for fortune reading.
/// Supports multiple profiles; one is active at a time.
@Observable
final class Profile: Identifiable, Hashable, Equatable {
    var id: String
    var name: String

    var birthYear: Int
    var birthMonth: Int
    var birthDay: Int

    /// Birth hour (0-23). Critical for BaZi Hour Pillar. Defaults to noon.
    var birthHour: Int

    /// Birth minute (0-59). For precise BaZi calculations. Defaults to 0.
    var birthMinute: Int

    /// Optional: city or region name for local solar time correction
    var birthPlace: String?

    /// Optional: "male" or "female" — some Zi Wei schools use for 身宫 placement
    var gender: String?

    /// Preferred tradition: "auto", "ziwei", "bazi", "western"
    var preferredTradition: String

    /// When this profile was created
    var createdAt: Date

    init(
        id: String = UUID().uuidString,
        name: String,
        birthYear: Int,
        birthMonth: Int,
        birthDay: Int,
        birthHour: Int = 12,
        birthMinute: Int = 0,
        birthPlace: String? = nil,
        gender: String? = nil,
        preferredTradition: String = "auto",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.birthYear = birthYear
        self.birthMonth = birthMonth
        self.birthDay = birthDay
        self.birthHour = birthHour
        self.birthMinute = birthMinute
        self.birthPlace = birthPlace
        self.gender = gender
        self.preferredTradition = preferredTradition
        self.createdAt = createdAt
    }

    /// Formatted birth date string for the API (YYYY-MM-DD)
    var birthDateString: String {
        String(format: "%04d-%02d-%02d", birthYear, birthMonth, birthDay)
    }

    /// Display string for birth info
    var birthDisplay: String {
        let timeStr = String(format: "%02d:%02d", birthHour, birthMinute)
        if let place = birthPlace, !place.isEmpty {
            return "\(birthDateString) \(timeStr) — \(place)"
        }
        return "\(birthDateString) \(timeStr)"
    }

    // MARK: - Hashable / Equatable
    static func == (lhs: Profile, rhs: Profile) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - Codable (manual, since @Observable class cannot auto-synthesize)

extension Profile: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, birthYear, birthMonth, birthDay, birthHour, birthMinute
        case birthPlace, gender, preferredTradition, createdAt
    }

    convenience init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try c.decode(String.self, forKey: .id),
            name: try c.decode(String.self, forKey: .name),
            birthYear: try c.decode(Int.self, forKey: .birthYear),
            birthMonth: try c.decode(Int.self, forKey: .birthMonth),
            birthDay: try c.decode(Int.self, forKey: .birthDay),
            birthHour: try c.decodeIfPresent(Int.self, forKey: .birthHour) ?? 12,
            birthMinute: try c.decodeIfPresent(Int.self, forKey: .birthMinute) ?? 0,
            birthPlace: try c.decodeIfPresent(String.self, forKey: .birthPlace),
            gender: try c.decodeIfPresent(String.self, forKey: .gender),
            preferredTradition: try c.decodeIfPresent(String.self, forKey: .preferredTradition) ?? "auto",
            createdAt: try c.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
        )
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(name, forKey: .name)
        try c.encode(birthYear, forKey: .birthYear)
        try c.encode(birthMonth, forKey: .birthMonth)
        try c.encode(birthDay, forKey: .birthDay)
        try c.encode(birthHour, forKey: .birthHour)
        try c.encode(birthMinute, forKey: .birthMinute)
        try c.encodeIfPresent(birthPlace, forKey: .birthPlace)
        try c.encodeIfPresent(gender, forKey: .gender)
        try c.encode(preferredTradition, forKey: .preferredTradition)
        try c.encode(createdAt, forKey: .createdAt)
    }
}
