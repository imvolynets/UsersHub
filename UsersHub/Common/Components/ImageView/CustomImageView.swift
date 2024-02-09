//
//  CustomImageView.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 27.11.2023.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(cornerRadius: CGFloat = 0, clipsToBounds: Bool = true, contentMode: UIView.ContentMode = .scaleAspectFit, isHidden: Bool = false) {
        layer.cornerRadius = cornerRadius
        isUserInteractionEnabled = true
        self.clipsToBounds = clipsToBounds
        self.isHidden = isHidden
        self.contentMode = contentMode    
    }
}
