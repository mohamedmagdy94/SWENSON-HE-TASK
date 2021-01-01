//
//  CurrencyTableViewCell.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    static var identifier = "CURRENCY_CELL"
    
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with viewModel: CurrencyCellViewModel){
        
        let svgImageSize = CGSize(width: 32, height: 32)
        currencyImageView.sd_setImage(with: URL(string: viewModel.currencyImageURL), placeholderImage: nil,context: [.imageThumbnailPixelSize : svgImageSize])
        currencyNameLabel.text = viewModel.currencyName
        currencyRateLabel.text = viewModel.currencyRate
        selectionStyle = .none
    }

}
