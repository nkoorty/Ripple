import Foundation

protocol EndpointProtocol {
    var path: String { get }
}

enum Endpoints: EndpointProtocol {
    case createGroup
    case createPaymentSplit
    
    var path: String {
        switch self {
        case .createGroup:
            return "/createGroup"
        case .createPaymentSplit:
            return "/createPaymentSplit"
        }
    }
}
