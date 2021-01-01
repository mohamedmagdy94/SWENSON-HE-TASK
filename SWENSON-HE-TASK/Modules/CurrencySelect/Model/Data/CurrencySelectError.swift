//
//  CurrencySelectError.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

enum CurrencySelectError: Error {
    case InternetError
    case ServerError
    
    var localizedDescription: String{
        switch self {
        case .InternetError:
            return "Internet Error"
        case .ServerError:
            return "Server Error"
        }
    }
}
