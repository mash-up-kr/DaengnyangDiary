//
//  LoginViewModel.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/09.
//

import Foundation
import RxSwift

final class LoginViewModel {

    func login(user: User) {
        self.api
            .request(apiType: .login(user: user))
            .subscribe { (data: UserToken) in
        } onError: { error in
        }.disposed(by: self.disposeBag)
    }

    private let api = NetworkProvider<MemberAPI>()
    private let disposeBag = DisposeBag()
}
