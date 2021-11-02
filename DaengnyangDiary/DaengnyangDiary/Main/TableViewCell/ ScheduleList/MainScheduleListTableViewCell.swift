//
//  ScheduleListTableViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/01.
//

import UIKit
import RxSwift

class MainScheduleListTableViewCell: UITableViewCell {
    @IBOutlet weak var checkListView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        configureUI()
    }
    
    private func configureUI() {
        checkListView.setCornerRadius(radius: 12)
        
        let checkBoxCell = ScheduleCheckListView(isCheck: true, title: "콩이 사상충약", date: "5월 21일")
        let checkBoxCell2 = ScheduleCheckListView(isCheck: true, title: "콩이 사상충약", date: "5월 21일")
        stackView.addArrangedSubview(checkBoxCell)
        stackView.addArrangedSubview(DivisionView())
        stackView.addArrangedSubview(checkBoxCell2)
    }
}
