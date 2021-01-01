//
//  CurrencySelectionViewController.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import SKCountryPicker
import RxGesture


class CurrencySelectionViewController: UIViewController {
    
    @IBOutlet weak var baseCountryView: UIView!
    @IBOutlet weak var selectedCurrencyImageView: UIImageView!
    @IBOutlet weak var selectedCurrencyNameLabel: UILabel!
    @IBOutlet weak var currenciesTableView: UITableView!
    
    var viewModel: CurrencySelectionViewModeling?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        setupUI()
        setupRx()
        viewModel?.getCurrencies()
    }
    private func setupUI(){
        currenciesTableView.tableFooterView = UIView()
        currenciesTableView.tableHeaderView = UIView()
    }
    
    private func setupRx(){
        guard let viewModel = viewModel else{ return }
        viewModel
            .currenctCurrencyImage
            .subscribe(onNext: {[weak self] (imageURL) in
                let svgImageSize = CGSize(width: 32, height: 32)
                self?.selectedCurrencyImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: nil,context: [.imageThumbnailPixelSize : svgImageSize])
            })
            .disposed(by: disposeBag)
        viewModel
            .currentCurrencyName
            .bind(to: selectedCurrencyNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel
            .currencies
            .bind(to: currenciesTableView.rx.items(cellIdentifier: CurrencyTableViewCell.identifier, cellType: CurrencyTableViewCell.self)) { (row, element, cell) in
                cell.config(with: element)
        }.disposed(by: disposeBag)
        self.currenciesTableView.rx.itemSelected.subscribe(onNext: {[weak self] (indexPath) in
            self?.viewModel?.onForeignCountrySelected(with: indexPath.row)
        })
            .disposed(by: disposeBag)
        viewModel
            .isLoading
            .subscribe(onNext: {[weak self] (loadingFlag) in
                if loadingFlag{
                    self?.showLoading()
                }else{
                    self?.hideLoading()
                }
            }).disposed(by: disposeBag)
        viewModel
            .onError
            .subscribe(onNext: {[weak self] (errorMessage) in
                self?.showError(with: errorMessage)
            }).disposed(by: disposeBag)
        viewModel
            .shouldShowCountryPicker
            .subscribe(onNext: {[weak self] (_) in
                self?.showCountryPicker()
            }).disposed(by: disposeBag)
        
        baseCountryView.rx
        .tapGesture()
        .when(.recognized)
        .subscribe(onNext: {[weak self] _ in
            self?.viewModel?.onRequestChangeBaseCountry()
        })
        .disposed(by: disposeBag)
    }
    
    private func showCountryPicker(){
       CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            guard let viewModel = self.viewModel else{ return }
            viewModel.onChangeBaseCountry(with: country.countryCode)
        }
        
    }
    
    
}
