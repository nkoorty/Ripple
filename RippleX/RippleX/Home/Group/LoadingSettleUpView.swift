import SwiftUI
import Lottie

struct LoadingSettleUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isCompleted: Bool
    
    @State private var isLoading = true
    @State private var isAnimating = false
    
    private var name: String
    private var amount: Double
    
    init(name: String, amount: Double, isCompleted: Binding<Bool>) {
        self.name = name
        self.amount = amount
        self._isCompleted = isCompleted
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.ignoresSafeArea()
            VStack {
                if isLoading {
                    LottieView(animation: .named("loadinglottie"))
                        .playing(loopMode: .playOnce)
                        .animationDidFinish { completed in
                            isLoading = false
                            isAnimating = true
                        }
                        .frame(width: 210, height: 210, alignment: .center)
                        .offset(y: 30)
                }
                ZStack {
                    if isAnimating {
                        
                        LottieView(animation: .named("lottie3"))
                            .playing(loopMode: .playOnce)
                            .animationDidFinish { completed in
                                presentationMode.wrappedValue.dismiss()
                                isCompleted = true
                            }
                    }
                    
                    VStack {
                        Text("All settled up!")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                        
                        if name == "Everyone" {
                            Text("You paid Christian £12.52")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                            Text("You paid Adesh £20.63")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                            Text("You paid Jeevan £14.30")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                            
                        } else {
                            Text("You paid \(name) £\(String(format: "%.2f", abs(amount)))")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.5))
                        }
        
                    }
                    .fixedSize()
                    .offset(y: isAnimating ? 110 : 400)
                    .animation(Animation.spring(duration: 0.6, bounce: 0.4), value: isAnimating)
                }

                if !isLoading && !isAnimating {
                    Button("Animate") {
                        isAnimating.toggle()
                    }
                }
            }
            .offset(y: -50)
        }
    }
}


//#Preview {
//    LoadingSettleUpView(name: "Adesh", amount: 34.20, isCompleted: false)
//}
