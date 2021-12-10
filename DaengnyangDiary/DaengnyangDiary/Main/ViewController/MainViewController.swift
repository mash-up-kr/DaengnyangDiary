//
//  MainViewController.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController<MainViewModel> {
    var checkListTestData = [
        CheckListData(isCheck: true, title: "특식 먹는날", date: "11월 16일"),
        CheckListData(isCheck: false, title: "콩이 심장사상충 검사", date: "11월 25일"),
        CheckListData(isCheck: false, title: "애견 펜션 가는 날", date: "12월 03일"),
        CheckListData(isCheck: false, title: "리치 병원가는 날", date: "12월 05일"),
        CheckListData(isCheck: false, title: "특식 먹는날", date: "12월 5일")
    ]
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setViewModel(MainViewModel())
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.inputRelay.accept(.requestCoverData)
        scheduleListTableView.registerNibCell(ScheduleListTableViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionView()
        configureScheduleListView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Bind
    override func viewBinding() {
        super.viewBinding()
        selectYearButton.rx.tap
            .map { MainViewModel.Input.tapSelectYearButton }
            .bind(to: viewModel.inputRelay)
            .disposed(by: bag)
        
        orderButton.rx.tap
            .bind { [weak self] in
                self?.orderListStackView.isHidden = !(self?.orderListStackView.isHidden ?? false)
                self?.orderButton.isClicked = !(self?.orderButton.isClicked ?? false)
            }
            .disposed(by: bag)
    }
    
    override func viewModelBinding() {
        super.viewModelBinding()
        viewModel.outputRelay
            .bind { [weak self] in self?.result($0) }
            .disposed(by: bag)
    }
    
    func result(_ output: MainViewModel.Output) {
        switch output {
        case .showSelectMonthView(let selectedYear, let selectedMonth):
            let vc = MonthPickerView.instantiate()
            vc.selectedYear = selectedYear
            vc.selectedMonth = selectedMonth
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: false, completion: nil)
        case .nothing:
            break
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectYearButton: SelectYearButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scheduleListTableView: UITableView!
    @IBOutlet weak var scheduleListTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var orderButton: SelectOrderButton!
    @IBOutlet weak var orderListStackView: UIStackView!
    
    private let cellWidth: CGFloat = 290
    private let cellHeight: CGFloat = 395
}

extension MainViewController: MonthPickerViewControllerDelegate {
    func choose(year: Int, month: Int) {
        if viewModel.selectedYear != year {
            viewModel.inputRelay.accept(.requestCoverData)
        }
        selectYearButton.setYear("\(year)")
        viewModel.selectedYear = year
        viewModel.selectedMonth = month
        collectionView.scrollToItem(at: IndexPath(row: month - 1, section: 0), at: .left, animated: true)
    }
}

extension MainViewController: MainViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - subviewSetting
extension MainViewController {
    private func configureCollectionView() {
        // 상하, 좌우 inset value 설정
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 23
        layout.scrollDirection = .horizontal
        let insetX = (self.view.bounds.width - cellWidth) / 2.0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        collectionView.isPagingEnabled = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 스크롤 시 빠르게 감속 되도록 설정
        collectionView.decelerationRate = .fast
        
        collectionView.registerNibCell(MainCoverCardCollectionViewCell.self)
        
        collectionView.scrollToItem(at: IndexPath(row: viewModel.selectedMonth - 1, section: 0), at: .left, animated: false)
    }
    
    private func configureScheduleListView() {
        scheduleListTableViewHeight.constant = scheduleListTableView.contentSize.height
        scheduleListTableView.setCornerRadius(radius: 12)
        scheduleListTableView.delegate = self
        scheduleListTableView.dataSource = self
        orderListStackView.isHidden = true
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkListTestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(ScheduleListTableViewCell.self, for: indexPath)
        cell.setData(checkListTestData[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(MainCoverCardCollectionViewCell.self, for: indexPath)
        cell.setData(month: indexPath.row + 1, data: viewModel.coverDataList[indexPath.row])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = layout.itemSize.width + layout.minimumLineSpacing
        let inertialTargetX = targetContentOffset.pointee.x
        let offsetFromPreviousPage = (inertialTargetX + collectionView.contentInset.left).truncatingRemainder(dividingBy: itemWidth)

        // snap to the nearest page
        let pagedX: CGFloat
        if offsetFromPreviousPage > itemWidth / 2 {
            pagedX = inertialTargetX + (itemWidth - offsetFromPreviousPage)
        } else {
            pagedX = inertialTargetX - offsetFromPreviousPage
        }

        let point = CGPoint(x: pagedX, y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}
