//
//  SelectYearButton.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/03.
//

import UIKit
import SnapKit

class SelectYearButton: UIButton {
    private var yearLabel: UILabel!
    private var vectorImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonInit()
    }
    
    private func buttonInit() {
        yearLabel = UILabel()
        yearLabel.isUserInteractionEnabled = false
        
        addSubview(yearLabel)
        yearLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
        }
        
        yearLabel.text = Date().toString(format: .year)
        yearLabel.font = .systemFont(ofSize: 16, weight: .bold)
        yearLabel.textColor = #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
        
        vectorImageView = UIImageView()
        vectorImageView.image = Asset.down.image
        
        addSubview(vectorImageView)
        vectorImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(yearLabel.snp.trailing).offset(2)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }
    
    func setYear(_ year: String) {
        yearLabel.text = year
    }
}
