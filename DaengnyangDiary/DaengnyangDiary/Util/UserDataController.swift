//
//  UserDataController.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation

class UserDataController {

    static var token: String? {
        get { UserDefaults.standard.value(forKey: "tokenKey") as? String }
        set { UserDefaults.standard.set(newValue, forKey: "tokenKey")   }
    }

    private init() { }

    private static let tokenKey = "tokenKey"
}
