//
//  MainDatePickerViewController.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/03.
//

import UIKit
import RxSwift

protocol MainDataPickerViewControllerDelegate: AnyObject {
    func closePickerView()
}
class MainDatePickerViewController: UIViewController {
    @IBOutlet weak var contentWrapper: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate: MainDataPickerViewControllerDelegate?
    
    lazy var backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:)))
    
    var dataSource = MainDatePickerDataSource()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(backgroundTapGesture)
        
        pickerView.delegate = dataSource
        pickerView.dataSource = dataSource
        
        contentWrapper.setCornerRadius(radius: 24, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickerView.selectRow(self.dataSource.yearList.count - 1, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.closePickerView()
    }
    
    @objc private func didTapBackground(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
