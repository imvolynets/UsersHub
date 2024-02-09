import Foundation

struct Validation {
    
    //MARK: - validate for firstname and lastname
    static func isValidName(_ name: String?) -> Bool {
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", Constants.UserForm.nameRegex)
        
        return namePredicate.evaluate(with: name)
    }
    
    //MARK: - validate for email
    static func isValidEmail(_ email: String?) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Constants.UserForm.emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    //MARK: - validate for phone number
    static func isValidPhoneNumber(_ phone: String?) -> Bool {
        return phone?.count == Constants.UserForm.phoneMask.count
    }
    
    //MARK: - validate for user age
    static func isValidAge(birthDate: Date?) -> Bool {
        guard let birthDate = birthDate else {return false}
        var isValid: Bool = true
        
        if birthDate < Constants.UserForm.maxAge || birthDate > Constants.UserForm.minAge {
            isValid = false
        }
        
        return isValid
    }
}



