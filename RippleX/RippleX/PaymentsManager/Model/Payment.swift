import Foundation

struct Payment: Codable {
    let owner: String
    let payees: [OwedPaymentUser]
}

struct OwedPaymentUser: Codable {
    let name: String
    let address: String
    let amountOwed: Double
}
