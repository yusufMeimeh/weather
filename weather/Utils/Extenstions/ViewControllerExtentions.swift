//
//  ViewControllerExtentions.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import UIKit

extension UIViewController{
    
     func showAlert(with title : String , message : String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
