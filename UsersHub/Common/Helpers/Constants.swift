import Foundation
//
//
//plus
//

struct Constants {}

extension Constants {
    struct Fonts {
        static let mainFont = "SFProDisplay-Bold"
        static let secondaryFont = "SFProDisplay-Regular"
    }
}

extension Constants {
    struct UserForm {
        static let phoneMask = "(XXX) XXX-XX-XX"
        static let nameRegex = "[A-Za-zА-Яа-яі ]{2,20}"
        static let emailRegex = "[ A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[ A-Za-z]{2,4}"
        static let maxChName   = 20
        static let maxChEmail  = 40
        static let minAge = Calendar.current.date(byAdding: .year, value: -16, to: Date()) ?? .now
        static let maxAge = Calendar.current.date(byAdding: .year, value: -75, to: Date()) ?? .now
    }
}

extension Constants {
    struct Colors {
        static let forMainElements = "forMainElements"
        static let forBackground = "forBackground"
        static let forSeparator = "forSeparator"
        static let forSelect = "forSelect"
        static let forSecondary = "forSecondary"
        static let forModalBackground = "forModalBackground"
        static let forButtonBackground = "ForButtonBackground"
    }
}

extension Constants {
    struct APIManager {
        static let url = "https://api.github.com/users"
        static let urlForDetailInfo = "https://api.github.com/users/"
    }
}
