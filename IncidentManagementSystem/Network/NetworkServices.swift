import Foundation

// MARK: - Network Error

public enum NetworkError: Error, Equatable {
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonParsingFailure
    case noInternet
    case failedSerialization
    case badRequest
    case errorResponse(message: String)

    public var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed error -> \(description)"
        case .invalidData: return "Invalid Data error)"
        case let .responseUnsuccessful(description): return "Response Unsuccessful error -> \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure error)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure -> \(description)"
        case .noInternet: return "No internet connection"
        case .failedSerialization: return "Serialization print for debug failed."
        case .badRequest: return "Invalid URL"
        case let .errorResponse(message): return message
        }
    }
}

// MARK: - Network Service Protocol

public protocol NetworkServiceProtocol {
    func load<Response: Decodable>(
        _: Response.Type,
        with api: NetworkBuilder
    ) async throws -> Response
}

// MARK: - API Client

public enum ApiClient {
    public static func load<Response: Decodable>(
        _: Response.Type,
        with api: NetworkBuilder
    ) async throws -> Response {
        guard let urlRequest = api.buildRequest() else {
            throw NetworkError.badRequest
        }
        
        let (data, response) = try await api.urlSession.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed(description: "Invalid response")
        }
        
        guard httpResponse.statusCode.isSuccess else {
            do {
                // Try to decode the error response
                let errorMessage: ErrorResponse = try decodeErrorResponse(from: data, using: api.decoder)
                throw NetworkError.errorResponse(message: errorMessage.message)
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        api.decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            // Try to decode the successful response
            return try api.decoder.decode(Response.self, from: data)
        } catch {
            debugPrint(error)
            throw NetworkError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
    
    private static func decodeErrorResponse<T: Decodable>(from data: Data, using decoder: JSONDecoder) throws -> T {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: - HTTP Status Code Extension

public extension Int {
    var isSuccess: Bool {
        self == 200
    }
}

// MARK: - Error Response Structure

struct ErrorResponse: Decodable {
    let message: String
}
