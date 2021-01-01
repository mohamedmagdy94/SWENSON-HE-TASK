//
//  CountryRemoteDataSource.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol CountryDataSourceProtocol {
    func getCountries()->Observable<GetCounrtiesResponse>
}

class CountryRemoteDataSource: CountryDataSourceProtocol {
    private var networkRouter: MoyaProvider<CurrencySelectNetworkRouter>
    private var jsonTransformer: CodableTransforming
    
    init(networkRouter: MoyaProvider<CurrencySelectNetworkRouter>,jsonTransformer: CodableTransforming) {
        self.networkRouter = networkRouter
        self.jsonTransformer = jsonTransformer
    }
    
    func getCountries() -> Observable<GetCounrtiesResponse> {
        let requestObservable = networkRouter
            .rx
            .request(.getCounrties)
            .map {[weak self] (response) -> GetCounrtiesResponse in
                if response.statusCode == 200{
                    guard let responseModel = self?.mapResponseToModel(form: response.data) else{ throw CurrencySelectError.ServerError }
                    return responseModel
                }else{
                    throw CurrencySelectError.ServerError
                }
        }.asObservable()
        return requestObservable
    }
    
    private func mapResponseToModel(form data: Data)->GetCounrtiesResponse?{
        let responseModel = jsonTransformer.decodeObject(from: data, to: GetCounrtiesResponse.self)
        return responseModel
    }
    
}
