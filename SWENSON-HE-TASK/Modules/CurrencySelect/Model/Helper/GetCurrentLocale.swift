//
//  GetCurrentLocale.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

protocol GetCurrentLocaleManaging {
    func getCurrentLocale()->String
}

struct GetCurrentLocale: GetCurrentLocaleManaging{
    func getCurrentLocale() -> String {
        let locale = Locale.current
        return locale.regionCode == "USA" ? "USD" : (locale.regionCode ?? "USD")
    }
    
}
