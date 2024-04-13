import Foundation

public enum APIMethod: String {
    case base = "https://7m2v2w04-5000.uks1.devtunnels.ms"
    
    var url: URL? {
        return URL(string: self.rawValue)
    }
}
