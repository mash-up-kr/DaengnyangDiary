//
//  UITableViewExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit

extension UITableView {
    func registerNibCell<T>(_ cellType: T.Type) where T: UITableViewCell {
        let nib = UINib(nibName: "\(cellType)", bundle: nil)
        let identifier = "\(cellType)"
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusable<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
        return cell
    }
}
