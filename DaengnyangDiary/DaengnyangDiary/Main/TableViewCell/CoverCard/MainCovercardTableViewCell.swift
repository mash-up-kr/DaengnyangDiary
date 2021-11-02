//
//  MainCovercardTableViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxCocoa
import RxSwift

class MainCovercardTableViewCell: UITableViewCell {
    @IBOutlet weak var selectYearButton: SelectYearButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellWidth: CGFloat = 290
    private let cellHeight: CGFloat = 395
    
    var selectedYear = PublishRelay<String>()
    
    var isPickerViewOpening = PublishRelay<Bool>()
    
    var disposeBag = DisposeBag()
    
    var currentIndex: CGFloat = 0
    
    func setData(flag: PublishRelay<Bool>) {
        isPickerViewOpening = flag
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // 이전 구독한 것이 강제로 재설정되고 새 스트림이 설정
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCollectionView()
        bindViews()
    }
    
    // MARK: - bind
    private func bindViews() {
        isPickerViewOpening
            .bind { [weak self] isOpened in
                self?.selectYearButton.isClicked(isOpened)
            }
            .disposed(by: disposeBag)
        
        selectedYear
            .bind { [weak self] year in
                self?.selectYearButton.setYear(year)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Action
    @IBAction func yearButtonClick(_ sender: Any) {
        isPickerViewOpening.accept(true)
    }
    
    // MARK: - Func
    private func setCollectionView() {
        // 상하, 좌우 inset value 설정
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 23
        layout.scrollDirection = .horizontal
        let insetX = (self.bounds.width - cellWidth) / 2.0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 스크롤 시 빠르게 감속 되도록 설정
        collectionView.decelerationRate = .fast
        
        collectionView.registerNibCell(MainCoverCardCollectionViewCell.self)
    }
}

// MARK: - <Extension> UICollectionViewDataSource
extension MainCovercardTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(MainCoverCardCollectionViewCell.self, for: indexPath)
        return cell
    }
}

// MARK: - <Extension> UICollectionViewDelegate
extension MainCovercardTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - <Extension> UICollectionViewDelegateFlowLayout
extension MainCovercardTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - <Extension> UIScrollViewDelegate
// 💩 이 방법 쓰지 않고 inset이 있어도 일그러지지 않는 page 가능한 방법 찾아보기
extension MainCovercardTableViewCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
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

