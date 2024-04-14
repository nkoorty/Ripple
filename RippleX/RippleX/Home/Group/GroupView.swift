import SwiftUI

struct GroupView: View {
    var group: Group
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Image(group.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .cornerRadius(50)
                    .offset(x: -8, y: -6)
                
                Image(group.imageUrl2)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 23, height: 23)
                    .cornerRadius(50)
                    .offset(x: 6, y: -2)
                
                Image(group.imageUrl3)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
                    .cornerRadius(50)
                    .offset(x: 0, y: 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(group.name)
                    .bold()
                
                Text("Members: \(String(format: "%.0f", group.memberCount))")
                    .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(group.open ? "Settled" : "Not Settled")
                    .foregroundColor(group.open ? .gray : .white)
                    .font(.system(size: 14))
                
                Text("£\(String(format: "%.2f", group.owedAmount))")
                    .bold()
            }
        }
    }
}

//#Preview {
//    GroupView(group: groups[1])
//        .preferredColorScheme(.dark)
//}
