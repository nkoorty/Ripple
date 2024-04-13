import Foundation

public enum APIError: Error {
    case invalidURL
    case failedToGetData
    case unknown(error: String)
}
