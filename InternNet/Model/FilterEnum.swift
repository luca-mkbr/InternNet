import Foundation
import SwiftUI

enum FilterState: String, CaseIterable, Identifiable, Codable {
    case active
    case entertainment
    case eatDrink
    case anything
    var id: Self { return self }
    
    var selectedCategory: String {
        switch self {
        case .active:
            return "Active"
        case .entertainment:
            return "Entertainment"
        case .eatDrink:
            return "Eat / Drink"
        case .anything:
            return "Anything"
        }
    }
    
    var color: Color {
        switch self {
        case .active:
            return .red
        case .entertainment:
            return .blue
        case .eatDrink:
            return .orange
        case .anything:
            return .green
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .active:
            return "figure.run.circle.fill"
        case .entertainment:
            return "theatermasks.circle.fill"
        case .eatDrink:
            return "fork.knife.circle.fill"
        case .anything:
            return "shuffle.circle.fill"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status?.lowercased() {
            case "active": self = .active
            case "eat/drink": self = .eatDrink
            case "entertainment": self = .entertainment
            case "anything": self = .anything
            default: self = .anything
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .active: try container.encode("active")
            case .eatDrink: try container.encode("eat/drink")
            case .entertainment: try container.encode("entertainment")
            case .anything: try container.encode("anything")
        }
    }
}
