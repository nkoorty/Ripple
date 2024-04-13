import Foundation

struct PaymentGroup: Codable {
    let users: [PaymentUser]
}

struct PaymentUser: Codable {
    var name: String
    var address: String
}
