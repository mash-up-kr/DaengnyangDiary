//
//  BasicService.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import Foundation
import Moya

enum BasicService {
    case basic
}

extension BasicService: TargetType {

    var baseURL: URL { URL(string: "https://eclass.jonghyeon.com")! }
    var path: String { "/api/v1/member/login" }
    var method: Moya.Method { .post }
    var task: Task {
        .requestParameters(parameters: ["email" : "whdgus8219@naver.com", "password" : "samplePassword"], encoding: JSONEncoding.default)
    }
    var headers: [String : String]? {
        ["application/json": "charset=UTF-8"]
    }
    var sampleData: Data { Data() }

}
