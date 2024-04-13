import Foundation

protocol EndpointProtocol {
    var path: String { get }
}

enum Endpoints: EndpointProtocol {
    case test
    case post
    
    var path: String {
        switch self {
        case .test:
            return "/test"
        case .post:
            return "/post"
        }
    }
}
