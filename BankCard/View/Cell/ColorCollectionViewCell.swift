//
//  ColorCollectionViewCell.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    static let reuseId = "ColorCollectionViewCell"
    
    private lazy var checkmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setColor(_ colors: [String]) {
        let gradient = ViewManager.shared.createGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        layer.addSublayer(gradient)
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(checkmarkImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkmarkImage.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImage.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkmarkImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func selectImage() {
        checkmarkImage.isHidden = false
    }
    
    func deselectImage() {
        checkmarkImage.isHidden = true
    }
}
