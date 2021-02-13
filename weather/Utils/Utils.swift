//
//  Utils.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation

class Utils {
    
    static let selectedCity = "selectedCity"
    
    static func setSelectedCity(city : City?){
        if let city = city{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(city),forKey: selectedCity)
        }
    }
    
    static func getSelectedCity() -> City?{
        if let selectedCity = UserDefaults.standard.value(forKey: selectedCity) as? Data {
            let city = try? PropertyListDecoder().decode(City.self,from: selectedCity)
            return city
        }
        return nil
    }

}
