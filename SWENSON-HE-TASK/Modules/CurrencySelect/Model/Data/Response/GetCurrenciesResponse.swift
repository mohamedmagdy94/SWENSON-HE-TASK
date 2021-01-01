//
//  GetCurrenciesResponse.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation

// MARK: - GetCurrenciesResponse
struct GetCurrenciesResponse: Codable {
    let success: Bool
    let timestamp: Int
    var base, date: String
    var rates: [String: Double]
}
