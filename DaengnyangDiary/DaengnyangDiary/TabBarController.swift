//
//  TabBarController.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/11/14.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupApperence()
        self.delegate = self
    }

    private func setupApperence() {
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = UIColor(red: 246, green: 244, blue: 241, alpha: 1)
        self.tabBar.tintColor = .orange//UIColor(red: 240, green: 126, blue: 58, alpha: 1)
        self.tabBar.unselectedItemTintColor = .lightGray//UIColor(red: 160, green: 157, blue: 150, alpha: 1)
    }

}

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = tabBarController.viewControllers           else { return false }
        guard let selectIndex = viewControllers.firstIndex(of: viewController) else { return false }
        let createIndex = 2

        if selectIndex == createIndex {
            self.presentCreateView()
        }

        return selectIndex != createIndex
    }

    private func presentCreateView() {
        let storyboard = UIStoryboard(name: "Create", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

}
