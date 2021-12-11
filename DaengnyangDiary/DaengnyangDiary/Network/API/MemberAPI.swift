//
//  MemberAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum MemberAPI {
    case signUp(user: User)
    case login(user: User)
}

extension MemberAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .signUp:           return "/api/v1/member/signUp"
        case .login:            return "/api/v1/member/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp:           fallthrough
        case .login:            return .post
        }
    }

    var task: Task {
        switch self {
        case let .signUp(user): fallthrough
        case let .login(user):  return .requestJSONEncodable(user)
        }
    }

    var headers: [String : String]? { BasicAPI.headers }
    var sampleData: Data { Data() }
}
