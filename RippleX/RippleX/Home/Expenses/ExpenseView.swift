import SwiftUI

struct ExpenseView: View {
    var expense: Expense
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "dollarsign")
                
            
            VStack(alignment: .leading) {
                Text(expense.title)
                
                Text(expense.name)
                    .font(.caption)
                    .bold()
            }
            
            Spacer()
            
            VStack {
                Text("$\(String(format: "%.2f", expense.amount))")
                    .bold()
                
                Text("\(String(format: "%.2f", expense.amount*2.59)) XRP")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    ExpenseView(expense: expenses[0])
        .preferredColorScheme(.dark)
}
