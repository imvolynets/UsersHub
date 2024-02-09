import Foundation
import RealmSwift 

class ContactInfo: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var gender = ""
    @objc dynamic var birthDate = ""
    @objc dynamic var age = 0
    @objc dynamic var gitHubLogin = ""
}
