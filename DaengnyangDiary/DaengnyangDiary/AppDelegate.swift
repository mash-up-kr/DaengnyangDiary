//
//  AppDelegate.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.checkLogin()
        return true
    }

    private func checkLogin() {
        if let _ = UserDataController.token {
        } else {
            self.changeToLoginView()
        }
    }

    private func changeToLoginView() {
        let stortboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = stortboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let scene = UIApplication.shared.connectedScenes.first           else { return }
        guard let windowScene = scene as? UIWindowScene                        else { return }
        let window = UIWindow(windowScene: windowScene)
        window.windowScene = windowScene
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func changeToTabBarController() {
        let stortboard = UIStoryboard(name: "Root", bundle: nil)
        let viewController = stortboard.instantiateViewController(withIdentifier: "TabBarController")
        guard let scene = UIApplication.shared.connectedScenes.first           else { return }
        guard let windowScene = scene as? UIWindowScene                        else { return }
        let window = UIWindow(windowScene: windowScene)
        window.windowScene = windowScene
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

