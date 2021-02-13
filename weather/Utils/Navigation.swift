//
//  Navigation.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation
import UIKit

class Navigation{
    
    static func showPicker(from : UIViewController ,selectedCity : City?  , handler:@escaping ((City?)->Void)){
        
        let vc = SearchViewController.instantiateViewController()
        vc.selectedCity = selectedCity
        vc.handler = handler
        let nav = UINavigationController.init(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = false
        nav.modalPresentationStyle = .overFullScreen
        nav.modalTransitionStyle = .coverVertical
        from.present(nav, animated: true, completion: nil)
    }
}
