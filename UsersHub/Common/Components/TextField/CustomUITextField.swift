//
//  CustomUITextField.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 23.11.2023.
//

import Foundation
import UIKit

class CustomUITextField: UITextField {
    struct CustomUITextFieldConstants {
        static let cornerRadius: CGFloat = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        attributedPlaceholder = NSAttributedString(
            string: "Example",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.Colors.forSeparator) ?? .systemGray])
        borderStyle = .roundedRect
        backgroundColor = UIColor(named: Constants.Colors.forMainElements)
        textColor = UIColor(named: Constants.Colors.forBackground)
        layer.cornerRadius = CustomUITextFieldConstants.cornerRadius
//        clipsToBounds = false
//        layer.shadowOpacity = 0.4
//        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
