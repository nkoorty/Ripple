import SwiftUI

struct ActivityView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(activities, id: \.id) { activity in
                        NavigationLink {
                            
                        } label: {
                            ActivityPreview(activity: activity)
                        }
                    }
                } header: {
                    Text("Recent Acitivity")
                } footer: {
                    Text("This data is obtained from the smart contract histories of the Group and Account smart contracts")
                }
            }
            .navigationTitle("Friends")
        }
    }
}

#Preview {
    ActivityView()
        .preferredColorScheme(.dark)
}
