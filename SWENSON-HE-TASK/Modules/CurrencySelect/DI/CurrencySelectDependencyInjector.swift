//
//  CurrencySelectDependencyInjector.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import UIKit
import Moya

protocol CurrencySelectDependencyInjecting {
    func resolve(view: CurrencySelectionViewController)->CurrencySelectionViewController
}

struct CurrencySelectDependencyInjector: CurrencySelectDependencyInjecting{
    
    func resolve(view: CurrencySelectionViewController) -> CurrencySelectionViewController {
        let countryRemoteDataSource = CountryRemoteDataSource(networkRouter: MoyaProvider<CurrencySelectNetworkRouter>(plugins: [NetworkLoggerPlugin()]), jsonTransformer: CodableTransformer())
        let currenenciesRemoteDataSource = CurrencyRemoteDataSource(networkRouter: MoyaProvider<CurrencySelectNetworkRouter>(plugins: [NetworkLoggerPlugin()]), jsonTransformer: CodableTransformer())
        let viewModel = CurrencySelectionViewModel(getCountriesService: GetCounrtiesService(dataSource: countryRemoteDataSource), getCurrenciesService: GetCurrenciesService(dataSource: currenenciesRemoteDataSource), currencyConverter: CurrencyConverter(baseCurrency: "", currencies: nil), getCurrenCountryService: GetCurrentLocale())
        view.viewModel = viewModel
        return view
    }
    
    
}
