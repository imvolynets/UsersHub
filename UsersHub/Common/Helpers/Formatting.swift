import Foundation

struct Formatting {
    
    //MARK: - converting date to a string
    static func formatterDateString(format: String? = "dd.MM.YYYY", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    //MARK: - checking mask for phone number
    static func formatterPhoneNumber(mask: String, phoneNumber: String) -> String{
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        return result
    }
}

