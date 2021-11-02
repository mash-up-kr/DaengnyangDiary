//
//  StringExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/02.
//

import UIKit

extension String {
    // 취소선 긋기
    func strikeThrough(_ isStrikeThrough:Bool) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        if isStrikeThrough {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        }
        return attributeString
    }
}
