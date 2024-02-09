//
//  String+localized.swift
//  UsersHub
//
//  Created by Volynets Vladislav on 04.12.2023.
//

import Foundation

extension String {
    var localized: String {
        return String(localized: LocalizationValue(self))
    }
}
