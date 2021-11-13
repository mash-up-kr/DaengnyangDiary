//
//  monthPickerView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/14.
//

import UIKit
import RxSwift

protocol MonthPickerViewControllerDelegate: AnyObject {
    func choose(year: String, month: String)
}
final class MonthPickerView: UIViewController {
    weak var delegate: MainDataPickerViewControllerDelegate?
    
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var month01: PickerViewMonthButton!
    @IBOutlet weak var month02: PickerViewMonthButton!
    @IBOutlet weak var month03: PickerViewMonthButton!
    @IBOutlet weak var month04: PickerViewMonthButton!
    @IBOutlet weak var month05: PickerViewMonthButton!
    @IBOutlet weak var month06: PickerViewMonthButton!
    @IBOutlet weak var month07: PickerViewMonthButton!
    @IBOutlet weak var month08: PickerViewMonthButton!
    @IBOutlet weak var month09: PickerViewMonthButton!
    @IBOutlet weak var month10: PickerViewMonthButton!
    @IBOutlet weak var month11: PickerViewMonthButton!
    @IBOutlet weak var month12: PickerViewMonthButton!
    lazy var backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:)))
    var selectedMonth: Int = 1
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.setCornerRadius(radius: 12)
        
        let months: [PickerViewMonthButton] = [month01, month02, month03, month04, month05, month06, month07, month08, month09, month10, month11, month12]
        months[selectedMonth - 1].isClicked = true
        months.forEach { button in
            button.addTarget(self, action: #selector(clickMonthButton), for: .touchUpInside)
        }
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.closePickerView()
    }
    
    @objc private func clickMonthButton(_ sender: UIButton!) {
        dismiss(animated: false, completion: nil)
    }
    
    
    @objc private func didTapBackground(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
}

final class PickerViewMonthButton: UIButton {
    var isClicked: Bool = false {
        didSet {
            layer.borderWidth = isClicked ? 1 : 0
            layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.4941176471, blue: 0.2274509804, alpha: 1)
            titleLabel?.tintColor = isClicked ? #colorLiteral(red: 0.9411764706, green: 0.4941176471, blue: 0.2274509804, alpha: 1) : #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
            backgroundColor = isClicked ? #colorLiteral(red: 0.9921568627, green: 0.9490196078, blue: 0.9215686275, alpha: 1) : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonInit()
    }
    
    func buttonInit() {
        setCornerRadius(radius: 6)
        
        backgroundColor = isClicked ? #colorLiteral(red: 0.9921568627, green: 0.9490196078, blue: 0.9215686275, alpha: 1) : .white
        titleLabel?.tintColor = isClicked ? #colorLiteral(red: 0.9411764706, green: 0.4941176471, blue: 0.2274509804, alpha: 1) : #colorLiteral(red: 0.2823529412, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
    }
}
