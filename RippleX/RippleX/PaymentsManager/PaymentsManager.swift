import Foundation

protocol PaymentsManagerProtocol {
    func createGroup(users: [PaymentUser]) async
    func createPaymentSplit(owner: String, payees: [OwedPaymentUser]) async
}

final class PaymentsManager: PaymentsManagerProtocol {
    
    private var apiCoordinator: APICoordinator
    
    init(apiCoordinator: APICoordinator = APICoordinator()) {
        self.apiCoordinator = apiCoordinator
    }
    
    func createGroup(users: [PaymentUser]) async {
        let group =  PaymentGroup(users: users)
        
        do {
            let response: PaymentResponse = try await apiCoordinator.request(endpoint: Endpoints.createGroup, method: .POST(data: group))
            print(response)
        } catch {
            print(error)
        }
    }
    
    func createPaymentSplit(owner: String, payees: [OwedPaymentUser]) async {
        let payment = Payment(owner: owner, payees: payees)
        
        do {
            let response: PaymentResponse = try await apiCoordinator.request(endpoint: Endpoints.createPaymentSplit, method: .POST(data: payment))
            print(response)
        } catch {
            print(error)
        }
    }
    
    func settlePaymentSplit() {
        
    }
}
