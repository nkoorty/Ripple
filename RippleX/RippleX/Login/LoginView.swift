import SwiftUI
import LocalAuthentication
import metamask_ios_sdk
import Combine

struct LoginView: View {
    
    @ObservedObject var settings = Settings()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showWalletView: Bool = false
    
    @ObservedObject var metaMaskSDK = MetaMaskSDK.shared(appMetadata)
    private static let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")

    @State private var errorMessage = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Payment Splitting Made Easy")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Image("ripsplit")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                
                Button {
                    Task {
                        await connectSDK()
                    }
                } label: {
                    HStack(spacing: 12) {
                        Text("Log in with MetaMask")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .overlay(
                        HStack {
                            Image("metamask")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 28, height: 28)
                            
                            Spacer()
                        }
                            .padding()
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.1))
                            .frame(height: 56)
                    )
                    .padding(.top, 20)
                }
                .padding(.top, 12)
                .padding(.bottom, 16)
                
                Button {
                    showWalletView.toggle()
                } label: {
                    HStack(spacing: 12) {
                        Text("Create RipSplit Wallet")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .overlay(
                        HStack {
                            Image(systemName: "wallet.pass")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .padding(.leading, 6)
                            
                            Spacer()
                        }
                        .padding()
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.1))
                            .frame(height: 56)
                    )
                    .padding(.top, 20)
                }
                
                Spacer()
                
                Text("By continuing, you agree to our User Agreement and Privacy Policy.")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.60))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showWalletView) {
                AbstractionView {
                    self.showWalletView = false
                    authenticate()
                }
                .presentationDetents([.fraction(0.4)])
            }
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
                        UserDefaults.standard.set(true, forKey: "signin")
                        settings.createdWallet = true
                    }
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    func connectSDK() async {
        let result = await metaMaskSDK.connect()
        UserDefaults.standard.set(true, forKey: "signin")
        settings.connectedMetaMask = true
        
        switch result {
        case let .failure(error):
            errorMessage = error.localizedDescription
            showError = true
        default:
            break
        }
    }
}

#Preview {
    LoginView()
        .preferredColorScheme(.dark)
}
