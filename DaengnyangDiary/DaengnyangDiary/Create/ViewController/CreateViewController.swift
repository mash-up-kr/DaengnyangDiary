//
//  CreateViewController.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import UIKit
import Photos
import RxSwift

struct Login: Codable {
    let token: String
}

final class CreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDateLabel()
        self.setupAddImageButton()
        self.setupTextView()
        self.setupImagePicker()
    }

    @IBAction private func didTapAddImageButton(_ sender: UIButton) {
        self.checkPhotoPermission()
    }

    @IBAction private func didTapAddBdgeButton(_ sender: UIButton) {
    }

    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func didTapConfirmButton(_ sender: UIButton) {
    }

    private func setupDateLabel() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        self.dateLabel?.text = dateFormatter.string(from: now)
    }

    private func setupAddImageButton() {
        self.addImageButton?.layer.cornerRadius = 12.0
    }

    private func setupTextView() {
        self.textView?.delegate = self
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

    private let disposebag = DisposeBag()
    private let viewModel = CreateViewModel()
    private let imagePicker = UIImagePickerController()

    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var addImageButton: UIButton?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var placeholderLabel: UILabel?
    @IBOutlet private weak var textView: UITextView?

}

extension CreateViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel?.isHidden = true
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text ?? ""
        self.placeholderLabel?.isHidden = text.isEmpty == false
    }

}

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage? = nil
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = possibleImage
        }
        self.imageView?.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }

}
