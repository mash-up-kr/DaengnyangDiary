//
//  CreateBadgeSelectionViewModel.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import Foundation
import RxCocoa
import RxSwift

final class CreateBadgeSelectionViewModel {

    let actionList = BehaviorRelay<[BadgeEntity]>(value: [])

    func update() {
        self.actionList.accept(testModel)
    }

    private let testModel: [BadgeEntity] = [
        BadgeEntity(imageURL: "", title: "산책 오지게 했다"),
        BadgeEntity(imageURL: "", title: "산책 오지게 했다"),
        BadgeEntity(imageURL: "", title: "산책 오지게 했다"),
        BadgeEntity(imageURL: "", title: "산책 오지게 했다"),
        BadgeEntity(imageURL: "", title: "산책 오지게 했다"),
        BadgeEntity(imageURL: "", title: "산책 오지게 했다")
    ]

}

struct BadgeEntity: Codable {
    let imageURL: String
    let title: String
}
