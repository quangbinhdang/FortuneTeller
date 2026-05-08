import Foundation

/// REST API client for the FortuneTeller server.
/// Connects to the local or Cloudflare-tunneled server endpoint.
struct FortuneAPI {
    let baseURL: URL
    let session: URLSession
    let decoder: JSONDecoder
    let encoder: JSONEncoder

    init(baseURL: URL) {
        self.baseURL = baseURL
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 180
        config.timeoutIntervalForResource = 300
        config.waitsForConnectivity = true
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: config)

        let dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = dec

        let enc = JSONEncoder()
        enc.keyEncodingStrategy = .convertToSnakeCase
        self.encoder = enc
    }

    init?(serverURL: String) {
        guard let url = URL(string: serverURL), !serverURL.isEmpty else { return nil }
        self.init(baseURL: url)
    }

    // MARK: - API models

    struct AskResponse: Codable {
        let answer: String
        let sources: [SourceInfo]
        let chart: String?
        let language: String
        let model: String
        let responseTimeMs: Double

        struct SourceInfo: Codable {
            let file: String
            let chunk: Int
            let relevance: Double
        }
    }

    struct HealthResponse: Codable {
        let status: String
        let version: String
        let chromaChunks: Int
        let ollamaModel: String
    }

    // MARK: - Endpoints

    func health() async throws -> HealthResponse {
        var req = URLRequest(url: baseURL.appendingPathComponent("health"))
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw APIError.http((resp as? HTTPURLResponse)?.statusCode ?? 0)
        }
        return try decoder.decode(HealthResponse.self, from: data)
    }

    func ask(
        question: String,
        birthDate: String?,
        birthHour: Int? = 12,
        birthMinute: Int? = 0
    ) async throws -> AskResponse {
        var req = URLRequest(url: baseURL.appendingPathComponent("ask"))
        req.httpMethod = "POST"
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        var body: [String: Any] = ["question": question]
        if let bd = birthDate { body["birth_date"] = bd }
        if let bh = birthHour { body["birth_hour"] = bh }
        if let bm = birthMinute { body["birth_minute"] = bm }

        req.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.http(http.statusCode)
        }
        return try decoder.decode(AskResponse.self, from: data)
    }

    enum APIError: LocalizedError {
        case invalidResponse
        case http(Int)

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid server response"
            case .http(let code): return "Server error (HTTP \(code))"
            }
        }
    }
}
