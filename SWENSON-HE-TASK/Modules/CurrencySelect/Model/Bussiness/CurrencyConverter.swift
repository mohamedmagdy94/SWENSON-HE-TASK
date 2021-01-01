//
//  CurrencyConverter.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

protocol CurrencyConverting {
    var baseCurrency: String{get set}
    var currencies: GetCurrenciesResponse{get set}
    func convertCurrency(localCurrencyAmount: Double,foreginCurrency: String)->Double
}

class CurrencyConverter: CurrencyConverting {
    var baseCurrency: String{
        didSet{
            convertAllCurrenciesAfterBaseCurrencyUpdate()
        }
    }
    var currencies: GetCurrenciesResponse
    
    init(baseCurrency: String,currencies: GetCurrenciesResponse) {
        self.baseCurrency = baseCurrency
        self.currencies = currencies
    }
    
    
    func convertCurrency(localCurrencyAmount: Double,foreginCurrency: String) -> Double {
        let baseCurrencyRate = currencies.rates.first{[weak self] in $0.key == self?.baseCurrency }?.value ?? 0.0
        let foreignCurrencyRate = currencies.rates.first{ $0.key == foreginCurrency }?.value ?? 0.0
        let targetValue = baseCurrencyRate * foreignCurrencyRate
        return targetValue
        
    }
    
    private func convertAllCurrenciesAfterBaseCurrencyUpdate(){
        self.currencies.base = baseCurrency
        let newBaseCurrencyRate = currencies.rates.first{[weak self] in $0.key == self?.baseCurrency }?.value ?? 0.0
        var newRatesAfterUpateBaseCurrency = [String:Double]()
        self.currencies.rates.forEach { (rate) in
            var newRate = rate
            newRate.value = (1/newRate.value) * newBaseCurrencyRate
            newRatesAfterUpateBaseCurrency[newRate.key] = newRate.value
        }
        self.currencies.rates = newRatesAfterUpateBaseCurrency
    }
    
    
}
