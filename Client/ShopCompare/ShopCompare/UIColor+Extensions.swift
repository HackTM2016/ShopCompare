//
//  UIColor+Extensions.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: UInt32, green: UInt32, blue: UInt32) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:UInt32) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func adjust(red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor{
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
    
    func hexString() -> String {
        let components = CGColorGetComponents(self.CGColor);
        
        let r = components[0];
        let g = components[1];
        let b = components[2];
        let a = components[3];
        
        return NSString(format:"%02lX%02lX%02lX%02lX",
                        lroundf(Float (a * 255)),
                        lroundf(Float (r * 255)),
                        lroundf(Float (g * 255)),
                        lroundf(Float (b * 255))) as String;
    }
    
    func isLight() -> Bool {
        let components = CGColorGetComponents(self.CGColor)
        let r = components[0] * 255
        let g = components[1] * 255
        let b = components[2] * 255
        
        // W3C algorithm for determining color brightness http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        let brightnesValue = (r * 299 + g * 587 + b * 114) / 1000
        return brightnesValue > 125
    }
}
