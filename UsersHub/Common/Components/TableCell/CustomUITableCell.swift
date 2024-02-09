//
//  CustomUITableCell.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 28.11.2023.
//

import Foundation
import UIKit

class CustomUITableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = UIColor(named: Constants.Colors.forBackground)
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = UIColor(named: Constants.Colors.forSelect)
        } else {
            backgroundColor = UIColor(named: Constants.Colors.forBackground)
        }
    }
}
