import Foundation

enum HTTPMethod {
    case GET
    case POST(data: Codable)
    case PUT
    case DELETE
    
    var method: String {
        switch self {
        case .GET:
            "GET"
        case .POST(_):
            "POST"
        case .PUT:
            "PUT"
        case .DELETE:
            "DELETE"
        }
    }
}
