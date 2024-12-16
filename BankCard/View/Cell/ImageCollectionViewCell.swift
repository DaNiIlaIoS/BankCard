//
//  ImageCollectionViewCell.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    static let reuseId = "IconCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var checkmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isHidden = true
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
        addSubview(checkmarkImage)
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
            
            checkmarkImage.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImage.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkmarkImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func selectImage() {
        checkmarkImage.isHidden = false
    }
    
    func deselectImage() {
        checkmarkImage.isHidden = true
    }
}
