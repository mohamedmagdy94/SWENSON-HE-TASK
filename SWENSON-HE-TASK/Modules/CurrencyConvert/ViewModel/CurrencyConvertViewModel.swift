//
//  CurrencyConvertViewModel.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencyConvertViewModeling {
    var localCurrencyName: Observable<String>{get}
    var localCurrencyValue: BehaviorSubject<String>{get}
    var foriegnCurrencyName: Observable<String>{get}
    var foriegnCurrencyValue: BehaviorSubject<String>{get}
    
    func getInitialRatio()
}

class CurrencyConvertViewModel: CurrencyConvertViewModeling{
    var localCurrencyName: Observable<String>{ localCurrencyNameSubject.asObservable() }
    var localCurrencyValue: BehaviorSubject<String>
    var foriegnCurrencyName: Observable<String>{ foreignCurrencyNameSubject.asObservable() }
    var foriegnCurrencyValue: BehaviorSubject<String>
    private var localCurrencyNameSubject: PublishSubject<String>
    private var foreignCurrencyNameSubject: PublishSubject<String>
    private var foreignCurrency: String
    private var currencyConverter: CurrencyConverting
    private var disposeBag = DisposeBag()
    private var navigationDelegate: CurrencyConvertCoordinating?
    
    init(foreignCurrency: String,currencyConverter: CurrencyConverting) {
        self.foreignCurrency = foreignCurrency
        self.currencyConverter = currencyConverter
        self.localCurrencyValue = BehaviorSubject(value: "0.0")
        self.foriegnCurrencyValue = BehaviorSubject(value: "0.0")
        self.foreignCurrencyNameSubject = PublishSubject()
        self.localCurrencyNameSubject = PublishSubject()
        observeLocalCurrencyValue()
    }
    
    func getInitialRatio() {
        foreignCurrencyNameSubject.onNext(foreignCurrency)
        localCurrencyNameSubject.onNext(currencyConverter.baseCurrency)
        localCurrencyValue.onNext("1.0")
        let foreginCurrencyValue = currencyConverter.convertCurrency(localCurrencyAmount: 1.0, foreginCurrency: foreignCurrency)
        
        self.foriegnCurrencyValue.onNext("\(foreginCurrencyValue)")
    }
    
    private func observeLocalCurrencyValue(){
        self
            .localCurrencyValue
            .map{ Double($0) ?? 0.0 }
            .subscribe(onNext: {[weak self] (newValue) in
                let foreginCurrencyValue = self?.currencyConverter.convertCurrency(localCurrencyAmount: newValue, foreginCurrency: self?.foreignCurrency ?? "USD")
                self?.foriegnCurrencyValue.onNext("\(foreginCurrencyValue ?? 0.0)")
            }).disposed(by: disposeBag)
    }
    
}
