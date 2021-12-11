//
//  User.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String?
    let nickname: String?
    let imageUrl: String?
}

struct UserToken: Codable {
    let token: String
}

struct Member: Codable {
    let memberId: Int
    let email: String
}
