//
//  GetCounrtiesService.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

protocol GetCountriesManaging {
    var filteredCountries: GetCounrtiesResponse{get}
    func getCountries()->Observable<GetCounrtiesResponse>
    func filterCoutries(accpetedCountriesCodes: [String])-> GetCounrtiesResponse
}

class GetCounrtiesService: GetCountriesManaging{
    
    private var dataSource: CountryDataSourceProtocol
    private var countries: GetCounrtiesResponse
    var filteredCountries: GetCounrtiesResponse
    
    init(dataSource: CountryDataSourceProtocol) {
        self.dataSource = dataSource
        countries = [GetCounrtiesResponseElement]()
        filteredCountries = [GetCounrtiesResponseElement]()
    }
    
    func getCountries() -> Observable<GetCounrtiesResponse> {
        let getCountryObseravble =  dataSource
            .getCountries()
            .do(onNext: {[weak self] in self?.countries = $0})
        return getCountryObseravble
    }
    
    func filterCoutries(accpetedCountriesCodes: [String]) -> GetCounrtiesResponse {
        let filteredCountries = self.countries.filter{ accpetedCountriesCodes.contains($0.currencies[0].code ?? "") }
        self.filteredCountries = filteredCountries
        
        return filteredCountries
    }
    
}
