import Foundation

struct UserDetail: Codable {
    var login: String
    var name: String?
    var htmlUrl: String
    var avatarUrl: URL
    var company: String?
    var blog: String?
    var location: String?
}
