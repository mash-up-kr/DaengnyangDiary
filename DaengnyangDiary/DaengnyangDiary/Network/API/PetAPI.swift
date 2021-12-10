//
//  PetAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum PetAPI {
    case save(petPostDto: String)      // 서버 Request Parameter 확인 후, petPostDto 타입 수정 필요
    case search
}

extension PetAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .save:                 return "/api/v1/pet"
        case .search:               return "/api/v1/pet"
        }
    }

    var method: Moya.Method {
        switch self {
        case .save:                 return .post
        case .search:               return .get
        }
    }

    var task: Task {
        switch self {
        case .save(let petPostDto): return .requestPlain // 서버 데이터 확인 후, 변경 필요
        case .search:               return .requestPlain
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
