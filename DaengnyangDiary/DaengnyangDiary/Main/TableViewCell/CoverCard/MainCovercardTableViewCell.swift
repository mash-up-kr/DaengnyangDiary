//
//  MainCovercardTableViewCell.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit

class MainCovercardTableViewCell: UITableViewCell {
    @IBOutlet weak var selectYearButton: UIButton!
    @IBOutlet weak var thisMonthShadowView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellWidth: CGFloat = 290
    let cellHeight: CGFloat = 395
    
    
    var currentIndex: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        setCollectionView()
        setBackgroundView()
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
        // 💩 약간 부자연스러움
        collectionView.decelerationRate = .fast
        
        collectionView.registerNibCell(MainCoverCardCollectionViewCell.self)
    }
    
    private func setBackgroundView() {
        thisMonthShadowView.setCornerRadius(radius: 24)
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

