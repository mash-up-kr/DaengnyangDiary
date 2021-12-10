//
//  CreateViewModel.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import Foundation
import RxSwift

final class CreateViewModel {

    func test() {
        self.api
            .request(apiType: .write(param: DiaryWriteRequest(content: "", pictureList: [], badgeId: 1)))
            .subscribe { (data: String) in
        } onError: { error in
        }.disposed(by: self.disposebag)
    }

    private let api = NetworkProvider<DiaryAPI>()
    private let disposebag = DisposeBag()
}
