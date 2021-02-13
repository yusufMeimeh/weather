//
//  Reusable.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation
import UIKit

protocol Reusable: class{
    static var identifier: String { get }
    static var nib: UINib { get }
    static var bundle : Bundle? { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
        
    }
    static var bundle: Bundle? {
        return Bundle(for: Self.self )
    }
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: bundle)
    }
}


extension UITableView{
    func register(reusable : Reusable.Type , estimated : CGFloat){
        register(reusable.nib, forCellReuseIdentifier: reusable.identifier)
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = estimated
    }
}


extension UICollectionView{
    func register(reusable : Reusable.Type){
        register(reusable.nib, forCellWithReuseIdentifier: reusable.identifier)
    }
}
