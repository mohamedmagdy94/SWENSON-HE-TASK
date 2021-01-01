//
//  CurrencyMockDataSource.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

class CurrencyMockDataSource: CurrencyDataSourceProtocol {
    
    func getCurrencies() -> Observable<GetCurrenciesResponse> {
        let url = Bundle.main.url(forResource: "MockCurrenciesResponse", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url, options: NSData.ReadingOptions.mappedIfSafe)
        let jsonTransformer = CodableTransformer()
        let responseModel = jsonTransformer.decodeObject(from: jsonData, to: GetCurrenciesResponse.self)!
        return Observable.just(responseModel)

    }
    
}
