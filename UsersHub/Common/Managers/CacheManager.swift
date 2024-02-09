import Foundation

class CacheManager {
    static let sharedInstance = CacheManager()
    private let defaults = UserDefaults.standard
}

//MARK: - set data to lc
extension CacheManager {
    func setDataFrom<T>(item: T, userForm userFormKey: ContactKeys? = nil, gitHubForm gitHubFormKey: GitKey? = nil) {
        if let key = userFormKey {
            defaults.set(item, forKey: key.rawValue)
        }
        
        if let key = gitHubFormKey {
            defaults.set(item, forKey: key.rawValue)
        }
    }
}



//MARK: - load data from lc
extension CacheManager {
    func loadDataTo(userForm userFormKey: ContactKeys? = nil, gitHubForm gitHubFormKey: GitKey? = nil) -> Any? {
        if let key = userFormKey {
            switch key {
            case .firstname:
                fallthrough
            case .lastname:
                fallthrough
            case .email:
                fallthrough
            case .phone:
                return defaults.string(forKey: key.rawValue)
            case .segmentIndex:
                return defaults.integer(forKey: key.rawValue)
            case .birthDate:
                return defaults.date(forKey: key.rawValue)
            }
        }
        
        if let key = gitHubFormKey {
            switch key {
            case .gitHubLogin:
                return defaults.string(forKey: key.rawValue)
            }
        }
        return false
    }
}

//MARK: - reset data from lc
extension CacheManager {
    func resetDataFrom(UserForm: Bool = false, GitHubForm: Bool = false) {
        if UserForm {
            ContactKeys.allCases.forEach { defaults.removeObject(forKey: $0.rawValue) }
        }
        
        if GitHubForm{
            GitKey.allCases.forEach { defaults.removeObject(forKey: $0.rawValue) }
        }
    }
}

//MARK: - adding functionality to UserDefault for saving dates
extension UserDefaults {
    func set(date: Date?, forKey key: String){
        self.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }
}

