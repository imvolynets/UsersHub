//
//  CustomUIButton.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 29.11.2023.
//

import Foundation
import UIKit

class CustomUIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(backColor: UIColor = UIColor(named: Constants.Colors.forSeparator) ?? .systemGray, title: String? = nil, radius: CGFloat = 10 ) {
        backgroundColor = backColor
        layer.cornerRadius = radius
        setTitle(title, for: .normal)
    }
}
