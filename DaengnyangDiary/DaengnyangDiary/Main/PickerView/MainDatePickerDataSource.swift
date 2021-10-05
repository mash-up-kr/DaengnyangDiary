//
//  SamplePickerDataSource.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

class MainDatePickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let yearList: [String] = {
        let calendar = Calendar.current
        let count: Int = calendar.component(.year, from: Date()) - 2000 + 1
        var yearList: [String] = []
        for i in 0..<count {
            yearList.append("\(2000 + i)")
        }
        return yearList
    }()
    
    let selectedName = PublishSubject<String>()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = yearList[row]
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = yearList[row]
        selectedName.onNext(name)
    }
    
}
