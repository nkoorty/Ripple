import SwiftUI

struct Group: Identifiable, Hashable {
    var name: String
    var imageUrl: String
    var imageUrl2: String
    var imageUrl3: String
    var id = UUID()
    var memberCount: Double
    var owedAmount: Double
    var open: Bool
}

