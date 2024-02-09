//
//  CustomUILabel.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 23.11.2023.
//

import Foundation
import UIKit

class CustomUILabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(fontName: String = Constants.Fonts.mainFont, fontSize: CGFloat = 16, fontColor: UIColor? = UIColor(named: Constants.Colors.forMainElements), hidden: Bool = false, alignment: NSTextAlignment = .natural, labelText: String? = nil) {
        font = UIFont(name: fontName, size: fontSize)
        textColor = fontColor
        textAlignment = alignment
        isHidden = hidden
        text = labelText
    }
}

