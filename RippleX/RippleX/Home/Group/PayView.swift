import SwiftUI

struct PayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Pay \(String(format: "%.2f", amount)) XRP (£\(String(format: "%.2f", amount/2.59)))", systemImage: "dollarsign")
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
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    PayView(amount: 16)
        .preferredColorScheme(.dark)
}
