//
//  ViewControllerExtension.swift
//  VacunAccion
//
//  Created by praxis on 13/12/17.
//  Copyright © 2017 Carlos Slim Salud. All rights reserved.
//

import UIKit

extension UIViewController{
    
    /// Dismiss KeyBoard
    func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    /// Show basic alert
    ///
    /// - Parameters:
    ///   - title: String
    ///   - message: String
    ///   - textButton: String
    func showBasicAlert(title:String?,message:String?,textButton:String?){
        let alert:UIAlertController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction(title: textButton ?? "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Dismiss view
    ///
    /// - Parameter sender: Any
    @IBAction func dismissView(_ sender:Any){
        self.dismissKeyBoard()
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Change title
    ///
    /// - Parameter title: Title back button
    func changeTitleBackButton(title:String?){
        let backItem = UIBarButtonItem()
        backItem.title = title ?? ""
        navigationItem.backBarButtonItem = backItem
    }
    
}
