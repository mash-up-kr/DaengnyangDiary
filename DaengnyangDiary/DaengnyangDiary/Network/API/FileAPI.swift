//
//  FileAPI.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation
import Moya

enum FileAPI {
    case save(imageData: Data, fileName: String)
}

extension FileAPI: TargetType {

    var baseURL: URL { URL(string: BasicAPI.basePath)! }

    var path: String {
        switch self {
        case .save:                 return "/api/v1/cover"
        }
    }

    var method: Moya.Method {
        switch self {
        case .save:                 return .post
        }
    }

    var task: Task {
        switch self {
        case let .save(imageData, fileName):
            let data = MultipartFormData(provider: .data(imageData), name: "imageFile", fileName: "\(fileName).png", mimeType: "image/png")
            return .uploadMultipart([data])
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
