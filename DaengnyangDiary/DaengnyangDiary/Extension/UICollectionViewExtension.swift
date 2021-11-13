//
//  UICollectionViewExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit

extension UICollectionView {
    func registerNibCell<T>(_ cellType: T.Type) where T: UICollectionViewCell {
        let nib = UINib(nibName: "\(cellType)", bundle: nil)
        let identifier = "\(cellType)"
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusable<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
        return cell
    }
}
