//
//  monthPickerView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/11/14.
//

import UIKit
import RxSwift

protocol MonthPickerViewControllerDelegate: AnyObject {
    func choose(year: Int, month: Int)
}
final class MonthPickerView: UIViewController {
    weak var delegate: MonthPickerViewControllerDelegate?
    
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
    var year: Int = 2021
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.setCornerRadius(radius: 12)
        
        let months: [PickerViewMonthButton] = [month01, month02, month03, month04, month05, month06, month07, month08, month09, month10, month11, month12]
        months[selectedMonth - 1].isClicked = true
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    #warning("collectionView로 만들기")
    @IBAction func clickMonth01(_ sender: Any) {
        delegate?.choose(year: year, month: 1)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth02(_ sender: Any) {
        delegate?.choose(year: year, month: 2)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth03(_ sender: Any) {
        delegate?.choose(year: year, month: 3)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth04(_ sender: Any) {
        delegate?.choose(year: year, month: 4)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth05(_ sender: Any) {
        delegate?.choose(year: year, month: 5)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth06(_ sender: Any) {
        delegate?.choose(year: year, month: 6)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth07(_ sender: Any) {
        delegate?.choose(year: year, month: 7)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth08(_ sender: Any) {
        delegate?.choose(year: year, month: 8)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth09(_ sender: Any) {
        delegate?.choose(year: year, month: 9)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth10(_ sender: Any) {
        delegate?.choose(year: year, month: 10)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth11(_ sender: Any) {
        delegate?.choose(year: year, month: 11)
        dismiss(animated: false, completion: nil)
    }
    @IBAction func clickMonth12(_ sender: Any) {
        delegate?.choose(year: year, month: 12)
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
