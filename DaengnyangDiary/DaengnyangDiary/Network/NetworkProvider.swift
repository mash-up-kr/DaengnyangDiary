//
//  NetworkProvider.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import Foundation
import Moya
import RxSwift
import Alamofire

final class NetworkProvider<U: TargetType> {

    func request<T: Codable>(apiType: U) -> Single<T> {
        self.provider.rx.request(apiType)
            .filter(statusCodes: 200...299)
            .map(T.self)
    }

    private let provider = MoyaProvider<U>(plugins: [NetworkLoggerPlugin()])

}

