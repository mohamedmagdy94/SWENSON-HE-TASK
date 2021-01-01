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
    func getCountries()->Observable<GetCounrtiesResponse>
}