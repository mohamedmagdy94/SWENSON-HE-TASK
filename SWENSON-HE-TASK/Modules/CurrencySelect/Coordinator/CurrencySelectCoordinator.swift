//
//  CurrencySelectCoordinator.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

protocol CurrencySelectCoordinator: Coordinating {
    func navigateToCurrencyConverter(currencyConvertingService: CurrencyConverting,foreignCurrencyCode: String)
}
