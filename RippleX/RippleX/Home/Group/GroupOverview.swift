import SwiftUI
import LocalAuthentication

struct GroupOverview: View {
    
    var group: Group
    
    @State private var presentPay = false
    @State private var paymentAmount: Double = 0
    @State private var payeeName: String = ""
    @State private var shakePresent: Bool = false
    @State private var isShakePaymentCompleted: Bool = false
    
    private var presentPayBinding: Binding<Bool> {
        Binding(
            get: { self.presentPay },
            set: {
                if $0 == true && self.presentPay == false {
                }
                self.presentPay = $0
            }
        )
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(gradient: Gradient(colors: [Color(red: 120/256, green: 40/256, blue: 250/256), Color(red: 50/256, green: 34/256, blue: 248/256)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hi Artemiy, you owe")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.7))
                            
                            HStack {
                                Text("£47.50")
                                    .font(.system(size: 32, weight: .bold))
                                
                                Spacer()
                                
                                Text("~122.89 XRP")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        
                        }
                        .padding(20)
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .cornerRadius(20)
                
                Section {
                    ForEach(members, id: \.id) { member in
                        MemberView(member: member)
                    }
                    HStack {
                        Image(systemName: "plus")
                        
                        Text("Add members")
                    }
                } header: {
                    Text("Members")
                }
                .headerProminence(.increased)
                
                Section {
                    ForEach(expenses, id: \.id) { expense in
                        ExpenseView(expense: expense)
                    }
                    HStack {
                        Image(systemName: "plus")
                        
                        Text("Add expense")
                    }
                } header: {
                    Text("Expenses")
                }
                .headerProminence(.increased)
                
                Section {
                    HStack {
                        Text("Pay ") + Text("Everyone").bold()
                    }

                    HStack {
                        Text("Pay 122.89 XRP")
                        
                        Spacer()
                        
                        Button {
                            payeeName = "Everyone"
                            paymentAmount = 122.89
                            presentPayBinding.wrappedValue = true
                        } label: {
                            Text("Pay")
                                .foregroundStyle(.blue)
                        }
                    }
                } header: {
                    Text("Pay Everyone")
                } footer: {
                    Text("You can choose to pay everyone using a single wallet signature.")
                }
                .headerProminence(.increased)
                
                Section {
                    
                    HStack {
                        Text("Pay ")
                        
                        Image("icon3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .cornerRadius(50)
                        
                        Text("Christian")
                            .bold()
                    }

                    HStack {
                        Text("Pay 32.43 XRP")
                        
                        Spacer()
                        
                        Button {
                            payeeName = "Christian"
                            paymentAmount = 32.43
                            presentPayBinding.wrappedValue = true
                        } label: {
                            Text("Pay")
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    HStack {
                        Text("Pay ")
                        
                        Image("icon4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .cornerRadius(50)
                        
                        Text("Adesh")
                            .bold()
                    }

                    HStack {
                        Text("Pay 53.43 XRP")
                        
                        Spacer()
                        
                        Button {
                            payeeName = "Adesh"
                            paymentAmount = 53.43
                            presentPayBinding.wrappedValue = true
                        } label: {
                            Text("Pay")
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    HStack {
                        Text("Pay ")
                        
                        Image("icon2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .cornerRadius(50)
                        
                        Text("Jeevan")
                            .bold()
                    }

                    HStack {
                        Text("Pay 37.03 XRP")
                        
                        Spacer()
                        
                        Button {
                            payeeName = "Jeevan"
                            paymentAmount = 37.03
                            presentPayBinding.wrappedValue = true
                        } label: {
                            Text("Pay")
                                .foregroundStyle(.blue)
                        }
                    }
                } header: {
                    Text("Pay Individually")
                } footer: {
                    Text("You can choose to pay individual group members.")
                }
                .headerProminence(.increased)
                
            }
            .navigationTitle(group.name)
            .sheet(isPresented: presentPayBinding) {
                PayView(name: payeeName, amount: paymentAmount)
                    .presentationDetents([.fraction(0.5)])
            }
        }
        .onShake {
            authenticate()
        }
        .fullScreenCover(isPresented: $shakePresent) {
            LoadingSettleUpView(name: "Everyone", amount: 34, isCompleted: $isShakePaymentCompleted)
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
                        shakePresent.toggle()
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


