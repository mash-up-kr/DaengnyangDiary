//
//  ScheduleCheckListView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/01.
//

import UIKit
import RxSwift
import RxCocoa

final class ScheduleCheckListView: UIView {
    var checkBox = CheckBox()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    
    var disposebag = DisposeBag()
    
    convenience init(isCheck: Bool, title: String, date: String) {
        self.init()
        setData(isCheck: isCheck, title: title, date: date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        bind()
    }
    
    private func configureView() {
        addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-11)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing)
            make.centerY.equalTo(checkBox.snp.centerY)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalTo(checkBox.snp.centerY)
        }
        
        checkIsDone(checkBox.isCheck)
    }
    
    private func bind() {
        checkBox.rx.tap
            .bind { [weak self] in
                self?.checkIsDone(self?.checkBox.isCheck ?? false)
            }
            .disposed(by: disposebag)
    }
    
    private func checkIsDone(_ isDone: Bool) {
        titleLabel.attributedText = titleLabel.text?.strikeThrough(isDone)
        
        if isDone {
            titleLabel.textColor = #colorLiteral(red: 0.3137254902, green: 0.2666666667, blue: 0.1725490196, alpha: 0.4)
            dateLabel.textColor = #colorLiteral(red: 0.3137254902, green: 0.2666666667, blue: 0.1725490196, alpha: 0.4)
        } else {
            titleLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            dateLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        }
    }
    
    func setData(isCheck: Bool, title: String, date: String) {
        self.checkBox.isCheck = isCheck
        self.titleLabel.text = title
        self.dateLabel.text = date
    }
}

final class DivisionView: UIView {
    private let division = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(division)
        division.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 0.57)
        division.snp.makeConstraints { make in
            make.height.equalTo(0.3)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
        }
    }
}


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
