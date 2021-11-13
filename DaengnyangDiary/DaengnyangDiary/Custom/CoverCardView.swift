//
//  CoverCardView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/14.
//

import RxSwift
import RxCocoa

final class CoverCardView: UIView {
    private var coverImageView = UIImageView()
    private var monthImageView = UIImageView()
    private var monthImages = [Asset.month01.image, Asset.month01.image, Asset.month02.image, Asset.month03.image, Asset.month04.image, Asset.month05.image, Asset.month06.image, Asset.month07.image, Asset.month08.image, Asset.month09.image, Asset.month10.image, Asset.month11.image, Asset.month12.image]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkBoxInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        checkBoxInit()
    }
    
    private func checkBoxInit() {
        monthImageView.image = Asset.month01.image
        
        addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(monthImageView)
        monthImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func setData(month: Int, data: CoverData) {
        monthImageView.image = monthImages[month]
        coverImageView.load(data.imageUrl)
        data.attachedStickerList.forEach { sticker in
            let stickerImageView = UIImageView()
            stickerImageView.load(sticker.imageUrl)
            addSubview(stickerImageView)
            stickerImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(272 * sticker.stickerX - 50)
                make.top.equalToSuperview().offset(364 * sticker.stickerY - 50)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
        }
    }
}
