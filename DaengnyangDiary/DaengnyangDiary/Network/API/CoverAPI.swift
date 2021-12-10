//
//  CoverAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum CoverAPI {
    case save(coverDate: String)    // 서버 Request Parameter 확인 후, coverDate 타입 수정 필요
    case home(targetDate: String)
}

extension CoverAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .save:                 return "/api/v1/cover"
        case .home(let targetDate): return "/api/v1/cover/\(targetDate)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .save:                 return .get
        case .home:                 return .post
        }
    }

    var task: Task {
        switch self {
        case .save(let coverDate):  return .requestPlain // 서버 데이터 확인 후, 변경 필요
        case .home:                 return .requestPlain
        }
    }

    var headers: [String : String]? {
        var header = BasicAPI.headers
        if let token = UserDataController.token {
            header["eclass-auth-token"] = token
        }
        return header
    }

    var sampleData: Data { Data() }
}
