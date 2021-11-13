//
//  ScheduleCheckListView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/01.
//

import UIKit
import RxSwift
import RxCocoa

final class CheckBox: UIButton {
    @IBInspectable var isCheck: Bool = false {
        didSet {
            isSelected = isCheck
        }
    }
    
    private var checkBox = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkBoxInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        checkBoxInit()
    }
    
    private func checkBoxInit() {
        checkBox.image = isCheck ? Asset.icCheckOn.image : Asset.icCheckOff.image
        
        addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        #warning("버튼을 두번 눌러야 그때부터 액션이 잡힘")
        addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
    }
    
    @objc func checkAction(_ sender: CheckBox) {
        isCheck = !isCheck
        checkBox.image = isCheck ? Asset.icCheckOn.image : Asset.icCheckOff.image
    }
}
