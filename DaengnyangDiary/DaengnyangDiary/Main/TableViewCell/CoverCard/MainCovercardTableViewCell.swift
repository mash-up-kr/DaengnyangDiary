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
    var selectedMonth: CGFloat = CGFloat(Date().month)
    
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
        collectionView.isPagingEnabled = false
        
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
        // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
            
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
            
        } else {
            roundedIndex = round(index)
            
        }
        
        if selectedMonth > roundedIndex {
            selectedMonth -= 1
            roundedIndex = selectedMonth
            
        } else if selectedMonth < roundedIndex {
            selectedMonth += 1
            roundedIndex = selectedMonth
            
        }

        // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

