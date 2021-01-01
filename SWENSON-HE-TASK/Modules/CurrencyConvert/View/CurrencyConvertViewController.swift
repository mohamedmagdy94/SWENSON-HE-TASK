//
//  CurrencyConvertViewController.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class CurrencyConvertViewController: UIViewController {
    
    @IBOutlet var currencyValuesTextFeilds: [UITextField]!
    @IBOutlet var currencyTitlesLabels: [UILabel]!
    
    var viewModel: CurrencyConvertViewModeling?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    private func setupRx(){
        guard let viewModel = viewModel else{ return }
        viewModel
            .localCurrencyName
            .bind(to: currencyTitlesLabels[0].rx.text)
            .disposed(by: disposeBag)
        viewModel
            .foriegnCurrencyName
            .bind(to: currencyTitlesLabels[1].rx.text)
            .disposed(by: disposeBag)
        viewModel
            .localCurrencyValue
            .bind(to: currencyValuesTextFeilds[0].rx.text)
            .disposed(by: disposeBag)
        viewModel
            .foriegnCurrencyValue
            .bind(to: currencyValuesTextFeilds[1].rx.text)
            .disposed(by: disposeBag)
        currencyValuesTextFeilds[0]
            .rx
            .text
            .filterNil()
            .bind(to: viewModel.localCurrencyValue)
            .disposed(by: disposeBag)
        viewModel.getInitialRatio()
        
    }
    
    
}
