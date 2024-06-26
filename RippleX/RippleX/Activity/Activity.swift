import SwiftUI

struct Activity: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var group: String
    var date: String
    var imageUrl: String
}

var activities: [Activity] = [
    Activity(title: "Jeevan created the Boston Trip group", group: "Boston Trip", date: "14.4.2024", imageUrl: "icon2"),
    Activity(title: "Christian paid £12 towards London Getaway", group: "London Getaway", date: "12.4.2024", imageUrl: "icon3"),
    Activity(title: "Adesh left London Getaway", group: "London Getaway", date: "11.4.2024", imageUrl: "icon4"),
]
