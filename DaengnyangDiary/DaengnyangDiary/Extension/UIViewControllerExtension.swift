//
//  UIViewControllerExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/03.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
