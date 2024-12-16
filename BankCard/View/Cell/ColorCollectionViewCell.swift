//
//  ColorCollectionViewCell.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    static let reuseId = "ColorCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(_ colors: [String]) {
        let gradient = ViewManager.shared.createGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        layer.addSublayer(gradient)
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
