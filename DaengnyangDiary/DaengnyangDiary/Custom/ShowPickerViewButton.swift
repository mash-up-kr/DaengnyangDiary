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
        vectorImageView.image = Asset.arrowDown.image
        
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
    
    func isClicked(_ isClicked: Bool) {
        vectorImageView.image = isClicked ? Asset.arrowUp.image : Asset.arrowDown.image
    }
}

class SelectOrderButton: UIButton {
    private var orderLabel: UILabel!
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
        orderLabel = UILabel()
        orderLabel.isUserInteractionEnabled = false
        
        addSubview(orderLabel)
        orderLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
        }
        
        orderLabel.text = "완료순"
        orderLabel.font = .systemFont(ofSize: 13, weight: .regular)
        orderLabel.textColor = #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
        
        vectorImageView = UIImageView()
        vectorImageView.image = Asset.arrowDown.image
        
        addSubview(vectorImageView)
        vectorImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(orderLabel.snp.trailing).offset(2)
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }
    
    func setOrder(_ order: String) {
        orderLabel.text = order
    }
    
    func isClicked(_ isClicked: Bool) {
        vectorImageView.image = isClicked ? Asset.arrowUp.image : Asset.arrowDown.image
    }
}
