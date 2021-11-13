//
//  ScheduleListTableViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/13.
//

import UIKit
import RxCocoa
import RxSwift

class ScheduleListTableViewCell: UITableViewCell {
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var disposebag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bind()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bind()
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
