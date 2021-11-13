//
//  UIViewExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/03.
//

import UIKit

extension UIView {
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadius(radius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
