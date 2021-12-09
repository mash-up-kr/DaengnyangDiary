//
//  BaseViewModel.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/12/09.
//

import UIKit
import RxSwift

class BaseViewController<ViewModel>: UIViewController where ViewModel: BaseViewModelProtocol {
    let bag = DisposeBag()
    var viewModel: ViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.outputMapping()
        viewBinding()
        viewModelBinding()
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func viewBinding() {
        
    }
    
    func viewModelBinding() {
        
    }
}
