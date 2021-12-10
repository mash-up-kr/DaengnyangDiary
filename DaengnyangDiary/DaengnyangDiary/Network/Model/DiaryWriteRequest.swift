//
//  DiaryWriteRequest.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/10.
//

import Foundation

struct DiaryWriteRequest: Codable {
    let content: String
    let pictureList: [Picture]
    let badgeId: Int
}

extension DiaryWriteRequest {

    struct Picture: Codable {
        let imageUrl: String
        let attachedStickerDtoList: [Sticker]
        let thumbnail: Bool
    }
}

extension DiaryWriteRequest.Picture {

    struct Sticker: Codable {
        let stickerId: Int
        let stickerX: Double
        let stickerY: Double
    }
}
