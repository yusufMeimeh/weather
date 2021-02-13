//
//  HomeViewModel.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation

struct ListGroup {
    let day : String
    let list : [List]
}

class HomeViewModel: BaseViewModel {
    
    var serverObject : ForecastResponse?
    var localObject : ForecastResponse?
    var displayedObject :ForecastResponse?
    
    var isFromLocalFile = false{
        didSet{
            if isFromLocalFile{
                Bundle.main.decode(ForecastResponse.self, from: "london.json"){ result in
                    switch result{
                    case.success(let object):
                        self.localObject = object
                        self.handleResponse(self.localObject)
                    case .failure(let error):
                        self.handleAPIError(error: error)
                    }
                }
            }else{
                displayedObject = nil
                groups.removeAll()
                reloadData?()
                if let object = serverObject{
                    handleResponse(object)
                }else{
                    getForecast()
                }
            }
        }
    }
    
    var groups = [ListGroup](){
        didSet{
            reloadData?()
        }
    }
    
    var numberOfItems : Int{
        groups.count
    }
    
    func group ( at index : Int) -> ListGroup{
        groups[index]
    }
    
    func getForecast(){
        guard let city = Utils.getSelectedCity() else {
            errorMessage = "Please select city first"
            return
        }
        showLoading?(true)
        API.makeGetRequest(with: Constants.Routs.forecast, responseType: ForecastResponse.self , params: [Constants.ParameterKeys.cityName:city.name]) { (result) in
            self.showLoading?(false)
            switch result{
            case .success(let model):
                print(model)
                self.serverObject = model
                self.handleResponse(model)
            case .failure(let error):
                self.handleAPIError(error: error)
            }
        }
    }
    
    private func handleResponse(_ object : ForecastResponse?){
        self.displayedObject = object
        if let object = object{
            groupItems(object: object)
        }
    }
    
    func groupItems(object : ForecastResponse) {
        var newGroups = [ListGroup]()
        
        let g = object.list.reduce(into: [String: [List]]()) { result, value in
            result[value.formattedDate, default: []].append(value)
        }
        
        let sorted = g.sorted { $0.key < $1.key }

        for (key,value) in sorted {
            let object = ListGroup(day: key, list: value)
            newGroups.append(object)
        }
        
        groups = newGroups
    }
}
