//
//  CurrencySelectNetworkRouter.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import Moya

enum CurrencySelectNetworkRouter {
    case getCounrties
    case getCurrencies(request: GetCurrenciesRequest)
}

extension CurrencySelectNetworkRouter: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        switch self {
        case .getCounrties:
            return URL(string: APIConstant.COUNTRY_API_BASE_URL.rawValue)!
        case .getCurrencies:
            return URL(string: APIConstant.CURRENCY_API_BASE_URL.rawValue)!
        }
        
    }
    
    var path: String {
        switch self {
        case .getCounrties:
            return "all"
        case .getCurrencies:
            return "latest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCounrties,.getCurrencies:
            return .get
        }
    }
    
    var task: Task {
         switch self {
         case .getCounrties:
            return .requestPlain
         case .getCurrencies(let request):
            return .requestParameters(parameters: request.dictionary!, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
    

