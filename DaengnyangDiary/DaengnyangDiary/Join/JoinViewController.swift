//
//  JoinViewController.swift
//  DaengnyangDiary
//
//  Created by Yun on 2021/12/09.
//

import UIKit
import Photos

final class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupProfileImageView()
        self.setupNameTextField()
        self.setupEmailTextField()
        self.setupPasswordEmailTextField()
        self.setupPasswordHideButton()
        self.setupImagePicker()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction private func didTapAddImageButton(_ sender: UIButton) {
        self.checkPhotoPermission()
    }

    @IBAction private func didTapPasswordHideButton(_ sender: UIButton) {

    }

    @IBAction private func didTapJoinButton(_ sender: UIButton) {
        guard self.emailTextField?.text != nil         else { return }
        guard self.passwordTextField?.text != nil      else { return }
        guard self.nameTextField?.text != nil          else { return }
        guard let image = self.profileImageView?.image else { return }
        guard let data = image.pngData()               else { return }
        self.viewModel.saveFile(imageData: data) { urlList in
            guard let url = urlList.first?.imageUrl else { return }
            self.join(url: url)
        }
    }

    private func setupProfileImageView() {
        if let height = self.profileImageView?.bounds.height {
            self.profileImageView?.layer.cornerRadius = height / 2
        }

        if let height = self.profileImageButtonContainerView?.bounds.height {
            self.profileImageButtonContainerView?.layer.cornerRadius = height / 2
        }

        if let height = self.profileImageView?.bounds.height {
            self.profileImageButton?.layer.cornerRadius = height / 2
            self.profileImageButton?.setTitle("", for: .normal)
            self.profileImageButton?.setBackgroundColor(.white, for: .normal)
            //self.profileImageButton?.backgroundColor = .white
        }
    }

    private func setupNameTextField() {
        self.nameTextFieldContainerView?.layer.cornerRadius = 6
        self.nameTextField?.delegate = self
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

    private func join(url: String) {
        guard let email = self.emailTextField?.text       else { return }
        guard let password = self.passwordTextField?.text else { return }
        guard let nickname = self.nameTextField?.text     else { return }

        let user = User(email: email, password: password, nickname: nickname, imageUrl: url)
        self.viewModel.join(user: user) { [weak self] _ in
            //UserDataController.token = token.token
            self?.dismiss(animated: true, completion: nil)
//            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            appDelegate?.changeToTabBarController()
        }

    }

    private func setupImagePicker() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
    }

    private func checkPhotoPermission() {
        if #available(iOS 14, *) {
            let requiredAccessLevel: PHAccessLevel = .readWrite
            PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
                switch authorizationStatus {
                case .limited:
                    self.presentPhoto()
                case .authorized:
                    self.presentPhoto()
                default:
                    print("Unimplemented")
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    self.presentPhoto()
                default:
                    print("Unimplemented")
                }
            })
        }
    }

    private func presentPhoto() {
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
        }
    }

    private let viewModel = JoinViewModel()
    private let imagePicker = UIImagePickerController()

    @IBOutlet private weak var profileImageView: UIImageView?
    @IBOutlet private weak var profileImageButtonContainerView: UIView?
    @IBOutlet private weak var profileImageButton: UIButton?
    @IBOutlet private weak var nameTextFieldContainerView: UIView?
    @IBOutlet private weak var nameTextField: UITextField?
    @IBOutlet private weak var emailTextFieldContainerView: UIView?
    @IBOutlet private weak var emailTextField: UITextField?
    @IBOutlet private weak var passwordTextFieldContainerView: UIView?
    @IBOutlet private weak var passwordTextField: UITextField?
    @IBOutlet private weak var passwordHideButton: UIButton?
    @IBOutlet private weak var joinButton: UIButton?
}

extension JoinViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { return true }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage? = nil
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = possibleImage
        }
        self.profileImageView?.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }

}
