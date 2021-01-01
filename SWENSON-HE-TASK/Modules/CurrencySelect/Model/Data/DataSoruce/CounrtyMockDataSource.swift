//
//  CounrtyMockDataSource.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

class CounrtyMockDataSource: CountryDataSourceProtocol {
    
    func getCountries() -> Observable<GetCounrtiesResponse> {
        let url = Bundle.main.url(forResource: "MockCountriesResponse", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let jsonTransformer = CodableTransformer()
        let responseModel = jsonTransformer.decodeObject(from: jsonData, to: GetCounrtiesResponse.self)!
        return Observable.just(responseModel)
    }
    
    
}
