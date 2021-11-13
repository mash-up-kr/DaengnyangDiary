//
//  MainViewModel.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    
    var isPickerViewOpened = PublishRelay<Bool>()
    var selectedYear = PublishRelay<String>()
    
    // MARK: - Properties
    
//    struct Input {
//        var closePickerView: Observable<Void>
//    }
//    struct Output {
//        var isPickerViewOpened = PublishRelay<Bool>()
//        var selectedYear = PublishRelay<String>()
//    }
//    
//    // MARK: - Initializers
//    
//    deinit {
//        print("\(String(describing: self)) deinit")
//    }
//    
//    // MARK: - Methods
//    
//    func transform(input: Input) -> Output {
//        
//    }
}

struct ScheduleList {
    var isChecked: Bool
    var title: String
    var writeDate: Date
    var dueDate: Date
}
