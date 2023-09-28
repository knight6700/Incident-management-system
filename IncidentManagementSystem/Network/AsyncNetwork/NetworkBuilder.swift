
import Foundation

public struct NetworkBuilder {
    var baseURL: String {
        // TODO: - Add More Base URL For Deferent Target Environment
        #if DEBUG
            return "05310e18-5ee7-4191-bbbd-9d2d14e4baf8.mock.pstmn.io/"
        #elseif RELEASE
            return "05310e18-5ee7-4191-bbbd-9d2d14e4baf8.mock.pstmn.io/"
        #else
            return "05310e18-5ee7-4191-bbbd-9d2d14e4baf8.mock.pstmn.io/"
        #endif
    }

    var schema: String {
        // TODO: - Add More Schema For Deferent Target Environment
        "https"
    }

    let endpoint: String
    var body: Encodable?
    var method: HTTPMethod
    var headers: [String: String?] {
        let dictionary = ["Accept": "application/json",
                          "Content-Type": "application/json"]
        return dictionary
    }

    let decoder = JSONDecoder()
    let urlSession = URLSession.shared
    private var queryItems: [URLQueryItem]? {
        guard let body = body?.asDictionary,
              method == .get
        else {
            return nil
        }
        return body.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }

    public init(
        endpoint: String,
        body: Encodable? = nil,
        method: HTTPMethod
    ) {
        self.endpoint = endpoint
        self.body = body
        self.method = method
    }

    func buildRequest() -> URLRequest? {
        var urlRequest = generateQueryURLRequest()
        headers.forEach {
            urlRequest?.addValue($0.value ?? "", forHTTPHeaderField: $0.key)
        }
        urlRequest?.httpMethod = method.rawValue
        guard method != .get else {
            return urlRequest
        }
        urlRequest?.httpBody = encode

        return urlRequest
    }

    func generateQueryURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = schema
        components.path = "\(baseURL)\(endpoint)"
        components.queryItems = queryItems
        guard let url = components.url else {
            return nil
        }
        return .init(url: url)
    }

    var encode: Data? {
        let encoder = JSONEncoder()
        guard let body = body else {
            return nil
        }
        encoder.dateEncodingStrategy = .custom { date, encoder in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let stringData = formatter.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(stringData)
        }
        return try? encoder.encode(body)
    }
}

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}
