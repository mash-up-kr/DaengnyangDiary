//
//  UIImageViewExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/14.
//

import UIKit

extension UIImageView {
    func load(_ path: String) {
        let url: URL = URL(string: path)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
