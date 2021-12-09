//
//  MainViewModel.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel: BaseViewModelProtocol {
    let bag = DisposeBag()
    
    let inputRelay = PublishRelay<Input>()
    let outputRelay = PublishRelay<Output>()
    
    var selectedYear: Int = Date().year
    var selectedMonth: Int = Date().month // 현재 선택되어 있는 month
    
    // MARK: - Properties
    enum Input {
        case requestCoverData
        case tapSelectYearButton
    }
    
    enum Output {
        case settingCover
        case showSelectMonthView(_ year: Int, _ month: Int)
    }
    
    func outputBinding(_ input: Input) -> Output {
        switch input {
        case .requestCoverData:
            return .settingCover
        case .tapSelectYearButton:
            return .showSelectMonthView(selectedYear, selectedMonth)
        }
    }
}

struct ScheduleList {
    var isChecked: Bool
    var title: String
    var writeDate: Date
    var dueDate: Date
}
