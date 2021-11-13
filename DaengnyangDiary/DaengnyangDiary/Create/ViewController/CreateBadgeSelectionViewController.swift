//
//  CreateBadgeSelectionViewController.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import UIKit
import RxCocoa
import RxSwift

final class CreateBadgeSelectionViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dimAnimation(alpah: 0.2)
        self.viewModel.update()
    }

    private func setupViews() {
        self.setupContentView()
    }

    private func setupContentView() {
        self.contentView?.layer.cornerRadius = 14.0
    }

    private func setupTableView() {
//        self.tableView?.rx
//            .setDelegate(self)
//            .disposed(by: self.disposeBag)
    }

    private func dimAnimation(alpah: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView?.backgroundColor = UIColor(white: 0.0, alpha: alpah)
        }, completion: completion)
    }

    private func bindViews() {
        self.bindButtons()
        self.bindTableView()
    }

    private func bindButtons() {
        self.closeButton?.rx.tap
            .observeOn(MainScheduler.instance)
            .bind { [weak self] in
                self?.didTapCloseButton()
            }.disposed(by: self.disposeBag)
    }

    private func bindTableView() {
        guard let tableView = self.tableView else { return }
        self.viewModel.actionList.bind(to: tableView.rx.items) { [weak self] tableView, index, item in
            guard let self = self else { return UITableViewCell() }
            return self.makeBadgeSelectionCell(tableView: tableView, index: index, item: item)
        }.disposed(by: self.disposeBag)

        tableView.rx
            .modelSelected(BadgeEntity.self)
            .observeOn(MainScheduler.instance)
            .bind { [weak self] model in
                self?.didTapModel(model)
            }.disposed(by: self.disposeBag)
    }

    private func makeBadgeSelectionCell(tableView: UITableView, index: Int, item: BadgeEntity) -> UITableViewCell {
        let identifier = String(describing: CreateBadgeSelectionTableViewCell.self)
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: identifier, for: IndexPath(row: index, section: .zero)) as? CreateBadgeSelectionTableViewCell else { return UITableViewCell() }
        return cell
    }

    private func didTapModel(_ model: BadgeEntity) {
        self.dimAnimation(alpah: 0.0) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func didTapCloseButton() {
        self.dimAnimation(alpah: 0.0) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }

    private let viewModel = CreateBadgeSelectionViewModel()
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var backgroundView: UIView?
    @IBOutlet private weak var contentView: UIView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var closeButton: UIButton?
    @IBOutlet private weak var tableView: UITableView?

}
