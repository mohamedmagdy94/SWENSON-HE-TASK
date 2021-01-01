//
//  CurrencySelectViewModelTests.swift
//  SWENSON-HE-TASKTests
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import XCTest
@testable import SWENSON_HE_TASK

class CurrencySelectViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testViewModel(){
        let loadingCurrenciesExpecation = expectation(description: "Loading currencies")

        let viewModel = CurrencySelectionViewModel(getCountriesService: GetCounrtiesService(dataSource: CounrtyMockDataSource()), getCurrenciesService: GetCurrenciesService(dataSource: CurrencyMockDataSource()), currencyConverter: CurrencyConverter(baseCurrency: "", currencies: nil), getCurrenCountryService: GetCurrentLocale())
        var currenciesCells = [CurrencyCellViewModel]()
        viewModel.currencies.subscribe(onNext: { (currencies) in
            currenciesCells = currencies
            loadingCurrenciesExpecation.fulfill()
        })
        viewModel.getCurrencies()
        waitForExpectations(timeout: 4)
        XCTAssert(currenciesCells.count > 0)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
