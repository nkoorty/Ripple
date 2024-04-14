import SwiftUI
import Charts
import metamask_ios_sdk
import Combine

struct ProfileView: View {
    
    @ObservedObject var settings = Settings()
        
    @ObservedObject var metaMaskSDK = MetaMaskSDK.shared(appMetadata)
    private static let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")

    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                    } label: {
                        HStack {
                            Image("unlimit")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .cornerRadius(6)
                                .padding(.trailing, 8)
                            
                            Text("Unlimit")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text("Add funds")
                                .foregroundStyle(.gray)
                        }
                    }
                    Button {
                        Task {
                            await connectSDK()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image("metamask")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .cornerRadius(6)
                            
                            Text("MetaMask")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text(settings.connectedMetaMask ? "Not Connected" : "Connected")
                                .foregroundStyle(.gray)
                        }
                    }
                    HStack(spacing: 16) {
                        Image("ripsplit")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .cornerRadius(6)
                        
                        Text("AA Wallet")
                        
                        Spacer()
                        
                        Text(settings.createdWallet ? "Connected" : "Not Connected")
                            .foregroundStyle(.gray)
                    }
                } header: {
                    Text("Connections")
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                
                Section {
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Wallet", systemImage: "wallet.pass")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Settings", systemImage: "gearshape")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Add Friends", systemImage: "person.badge.plus")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Details", systemImage: "info.circle")
                        }
                    }
                } header: {
                    Text("Settings")
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                
                Section {
                    Button {
                        UserDefaults.standard.set(false, forKey: "signin")
                        settings.connectedMetaMask = false
                    } label: {
                        Label("Log out", systemImage: "arrow.uturn.left")
                            .foregroundStyle(.red)
                    }
                } header: {
                    Text("Disconnect")
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Profile")
            .overlay(
                ProfileImageView()
                    .padding(.trailing, 20)
                    .offset(x: 0, y: -50)
            , alignment: .topTrailing)
        }
    }
    
    func connectSDK() async {
        let result = await metaMaskSDK.connect()
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
    ProfileView()
        .preferredColorScheme(.dark)
}

struct ProfileImageView: View {
    var body: some View {
        Image("nkoorty")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

