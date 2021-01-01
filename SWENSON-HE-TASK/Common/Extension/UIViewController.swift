//
//  UIViewController.swift
//  SWENSON-HE-TASK
//
//  Created by Mohamed El-Taweel on 1/1/21.
//  Copyright © 2021 SWENSON-HE. All rights reserved.
//

import Foundation
import KRProgressHUD

protocol BaseViewProtocol {
    func showLoading()
    func hideLoading()
    func showError(with message: String?)
    func showSuccess(with message: String?)
}

extension UIViewController: BaseViewProtocol {
    
    func showLoading() {
        KRProgressHUD.show()
    }
    
    func hideLoading() {
        KRProgressHUD.dismiss()
    }
    
    func showError(with message: String?) {
        KRProgressHUD.showError(withMessage: message)
    }
    
    func showSuccess(with message: String?) {
        KRProgressHUD.showSuccess(withMessage: message)
    }
    
    static func create(storyboardName: String,viewControllerID: String)->UIViewController?{
        let targetStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationVC = targetStoryboard.instantiateViewController(withIdentifier: viewControllerID)
        return destinationVC
    }
}
