//
//  CurrencyConvertCoordinator.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyConverterDataSource {
    var currencyConveter: CurrencyConverting{get set}
    var foreignCurrency: String{get set}
}
protocol CurrencyConvertCoordinating: Coordinating,CurrencyConverterDataSource {}


class CurrencyConvertCoordinator: CurrencyConvertCoordinating {
    var navigationController: UINavigationController
    var currencyConveter: CurrencyConverting
    var foreignCurrency: String
    
    init(navigationController: UINavigationController,currencyConveter: CurrencyConverting,foreignCurrency: String) {
        self.navigationController = navigationController
        self.currencyConveter = currencyConveter
        self.foreignCurrency = foreignCurrency
    }
    
    func start() {
        var view = UIViewController.create(storyboardName: StoryboardName.CurrencyConvert.rawValue, viewControllerID: ViewControllerIdentifier.CurrencyConvertViewController.rawValue) as! CurrencyConvertViewController
        let injector = CurrencyConverterDependencyInjector()
        view = injector.resolve(foreignCurrency: foreignCurrency, currencyConverter: currencyConveter, view: view)
        navigationController.pushViewController(view, animated: true)
    }
    
}
