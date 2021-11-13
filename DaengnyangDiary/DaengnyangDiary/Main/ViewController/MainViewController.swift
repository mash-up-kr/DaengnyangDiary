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
    private let viewModel = MainViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    var month = Date().month
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleListTableView.registerNibCell(ScheduleListTableViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionView()
        configureScheduleListView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
    }
    
    // MARK: - Bind
    func bind() {
        bindView()
        bindViewModel()
    }
    
    func bindView() {
        orderButton.rx.tap
            .bind { [weak self] in
                self?.orderListStackView.isHidden = !(self?.orderListStackView.isHidden ?? false)
                self?.orderButton.isClicked = !(self?.orderButton.isClicked ?? false)
            }
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
    }
    
    // MARK: - action
    @IBAction func selectYearButton(_ sender: SelectYearButton) {
        let vc = MonthPickerView.instantiate()
        vc.selectedMonth = month
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
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
        self.month = month
        collectionView.scrollToItem(at: IndexPath(row: month - 1, section: 0), at: .left, animated: true)
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
        
        collectionView.scrollToItem(at: IndexPath(row: month - 1, section: 0), at: .left, animated: false)
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
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(ScheduleListTableViewCell.self, for: indexPath)
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
        cell.setData(month: indexPath.row + 1)
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
