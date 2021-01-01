//
//  CurrencyConverterDependencyInjector.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

protocol CurrencyConverterDependencyInjection {
    func resolve(foreignCurrency: String,currencyConverter: CurrencyConverting,view: CurrencyConvertViewController)->CurrencyConvertViewController
}

class CurrencyConverterDependencyInjector: CurrencyConverterDependencyInjection {
    func resolve(foreignCurrency: String, currencyConverter: CurrencyConverting, view: CurrencyConvertViewController) -> CurrencyConvertViewController {
        let viewModel = CurrencyConvertViewModel(foreignCurrency: foreignCurrency, currencyConverter: currencyConverter)
        view.viewModel = viewModel
        return view
    }
}


