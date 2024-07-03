import Foundation

struct User: Codable, Hashable {
    let id: Int
    var firstName: String
    var lastName: String
    var password: String
    var email: String
    var company: String
    var friends: [String]
    var eventIDs: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case password = "Password"
        case email = "Email"
        case company = "Company"
        case friends = "Friends"
        case eventIDs = "EventIDs"
    }
}
