import SwiftUI

struct Member: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var profileImage: String
}

var members: [Member] = [
    Member(name: "Artemiy", profileImage: "icon"),
    Member(name: "Jeevan", profileImage: "icon2")
]
