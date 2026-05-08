import Foundation

/// Single message in a chat conversation with the FortuneTeller.
struct ChatMessage: Codable, Identifiable, Hashable {
    var id: String
    var role: String          // "user" | "assistant"
    var content: String
    var timestamp: Date

    /// Sources cited (assistant messages only)
    var sources: [ReadingSource]?

    var isUser: Bool { role == "user" }
    var isAssistant: Bool { role == "assistant" }

    struct ReadingSource: Codable, Hashable {
        let file: String
        let relevance: Double
    }
}
