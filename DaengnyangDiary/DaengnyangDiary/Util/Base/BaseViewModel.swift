//
//  BaseViewModel.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/12/09.
//

import Foundation
import RxSwift
import RxRelay

protocol BaseViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    var bag: DisposeBag { get }
    var inputRelay: PublishRelay<Input> { get }
    var outputRelay: PublishRelay<Output> { get }
    func outputMapping()
    func outputBinding(_ input: Input) -> Output
}

extension BaseViewModelProtocol {
    func outputMapping() {
        inputRelay
            .compactMap { [weak self] in self?.outputBinding($0) }
            .bind(to: outputRelay)
            .disposed(by: bag)
    }
}
