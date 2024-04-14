import SwiftUI
import LocalAuthentication

struct PayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var settings = Settings()

    @State private var presentLoading: Bool = false
    @State private var isPaymentCompleted: Bool = false
    
    var name: String
    var amount: Double
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 20)
                
                Text("You are sending funds in XRP towards the created vault. You are agreeing to our Terms of Service and Privacy Policy. Ensure you have understood these documents before proceeding.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                    .frame(height: 20)
                Button {
                    authenticate()
                } label: {
                    Label("Pay \(name) \(String(format: "%.2f", amount)) XRP (£\(String(format: "%.2f", amount/2.59)))", systemImage: "dollarsign")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .padding(.top, 20)
                
                Spacer()

                .navigationTitle("Pay")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .bold()
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(50)
                        }
                    }
                }
            }
            .onChange(of: isPaymentCompleted) { completed in
                if completed {
                    presentationMode.wrappedValue.dismiss()
                    settings.paidExpense.toggle()
                }
            }
            .padding(.horizontal, 16)
        }
        
        .fullScreenCover(isPresented: $presentLoading) {
            LoadingSettleUpView(name: name, amount: amount, isCompleted: $isPaymentCompleted)
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        presentLoading.toggle()
                    }
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    PayView(name: "Jeevan", amount: 16)
        .preferredColorScheme(.dark)
}
