//
//  StoryboardInstantiable.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String? { get }
}

extension StoryboardInstantiable {
    static var storyboardIdentifier: String? { return String(describing: Self.self) }
    static var storyboardBundle: Bundle? { return Bundle(for: Self.self as! AnyClass) }
    
    static func instantiateViewController() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        
        if let storyboardIdentifier = storyboardIdentifier {
            return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}

