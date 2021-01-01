//
//  AppCoordinator.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinating {

    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let currencySelectCoordinator = CurrencySelectCoordinator(navigationController: navigationController)
        currencySelectCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    

}
