import SwiftUI

struct ActivityPreview: View {
    var activity: Activity
    
    var body: some View {
        HStack(spacing: 10) {            
            VStack(alignment: .leading) {
                Text(activity.title)
                
                (Text(activity.group) + Text(" • ") + Text(activity.date))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        
        }
    }
}

#Preview {
    ActivityPreview(activity: activities[0])
}
