//
//  CustomUIView.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 27.11.2023.
//

import Foundation
import UIKit

class CustomUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setupView(backColor: UIColor? = nil, hidden: Bool = false) {
       backgroundColor = backColor
       isHidden = hidden
    }
}
