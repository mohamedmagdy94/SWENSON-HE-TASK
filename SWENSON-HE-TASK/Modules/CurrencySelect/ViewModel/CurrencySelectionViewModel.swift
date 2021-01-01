//
//  CurrencySelectionViewModel.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencySelectionViewModeling {
    var currenctCurrencyImage: Observable<String>{get}
    var currentCurrencyName: Observable<String>{get}
    var currencies: Observable<[CurrencyCellViewModel]>{get}
    var selectedCurrencyIndex: Variable<Int>{get}
    var shouldShowCountryPicker: Observable<Void>{get}
    var onRequestChangeBaseCountry: Variable<Void>{get}
    var selectedBaseCountry: Variable<String>{get}
    var isLoading: Observable<Bool>{get}
    var onError: Observable<String>{get}
    
}
