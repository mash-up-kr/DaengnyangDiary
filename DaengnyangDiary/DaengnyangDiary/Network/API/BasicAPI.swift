//
//  BasicAPI.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import Foundation
import Moya

enum BasicAPI {
    case test
}

extension BasicAPI: TargetType {

    var baseURL: URL { URL(string: Self.basePath)! }
    var path: String { "/ping" }
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
    var headers: [String : String]? { Self.headers }
    var sampleData: Data { Data() }
}

extension BasicAPI {

    static var basePath: String { "https://server.jonghyeon.com" }
    static var headers: [String: String] {
        ["Content-type": "application/json"]
    }
}
