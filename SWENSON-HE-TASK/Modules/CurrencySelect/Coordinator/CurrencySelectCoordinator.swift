//
//  CurrencySelectCoordinator.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencySelectCoordinating: Coordinating {
    func navigateToCurrencyConverter(currencyConvertingService: CurrencyConverting,foreignCurrencyCode: String)
}

class CurrencySelectCoordinator: CurrencySelectCoordinating {
        
    var navigationController: UINavigationController
    var dependencyIjector: CurrencySelectDependencyInjecting
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dependencyIjector = CurrencySelectDependencyInjector()
    }
    
    func navigateToCurrencyConverter(currencyConvertingService: CurrencyConverting, foreignCurrencyCode: String) {
        
    }
    
    func start() {
        var view = UIViewController.create(storyboardName: StoryboardName.CurrencySelection.rawValue, viewControllerID: ViewControllerIdentifier.CurrencySelectionViewController.rawValue) as! CurrencySelectionViewController
        let injector = CurrencySelectDependencyInjector()
        view = injector.resolve(view: view)
        view.viewModel?.navigationDelegate = self
        navigationController.pushViewController(view, animated: true)
    }
    
}
