//
//  CustomStackView.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 21.11.2023.
//

//import Foundation
//import UIKit
//
//class CustomStackView: UIStackView {
//
//}

import UIKit

class CustomUIStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView(viewAxis: NSLayoutConstraint.Axis = .vertical, viewSpacing: CGFloat = 30, viewDistribution: UIStackView.Distribution = .fill, viewContentMode: UIView.ContentMode = .scaleAspectFill) {
        axis = viewAxis
        spacing = viewSpacing
        distribution = viewDistribution
        contentMode = viewContentMode
    }
}
