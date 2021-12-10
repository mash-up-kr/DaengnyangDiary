//
//  BadgeAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum BadgeAPI {
    case getList
}

extension BadgeAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .getList:  return "/api/v1/badge"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getList:  return .get
        }
    }

    var task: Task {
        switch self {
        case .getList:  return .requestPlain
        }
    }

    var headers: [String : String]? {  BasicAPI.headers }
    var sampleData: Data { Data() }
}
