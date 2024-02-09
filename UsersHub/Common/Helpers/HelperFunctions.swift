import Foundation
import UIKit

struct HelperFunctions {
    
    //MARK: - generate QrCode
    static func didGenerateQrCode(url: String) -> UIImage? {
        let data = url.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    //MARK: - calculate age from user's dateBirth
    static func didCalcAge(from birthDate: Date) -> Int {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        
        if let years = components.year {
            return years
        } else {
            return 0
        }
    }
    
    //MARK: - alertController
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
}

