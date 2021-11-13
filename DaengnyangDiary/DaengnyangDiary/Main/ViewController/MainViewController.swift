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
        cell.setData(month: indexPath.row + 1, data: CoverData(imageUrl: "https://source.unsplash.com/Qb7D1xw28Co", attachedStickerList: [AttachedStickerList(imageUrl: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/b093aa11-89b9-490f-b43d-2e7512f14450/img_flower_1.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20211113%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20211113T210019Z&X-Amz-Expires=86400&X-Amz-Signature=6fd54c1b5a699e5e53792e0bcf6ebd829c16c192715091248fcb45ddb53645c4&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22img_flower_1.png%22", stickerX: 0.8, stickerY: 0.2), AttachedStickerList(imageUrl: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3fec47c6-6035-4bd3-8881-6ec980c305a6/img_heart_2.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20211113%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20211113T210032Z&X-Amz-Expires=86400&X-Amz-Signature=923b41b07dec19aec0a0bf18572b332e3c4c730dda087f3418760e8c6bb104c1&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22img_heart_2.png%22", stickerX: 0.2, stickerY: 0.8), AttachedStickerList(imageUrl: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/fec06f49-9425-4cfb-96f1-cb373150cfb0/img_tree_1.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20211113%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20211113T210036Z&X-Amz-Expires=86400&X-Amz-Signature=c6d58c13592cb52fb5758631e1deccfbd58e195a99dec7ab2ea90175e2877d10&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22img_tree_1.png%22", stickerX: 0.9, stickerY: 0.9)]))
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
