//
//  UIColor+.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import UIKit

extension UIColor {

    static let accent: UIColor = namedColor(name: "Accent")
    static let dark: UIColor = namedColor(name: "Dark")
    static let light: UIColor = namedColor(name: "Light")
    static let primaryBrand: UIColor = namedColor(name: "Primary Brand")
    static let secondaryBrand: UIColor = namedColor(name: "Secondary Brand")
    static let subDark: UIColor = namedColor(name: "SubDark")
    static let subtleText: UIColor = namedColor(name: "Subtle Text")
    static let tertiaryBrand: UIColor = namedColor(name: "Tertiary Brand")
    static let text: UIColor = namedColor(name: "Text")

    static func namedColor(name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            preconditionFailure("invalid uiColor named: \(name)")
        }
        return color
    }
    
}
