//
//  SearchBarExtentions.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import UIKit

extension UISearchBar {
    
    private func searchBarIsEmpty() -> Bool {
        return text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return !searchBarIsEmpty()
    }
}

