//
//  UIViewController+Alerts.swift
//  TerraAppNew
//
//  Created by Тимур Ахметов on 28.07.2022.
//

import UIKit

extension UIViewController {
    
    //SimpleAlert
    
    func alertOkCancel(title: String, message: String?, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}

