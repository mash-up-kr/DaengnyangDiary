//
//  CoverCardView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/14.
//

import RxSwift
import RxCocoa

final class CoverCardView: UIView {
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
        
        addSubview(monthImageView)
        monthImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func setData(month: Int) {
        monthImageView.image = monthImages[month]
    }
}
