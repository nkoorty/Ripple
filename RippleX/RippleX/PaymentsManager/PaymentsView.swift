import SwiftUI

struct PaymentsView: View {
    
    var paymentsManager = PaymentsManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            
        }
    }
    
    private func createGroup() async {
        await paymentsManager.createGroup(users:
        [
            .init(name: "Adesh", address: "123"),
            .init(name: "Christian", address: "6969"),
            .init(name: "JJ", address: "457"),
        ])
    }
    
    private func createPaymentSplit() async {
        await paymentsManager.createPaymentSplit(owner: "christian", payees: [
            .init(name: "Adesh", address: "123", amountOwed: 69)
        ])
    }
    
}

#Preview {
    PaymentsView()
}
