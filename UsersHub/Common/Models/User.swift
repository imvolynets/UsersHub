import Foundation

struct User : Codable {
    var id: Int
    var login: String
    var avatarUrl: URL
    var url: String
}
