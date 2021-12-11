//
//  LoginViewController.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/09.
//

import UIKit

final class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLogoView()
        self.setupEmailTextField()
        self.setupPasswordEmailTextField()
        self.setupPasswordHideButton()
        self.setupLoginButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setupLogoView() {
        guard let height = self.logoLeftView?.bounds.height else { return }
        self.logoLeftView?.layer.cornerRadius = height / 2
        self.logoCenterView?.layer.cornerRadius = height / 2
        self.logoRightView?.layer.cornerRadius = height / 2
    }

    private func setupEmailTextField() {
        self.emailTextFieldContainerView?.layer.cornerRadius = 6
        self.emailTextField?.delegate = self
    }

    private func setupPasswordEmailTextField() {
        self.passwordTextFieldContainerView?.layer.cornerRadius = 6
        self.passwordTextField?.delegate = self
    }

    private func setupPasswordHideButton() {
        self.passwordHideButton?.setTitle("", for: .normal)
    }

    private func setupLoginButton() {
        self.loginButton?.layer.cornerRadius = 6
    }

    @IBAction private func didTapPasswordHideButton(_ sender: UIButton) {

    }

    @IBAction private func didTapLoginButton(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeToTabBarController()
    }

    @IBAction private func didTapSignupButton(_ sender: UIButton) {
        let stortboard = UIStoryboard(name: "Join", bundle: nil)
        let viewController = stortboard.instantiateViewController(withIdentifier: "JoinViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    private let viewModel = LoginViewModel()

    @IBOutlet private weak var logoLeftView: UIView?
    @IBOutlet private weak var logoCenterView: UIView?
    @IBOutlet private weak var logoRightView: UIView?
    @IBOutlet private weak var emailTextFieldContainerView: UIView?
    @IBOutlet private weak var emailTextField: UITextField?
    @IBOutlet private weak var passwordTextFieldContainerView: UIView?
    @IBOutlet private weak var passwordTextField: UITextField?
    @IBOutlet private weak var passwordHideButton: UIButton?
    @IBOutlet private weak var loginButton: UIButton?
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { return true }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
