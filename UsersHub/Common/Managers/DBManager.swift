import Foundation
import RealmSwift

class DBManager {
    static let sharedInstance = DBManager()
    private var realm = try! Realm()
}

//MARK: - remove github account
extension DBManager {
    func removeGitHub(id: String) {
        let personToUpdate = realm.objects(ContactInfo.self).filter("id == %@", id).first
        try! realm.write {
            personToUpdate?.gitHubLogin = ""
        }
    }
}

//MARK: - add github account
extension DBManager {
    func addGitHub(id: String, gitLogin: String) {
        let personToUpdate = realm.objects(ContactInfo.self).filter("id == %@", id).first
        
        try! realm.write {
            personToUpdate?.gitHubLogin = gitLogin
        }
    }
}

//MARK: - delete contact from database
extension DBManager {
    func deleteContact(contact: ContactInfo) {
        try! realm.write {
            realm.delete(contact)
        }
    }
}

//MARK: - load contacts from database
extension DBManager {
    func loadContacts() -> Results<ContactInfo> {
        return realm.objects(ContactInfo.self)
    }
}

//MARK: - save contact in database
extension DBManager {
    func saveContact(contact: ContactInfo) {
        try! realm.write {
            realm.add(contact)
        }
    }
}

//MARK: - check if value exists in database
extension DBManager {
    func valueExistsInDb(propertyForChecking: String, valueToCheck: String) -> Bool {
        let existingObject = realm.objects(ContactInfo.self).filter("\(propertyForChecking) == %@", valueToCheck).first
        
        return existingObject != nil
    }
}
