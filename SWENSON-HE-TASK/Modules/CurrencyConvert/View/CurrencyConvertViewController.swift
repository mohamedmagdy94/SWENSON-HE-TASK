//
//  CurrencyConvertViewController.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import UIKit

class CurrencyConvertViewController: UIViewController {

    @IBOutlet var currencyValuesTextFeilds: [UITextField]!
    @IBOutlet var currencyTitlesLabels: [UILabel]!
    
    var viewModel: CurrencyConvertViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
