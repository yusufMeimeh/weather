//
//  SearchViewModel.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation

class SearchViewModel : BaseViewModel {
    
    var cities : [City] = [City]()
    var filteredCities : [City] = [City](){
        didSet{
            reloadData?()
        }
    }
    var searchText : String?{
        didSet{
            filterCities()
        }
    }
    
    
    var numberOfItems : Int{
        filteredCities.count
    }
    
    func viewDidLoad(){
        
        Bundle.main.decode([City].self, from: "city.list.json"){ result in
            switch result{
            case.success(let objects):
                self.cities = objects
            case .failure(let error):
                self.handleAPIError(error: error)
            }
        }
        filteredCities = cities
    }
    
    func city(at index : Int) -> City{
        filteredCities[index]
    }
    
    private func filterCities(){
        if let searchText = searchText, !searchText.isEmpty{
            filteredCities = cities.filter({ (city) -> Bool in
                city.name.hasPrefix(searchText)
            })
        }else{
            filteredCities = cities
        }
        
        
    }
    
}
