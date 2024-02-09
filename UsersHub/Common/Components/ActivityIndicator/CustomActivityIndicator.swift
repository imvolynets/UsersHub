//
//  CustomActivityIndicator.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 27.11.2023.
//

import Foundation
import UIKit

class CustomActivityIndicator: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupIndicator()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIndicator(indicatorStyle: UIActivityIndicatorView.Style = .large, indicatorColor: UIColor? = UIColor(named: Constants.Colors.forMainElements)) {
        style = indicatorStyle
        color = indicatorColor
    }
}
