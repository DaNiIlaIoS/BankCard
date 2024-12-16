//
//  FontManager.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

enum Inter: String {
    case regular = "Inter-Regular"
    case semiBold = "Inter-Regular_SemiBold"
    case bold = "Inter-Regular_Bold"
    case black = "Inter-Regular_Black"
}

extension UIFont {
    static func interFont(type: Inter, size: CGFloat) -> UIFont {
        .init(name: type.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
