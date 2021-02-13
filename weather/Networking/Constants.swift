//
//  Constants.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/9/21.
//

import Foundation

struct Constants {
    
    static let apiKey = "8c4339abd5f1d1056002fde0e10b3be7"
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    
    struct Routs {
        static let weather = "/data/2.5/weather"
        static let forecast = "/data/2.5/forecast"
    }
    
    struct ParameterKeys {
        static let cityName = "q"
        static let appid = "appid"
    }
    
}
