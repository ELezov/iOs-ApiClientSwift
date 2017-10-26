//
//  ColorExtension.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 26.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension UIColor {
    @nonobjc class var amberCardBlue: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 53.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var amberCardText: UIColor {
        return UIColor(red: 115.0 / 255.0, green: 117.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var amberCardSeparator: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 53.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var acWhiteTwo: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var acWhiteTwo50: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 0.5)
    }
    
    @nonobjc class var acWhiteTwo30: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 0.3)
    }
    
    @nonobjc class var acWhiteTwo0: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 0.0)
    }
    
    @nonobjc class var acBlack: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var acCharcoalGrey: UIColor {
        return UIColor(red: 56.0 / 255.0, green: 61.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var acCoolGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 145.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var acSlateGrey: UIColor {
        return UIColor(red: 100.0 / 255.0, green: 104.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var acWhiteThree: UIColor {
        return UIColor(white: 217.0 / 255.0, alpha: 1.0)
    }
}

// Text styles

extension UIFont {
    class func acCardNumberFont() -> UIFont? {
        return UIFont(name: "OpenSans", size: 24.0)
    }
    
    class func acH1Font() -> UIFont? {
        return UIFont(name: "YesevaOne", size: 21.0)
    }
    
    class func acSh2Font() -> UIFont? {
        return UIFont(name: "OpenSans-Semibold", size: 18.0)
    }
    
    class func acSh3Font() -> UIFont? {
        return UIFont(name: "OpenSans-Semibold", size: 18.0)
    }
    
    class func acContactsFont() -> UIFont? {
        return UIFont(name: "OpenSans", size: 18.0)
    }
    
    class func acH3Font() -> UIFont? {
        return UIFont(name: "OpenSans-Semibold", size: 17.0)
    }
    
    class func acTextStyleFont() -> UIFont? {
        return UIFont(name: "OpenSans", size: 16.0)
    }
}
