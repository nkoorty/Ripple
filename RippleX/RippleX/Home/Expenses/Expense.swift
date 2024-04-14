import SwiftUI

struct Expense: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var title: String
    var amount: Double
}

var expenses: [Expense] = [
    Expense(name: "Artemiy", title: "Uber ride to hotel", amount: 24),
    Expense(name: "Jeevan", title: "Dinner at the Mandarin", amount: 153),
    Expense(name: "Adesh", title: "Lunch in Boston", amount: 34),
    Expense(name: "Christian", title: "Uber to Harvard", amount: 12),
    Expense(name: "Christian", title: "Uber to MIT", amount: 14),
]
