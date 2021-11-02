//
//  MainCoverCardCollectionViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit

class MainCoverCardCollectionViewCell: UICollectionViewCell {
    private var cardView = UIView() // 공통 뷰로 만들거지만 그냥 임시

    override func layoutSubviews() {
        super.layoutSubviews()
        setConfigureUI()
    }
    
    private func setConfigureUI() {
        self.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        cardView.setCornerRadius(radius: 24)
        cardView.backgroundColor = UIColor.white
    }
}
