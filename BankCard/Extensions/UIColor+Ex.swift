//
//  UIColor+Ex.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let startIndex = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[startIndex...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexValue: Int64 = 0
                
                if scanner.scanHexInt64(&hexValue) {
                    r = CGFloat((hexValue & 0xff000000) >> 24) / 255
                    g = CGFloat((hexValue & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexValue & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexValue & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
