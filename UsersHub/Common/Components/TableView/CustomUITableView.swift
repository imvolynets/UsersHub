//
//  CustomUITableView.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 28.11.2023.
//

import Foundation
import UIKit

class CustomUITableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        setupTabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabel() {
        separatorColor = UIColor(named: Constants.Colors.forSeparator)
        backgroundColor = UIColor(named: Constants.Colors.forBackground)
    }
}
