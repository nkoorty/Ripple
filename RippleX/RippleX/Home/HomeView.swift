import SwiftUI

struct HomeView: View {
    
    @ObservedObject var settings = Settings()
    @StateObject private var viewModel = GroupViewModel()
    @State private var addGroupView = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(gradient: Gradient(colors: [Color(red: 50/256, green: 34/256, blue: 248/256), Color(red: 120/256, green: 40/256, blue: 250/256)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        
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
                            
                            (Text("in ") + Text("2 Groups").bold() + Text(" for ") + Text("9 Payments").bold() + Text(" in total"))
                                .font(.system(size: 16))
                        
                        }
                        .padding(20)
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .cornerRadius(20)
                
                Section {
                    if settings.connectedMetaMask {
                        ForEach(viewModel.groups1, id:\.id) { group in
                            NavigationLink(destination: GroupOverview(group: group)) {
                                GroupView(group: group)
                            }
                        }
                    } else {
                        ForEach(viewModel.groups, id:\.id) { group in
                            NavigationLink(destination: GroupOverview(group: group)) {
                                GroupView(group: group)
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Groups")
                        
                        Spacer()
                        
                        Text("See all")
                            .font(.system(size: 16))
                            .foregroundStyle(.blue)
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        addGroupView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $addGroupView) {
                GroupAddingView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
