import SwiftUI

struct Group: Identifiable, Hashable {
    var name: String
    var imageUrl: String
    var id = UUID()
    var memberCount: Double
    var owedAmount: Double
    var open: Bool
}

