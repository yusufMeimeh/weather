//
//  BaseViewModel.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import Foundation

class BaseViewModel: NSObject {
    
    var errorMessage: String?{
        didSet{
            handelErrorMessage?(errorMessage)
        }
    }
    
    var reloadData: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    var handelErrorMessage: ((String?) -> Void)?

}

extension BaseViewModel{
     func handleAPIError(error : CustomError){
        switch error {
        case .string(let msg):
            self.errorMessage = msg
        case .other(let error):
            self.errorMessage = error?.localizedDescription
        }
    }
}
