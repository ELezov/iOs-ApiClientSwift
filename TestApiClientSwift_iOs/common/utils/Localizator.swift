//
//  Localizator.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 27.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "strings") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        guard let localizedString = localizableDictionary.value(forKey: string) as? String else {
            //localizableDictionary.valueForKey(string)?.valueForKey("value") as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        return localizedString
    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(string: self)
    }
}
