//
//  MainCoverCardCollectionViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit

class MainCoverCardCollectionViewCell: UICollectionViewCell {
    private var cardView = CoverCardView()

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
        cardView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8784313725, blue: 0.8392156863, alpha: 1)
    }
    
    func setData(month: Int, data: CoverData?) {
        cardView.setData(month: month, data: data)
    }
}

struct CoverData: Codable {
    var imageUrl: String
    var attachedStickerList: [AttachedStickerList]
}

struct AttachedStickerList: Codable {
    var imageUrl: String
    var stickerX: CGFloat
    var stickerY: CGFloat
}
