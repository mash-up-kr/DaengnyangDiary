//
//  MainViewController.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
    }
    
    // MARK: - Func
    private func registerCells() {
        tableView.registerNibCell(MainHeaderTableViewCell.self)
        tableView.registerNibCell(MainCovercardTableViewCell.self)
        tableView.registerNibCell(MainScheduleListTableViewCell.self)
    }
    
    // MARK: - Bind
    func bind() {
        bindTableView()
        bindViewModel()
    }
    
    func bindTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        
        let observableCell = Observable<[tableViewCell]>.just([
            .MainHeaderTableViewCell,
            .MainCovercardTableViewCell(viewModel.isPickerViewOpened),
            .MainScheduleListTableViewCell
        ])
        
        observableCell.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: tableViewCell) in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .MainHeaderTableViewCell:
                let cell = tableView.dequeueReusable(MainHeaderTableViewCell.self, for: indexPath)
                return cell
            case .MainCovercardTableViewCell(let isOpened):
                let cell = tableView.dequeueReusable(MainCovercardTableViewCell.self, for: indexPath)
                cell.isPickerViewOpening = isOpened
                cell.selectedYear = self.viewModel.selectedYear
                return cell
            case .MainScheduleListTableViewCell:
                let cell = tableView.dequeueReusable(MainScheduleListTableViewCell.self, for: indexPath)
                return cell
            }
        }
        .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel.isPickerViewOpened
            .subscribe(onNext: { [weak self] isOpened in
                if isOpened {
                    self?.didTapSelectYearButton()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Func
    func didTapSelectYearButton() {
        let vc = MainDatePickerViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.dataSource.selectedYear = viewModel.selectedYear
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - TableViewCell 배열 선언
    enum tableViewCell {
        case MainHeaderTableViewCell
        case MainCovercardTableViewCell(_ isPickerViewOpened: PublishRelay<Bool>)
        case MainScheduleListTableViewCell
    }
}

extension MainViewController: MainDataPickerViewControllerDelegate {
    func closePickerView() {
        viewModel.isPickerViewOpened
            .accept(false)
    }
}
