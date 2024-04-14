import Foundation
import SwiftUI

public class Settings: ObservableObject {
    @AppStorage("createdWallet", store: UserDefaults.standard) public var createdWallet: Bool = false
    @AppStorage("metamaskConnected", store: UserDefaults.standard) public var connectedMetaMask: Bool = false
    @AppStorage("paid", store: UserDefaults.standard) public var paidExpense: Bool = false
}
