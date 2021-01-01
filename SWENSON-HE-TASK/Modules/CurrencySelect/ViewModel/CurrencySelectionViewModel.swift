//
//  CurrencySelectionViewModel.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencySelectionViewModeling {
    var currenctCurrencyImage: Observable<String>{get}
    var currentCurrencyName: Observable<String>{get}
    var currencies: Observable<[CurrencyCellViewModel]>{get}
    var shouldShowCountryPicker: Observable<Void>{get}
    var isLoading: Observable<Bool>{get}
    var onError: Observable<String>{get}
    var navigationDelegate: CurrencySelectCoordinating?{get set}
    
    func getCurrencies()
    func onForeignCountrySelected(with index: Int)
    func onChangeBaseCountry(with countryCode: String)
    func onRequestChangeBaseCountry()
}

class CurrencySelectionViewModel: CurrencySelectionViewModeling {
    
    var currenctCurrencyImage: Observable<String> {currenctCurrencyImageSubject.asObservable()}
    var currentCurrencyName: Observable<String>{ currentCurrencyNameSubject.asObservable() }
    var currencies: Observable<[CurrencyCellViewModel]> { currenciesSubject.asObservable() }
    var shouldShowCountryPicker: Observable<Void> { onRequestChangeBaseCountrySubject.asObservable() }
    var isLoading: Observable<Bool> { isLoadingSubject.asObservable() }
    var onError: Observable<String> { onErrorSubject.asObservable() }
    var onRequestChangeBaseCountrySubject: PublishSubject<Void>
    var navigationDelegate: CurrencySelectCoordinating?
    private var currenctCurrencyImageSubject: PublishSubject<String>
    private var currentCurrencyNameSubject: PublishSubject<String>
    private var currenciesSubject: PublishSubject<[CurrencyCellViewModel]>
    private var isLoadingSubject: PublishSubject<Bool>
    private var onErrorSubject: PublishSubject<String>
    private var getCountriesService: GetCountriesManaging
    private var getCurrenciesService: GetCurrenciesManaging
    private var currencyConverter: CurrencyConverting
    private var getCurrenCountryService: GetCurrentLocaleManaging
    private var disposeBag = DisposeBag()
    
    init(getCountriesService: GetCountriesManaging,getCurrenciesService: GetCurrenciesManaging,currencyConverter: CurrencyConverting,getCurrenCountryService: GetCurrentLocaleManaging) {
        onRequestChangeBaseCountrySubject = PublishSubject()
        currenctCurrencyImageSubject = PublishSubject()
        currentCurrencyNameSubject = PublishSubject()
        currenciesSubject = PublishSubject()
        isLoadingSubject = PublishSubject()
        onErrorSubject = PublishSubject()
        self.getCountriesService = getCountriesService
        self.getCurrenciesService = getCurrenciesService
        self.currencyConverter = currencyConverter
        self.getCurrenCountryService = getCurrenCountryService
    }
    
    func getCurrencies() {
        isLoadingSubject.onNext(true)
        Observable.zip(getCountriesService.getCountries(),getCurrenciesService.getCurrencies())
            .subscribe(onNext: handleResponse(with:), onError: handleError(with:))
            .disposed(by: disposeBag)
        
    }
    
    private func handleResponse(with response: (GetCounrtiesResponse,GetCurrenciesResponse)){
        
        isLoadingSubject.onNext(false)
        let currentCountryCode = getCurrenCountryService.getCurrentLocale()
        let currentCountry = response.0.last{ $0.currencies[0].code == currentCountryCode }!
        currenctCurrencyImageSubject.onNext(currentCountry.flag)
        currentCurrencyNameSubject.onNext(currentCountry.alpha3Code)
        let acceptedCountriesCodes = response.1.rates.map{ $0.key }
        let filteredCountries = getCountriesService.filterCoutries(accpetedCountriesCodes: acceptedCountriesCodes)
        currencyConverter.currencies = response.1
        currencyConverter.baseCurrency = currentCountry.currencies[0].code ?? "USD"
        let newRates = currencyConverter.currencies
        let cellViewModels = filteredCountries.map{ CurrencyCellViewModel(currencyImageURL: $0.flag, currencyName: $0.alpha3Code, currencyRate: "\(newRates!.rates[$0.currencies[0].code ?? ""] ?? 0.0)") }
        currenciesSubject.onNext(cellViewModels)
    }
    
    private func handleError(with error: Error){
        isLoadingSubject.onNext(false)
        guard let currencyError = error as? CurrencySelectError else{
            onErrorSubject.onNext(CurrencySelectError.InternetError.localizedDescription)
            return
        }
        onErrorSubject.onNext(currencyError.localizedDescription)
    }
    
    func onForeignCountrySelected(with index: Int) {
        let foreginCountryCode = getCountriesService.filteredCountries[index].currencies[0].code ?? "USD"
        navigationDelegate!.navigateToCurrencyConverter(currencyConvertingService: currencyConverter, foreignCurrencyCode: foreginCountryCode)
    }
    
    func onChangeBaseCountry(with countryCode: String) {
        handleBaseCountry(countryCode: countryCode)

    }
    
    private func handleBaseCountry(countryCode: String){
        let countryCodeUpperCased = countryCode.uppercased()
        guard let currentCountry = (getCountriesService.filteredCountries.first{ $0.alpha2Code == countryCodeUpperCased }) else{
            onErrorSubject.onNext("Country Not Available")
            return
        }
        currenctCurrencyImageSubject.onNext(currentCountry.flag)
        currentCurrencyNameSubject.onNext(currentCountry.alpha3Code)
        currencyConverter.baseCurrency = currentCountry.currencies[0].code ?? "USD"
        let newRates = currencyConverter.currencies
        let cellViewModels = getCountriesService.filteredCountries.map{ CurrencyCellViewModel(currencyImageURL: $0.flag, currencyName: $0.alpha3Code, currencyRate: "\(newRates!.rates[$0.currencies[0].code ?? ""] ?? 0.0)") }
        currenciesSubject.onNext(cellViewModels)
    }
    
    func onRequestChangeBaseCountry() {
        self.onRequestChangeBaseCountrySubject.onNext(())
    }
    
}
