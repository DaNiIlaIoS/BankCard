//
//  IconCollectionViewCell.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class IconCollectionViewCell: UICollectionViewCell {
    static let reuseId = "IconCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(imageView)
        backgroundColor = UIColor(hex: "#1F1F1FFF")
        layer.cornerRadius = 12
        clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
        ])
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
