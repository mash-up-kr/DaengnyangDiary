//
//  MainViewModel.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

protocol MainViewModelDelegate: AnyObject {
    func reloadData()
}
class MainViewModel: BaseViewModelProtocol {
    let bag = DisposeBag()
    
    let inputRelay = PublishRelay<Input>()
    let outputRelay = PublishRelay<Output>()
    
    weak var delegate: MainViewModelDelegate?
    
    var selectedYear: Int = Date().year
    var selectedMonth: Int = Date().month // 현재 선택되어 있는 month
    var coverDataList: [CoverData?] = Array.init(repeating: nil, count: 12) {
        didSet {
            delegate?.reloadData()
        }
    }
    
    // MARK: - Properties
    enum Input {
        case requestCoverData
        case tapSelectYearButton
    }
    
    enum Output {
        case nothing
        case showSelectMonthView(_ year: Int, _ month: Int)
    }
    
    func outputBinding(_ input: Input) -> Output {
        switch input {
        case .requestCoverData:
            var year: String = "\(selectedYear)"
            let startIdx: String.Index = year.index(year.startIndex, offsetBy: 2)
            year = String(year[startIdx...])
            
            for month in 0..<12 { // 1년 12달의 데이터를 모두 가져옴
                self.api
                    .request(request: CoverData.self,apiType: .home(targetDate: "\(year)\(String(format: "%02d", month + 1))"))
                    .subscribe { [weak self] result in
                        self?.coverDataList[month] = result
                    } onError: { error in
                    }.disposed(by: self.bag)
            }
            return .nothing
        case .tapSelectYearButton:
            return .showSelectMonthView(selectedYear, selectedMonth)
        }
    }
    
    private let api = NetworkProvider<CoverAPI>()
}

struct ScheduleList {
    var isChecked: Bool
    var title: String
    var writeDate: Date
    var dueDate: Date
}
