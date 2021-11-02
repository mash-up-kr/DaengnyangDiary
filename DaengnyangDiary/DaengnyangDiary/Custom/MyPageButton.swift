//
//  MyPageButton.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/01.
//

import UIKit

final class MyPageButton: UIButton {
    private var profileImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButtonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButtonInit()
    }
    
    private func setButtonInit() {
        backgroundColor = .black
        
        self.setCornerRadius(radius: 18)
        
        profileImage = UIImageView()
        profileImage.image = .init(systemName: "person.crop.circle")
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = 17
        profileImage.layer.backgroundColor = UIColor.white.cgColor
        
        addSubview(profileImage)
        profileImage.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(34)
            maker.width.equalTo(34)
        }
    }
}
