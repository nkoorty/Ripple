import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ActivityView()
                .tabItem {
                    Label("Activity", systemImage: "clock.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
        .preferredColorScheme(.dark)
}
