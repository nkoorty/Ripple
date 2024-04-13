import Foundation

final class APICoordinator {
    
    /// Use this to make network requests
    ///
    /// Making a GET request
    /// ```
    /// let test: TestModel = try await apiCoordinator.request(endpoint: Endpoints.test)
    /// ```
    /// Making a POST request
    /// ```
    /// let post: TestModel = try await apiCoordinator.request(endpoint: Endpoints.post, method: .POST(data: test))
    /// ```
    ///
    /// Example Model for GET request
    ///```
    /// struct TestModel: Codable {
    /// var message: String
    /// }
    /// ```
    ///
    /// Example Model for POST request
    /// ```
    /// struct PostModel: Codable {
    /// var message: String
    /// var data: TestModel
    /// }
    /// ```
    ///
    ///
    
    func request<T: Codable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod = .GET,
        path: APIMethod = .base
    ) async throws -> T {

        guard
            let urlPath = URL(string: endpoint.path, relativeTo: path.url),
            let url = URL(string: urlPath.absoluteString) else {
            throw APIError.invalidURL
        }
        
        let request = try await createRequest(with: url, type: method, path: path)
        return try await getURL(baseRequest: request)
    }
    
    private func getURL<T: Codable>(baseRequest: URLRequest) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(for: baseRequest)
//            let jsonString = String(data: data, encoding: .utf8)
//            print("JSON String: \(jsonString ?? "Invalid UTF-8 data")")
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.unknown(error: String(describing: error))
        }
    }
    
    //MARK: Private
    
    private func createRequest(
        with url: URL,
        type: HTTPMethod,
        path: APIMethod
    ) async throws -> URLRequest {
        
        switch type {
        case .GET:
            return try await buildRequest(url: url, type: type)
        case .POST(let data):
            return try await buildPostRequest(url: url, data: data)
        case .PUT:
            return try await buildRequest(url: url, type: type)
        case .DELETE:
            return try await buildRequest(url: url, type: type)
        }
    }
    
    private func buildRequest(
        url: URL,
        type: HTTPMethod
    ) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type.method
        request.timeoutInterval = 30
        return request
    }
    
    private func buildPostRequest(
        url: URL,
        data: Codable
    ) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let data = try encoder.encode(data)
        request.httpBody = data
        return request
    }
}
