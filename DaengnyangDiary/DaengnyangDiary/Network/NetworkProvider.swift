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

final class NetworkProvider {

    static func request<T: Codable, U: TargetType>(apiType: U) -> Single<T> {
        Single<T>.create { single in
            let provider = MoyaProvider<U>(plugins: [NetworkLoggerPlugin()])
            let request = provider.request(apiType) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsondata = try response.mapString().data(using: .utf8) {
                            let json = try JSONDecoder().decode(T.self, from: jsondata)
                            single(.success(json))
                        } else {
                            throw NSError(domain: "parse error", code: -1, userInfo: nil)
                        }
                    } catch let error {
                        single(.error(error))
                    }
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create { request.cancel() }
            //.rx.request(apiType)
            //.filter(statusCodes: 200...299)
            //.map(T.self)
        }
    }

}

