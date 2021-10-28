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
}
