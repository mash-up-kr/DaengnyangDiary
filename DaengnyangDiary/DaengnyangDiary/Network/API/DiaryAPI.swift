//
//  DiaryAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum DiaryAPI {
    case write(param: DiaryWriteRequest)
}

extension DiaryAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .write:
            return "/api/v1/diary"
        }
    }

    var method: Moya.Method {
        switch self {
        case .write:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .write(let param): return .requestJSONEncodable(param)
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
