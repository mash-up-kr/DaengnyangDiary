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

    var baseURL: URL { URL(string: "")! }
    var path: String { "" }
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
    var headers: [String : String]? { nil }
    var sampleData: Data { Data() }

}
