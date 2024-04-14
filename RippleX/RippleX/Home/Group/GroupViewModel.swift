import SwiftUI
import Combine

class GroupViewModel: ObservableObject {
    
    @Published var groups: [Group] = []
    @Published var groups1: [Group] = []
    
    init() {
        groups = [
            Group(name: "Boston Trip", imageUrl: "icon4", imageUrl2: "icon3", imageUrl3: "icon2", memberCount: 4.0, owedAmount: 47.50, open: false)
        ]
        
        groups1 = [
            Group(name: "Boston Trip", imageUrl: "icon", imageUrl2: "icon2", imageUrl3: "icon3", memberCount: 4.0, owedAmount: 47.50, open: false),
            Group(name: "Paris Weekend", imageUrl: "icon3", imageUrl2: "icon4", imageUrl3: "icon", memberCount: 3.0, owedAmount: 130.0, open: false),
            Group(name: "London Getaway", imageUrl: "icon4", imageUrl2: "icon3", imageUrl3: "icon2", memberCount: 3.0, owedAmount: 180.0, open: true)
        ]
    }
    
    func addGroup(name: String, imageUrl: String, imageUrl2: String, imageUrl3: String, memberCount: Double, owedAmount: Double, open: Bool) {
        let newGroup = Group(name: name, imageUrl: imageUrl, imageUrl2: imageUrl2, imageUrl3: imageUrl3, memberCount: memberCount, owedAmount: owedAmount, open: open)
        // Make sure to dispatch to the main thread as you're updating the UI
        DispatchQueue.main.async {
            self.groups1.append(newGroup)
        }
    }
}
