import SwiftUI

struct ActivityView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Recent Acitivity")) {
                    ForEach(activities, id: \.id) { activity in
                            ActivityPreview(activity: activity)
                    }
                }
            }
            .navigationTitle("Activity")
        }
    }
}

#Preview {
    ActivityView()
        .preferredColorScheme(.dark)
}
