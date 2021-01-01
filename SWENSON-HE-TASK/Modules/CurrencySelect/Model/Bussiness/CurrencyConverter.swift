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
    func convertAllCurrencies()->GetCurrenciesResponse
    func convertCurrency(localCurrencyAmount: Double,foreignCurrencyAmount: Double)->Double
}
