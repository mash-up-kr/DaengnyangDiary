//
//  JoinViewModel.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/09.
//

import Foundation
import RxSwift

final class JoinViewModel {

    func join(user: User, completion: @escaping (Member) -> Void) {
        self.memberAPI
            .request(apiType: .signUp(user: user))
            .subscribe { (data: Member) in
                completion(data)
        } onError: { error in
        }.disposed(by: self.disposeBag)
    }

    func saveFile(imageData: Data, completion: @escaping ([File]) -> Void) {
        let fileName = Date().timeIntervalSince1970
        self.fileAPI
            .request(apiType: .save(imageData: imageData, fileName: "\(fileName)"))
            .subscribe { (data: [File]) in
                completion(data)
        } onError: { error in
        }.disposed(by: self.disposeBag)
    }

    private let memberAPI = NetworkProvider<MemberAPI>()
    private let fileAPI = NetworkProvider<FileAPI>()
    private let disposeBag = DisposeBag()
}
