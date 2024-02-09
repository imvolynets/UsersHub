//
//  CustomScrollView.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 27.11.2023.
//

import Foundation
import UIKit

class CustomScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = true
    }
}
