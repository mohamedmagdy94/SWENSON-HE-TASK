//
//  CurrencyConverter.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

protocol CurrencyConverting {
    func convertAllCurrencies(baseCurrency: String)->GetCurrenciesResponse
    func convertCurrency(localCurrencyAmount: Double,foreignCurrencyAmount: Double)->Double
}
