//
//  OrderMenuButton.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/13.
//

import UIKit

class OrderMenuButton: UIButton {
    var isClicked: Bool = false {
        didSet {
            self.titleLabel?.tintColor = isClicked ? #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1) : #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 0.5)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButtonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButtonInit()
    }
    
    private func setButtonInit() {
        self.titleLabel?.tintColor = isClicked ? #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1) : #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 0.5)
    }
    
}
