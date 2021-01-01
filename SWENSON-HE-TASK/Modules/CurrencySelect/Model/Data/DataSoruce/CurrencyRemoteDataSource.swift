//
//  CurrencyRemoteDataSource.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol CurrencyDataSourceProtocol {
    func getCurrencies()->Observable<GetCurrenciesResponse>
}

class CurrencyRemoteDataSource: CurrencyDataSourceProtocol {
    private var networkRouter: MoyaProvider<CurrencySelectNetworkRouter>
    private var jsonTransformer: CodableTransforming
    
    init(networkRouter: MoyaProvider<CurrencySelectNetworkRouter>,jsonTransformer: CodableTransforming) {
        self.networkRouter = networkRouter
        self.jsonTransformer = jsonTransformer
    }
    
    func getCurrencies() -> Observable<GetCurrenciesResponse> {
        let request = GetCurrenciesRequest(access_key: APIConstant.CURRENCY_API_KEY.rawValue)
        let requestObservable = networkRouter
            .rx
            .request(.getCurrencies(request: request))
            .map {[weak self] (response) -> GetCurrenciesResponse in
                if response.statusCode == 200{
                    guard let responseModel = self?.mapResponseToModel(form: response.data) else{ throw CurrencySelectError.ServerError }
                    return responseModel
                }else{
                    throw CurrencySelectError.ServerError
                }
        }.asObservable()
        return requestObservable
    }
    
    private func mapResponseToModel(form data: Data)->GetCurrenciesResponse?{
        let responseModel = jsonTransformer.decodeObject(from: data, to: GetCurrenciesResponse.self)
        return responseModel
    }
    
}
