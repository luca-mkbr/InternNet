import Foundation
import MapKit


struct Event: Identifiable, Codable {
    let id : Int
    var name: String
    var date: Date
    var location: String
    var category: FilterState
    var latitude: Double
    var longitude: Double
    var people: Int?
    var userIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case category = "type"
        case userIds = "userids"
        case location = "location"
        case date = "time"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case people, id
    }
}

typealias Events = [Event]
