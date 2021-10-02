//
//  CreateBadgeSelectionTableViewCell.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/03.
//

import UIKit
import Kingfisher

final class CreateBadgeSelectionTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.badgeIconImageView?.kf.cancelDownloadTask()
    }

    func configure(data: BadgeEntity) {
        self.badgeIconTitleLabel?.text = data.title
        self.badgeIconImageView?.kf.setImage(with: URL(string: data.imageURL))
    }

    private func setupViews() {
        self.setupBorderView()
        self.setupInnerContainerView()
    }

    private func setupBorderView() {
        self.borderView?.layer.cornerRadius = self.radius
    }

    private func setupInnerContainerView() {
        self.innerContainerView?.layer.cornerRadius = self.radius
    }

    private let radius: CGFloat = 10.0

    @IBOutlet private weak var borderView: UIView?
    @IBOutlet private weak var innerContainerView: UIView?
    @IBOutlet private weak var badgeIconImageView: UIImageView?
    @IBOutlet private weak var badgeIconTitleLabel: UILabel?

}
