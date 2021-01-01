//
//  GetCurrenciesService.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

protocol GetCurrenciesManaging {
    func getCurrencies()->Observable<GetCurrenciesResponse>
}

struct GetCurrenciesService: GetCurrenciesManaging {
    private var dataSource: CurrencyDataSourceProtocol
    
    init(dataSource: CurrencyDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getCurrencies() -> Observable<GetCurrenciesResponse> {
        let getCurrenciesObservable = dataSource.getCurrencies()
        return getCurrenciesObservable
    }
    
    
}

