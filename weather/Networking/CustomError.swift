//
//  CustomError.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/6/21.
//

import Foundation

public enum CustomError: Error {
    case other(error: Error?)
    case string(description: String)
}
