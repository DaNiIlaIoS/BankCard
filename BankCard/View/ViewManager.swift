//
//  ViewManager.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class ViewManager {
    static let shared = ViewManager()
    private init() { }
    
    let colors: [[String]] = [
        ["#16A085FF", "#003F32FF"],
        ["#9A00D1FF", "#45005DFF"],
        ["#FA6000FF", "#FAC6A6FF"],
        ["#DE0007FF", "#8A0004FF"],
        ["#2980B9FF", "#2771A1FF"],
        ["#E74C3CFF", "#93261BFF"],
    ]
    
    let images: [UIImage] = [.icon1, .icon2, .icon3, .icon4, .icon5, .icon6]
    
    func createGradient(frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 306, height: 175)), colors: [String]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.frame = frame
        gradient.colors = colors.map { UIColor(hex: $0)?.cgColor ?? UIColor.white.cgColor}
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = [0, 1]
        
        return gradient
    }
    
    func getCard(colors: [String], balance: Float, cardNumber: Int, cardImage: UIImage) -> UIView {
        
        let card: UIView = {
            let view = UIView()
            view.layer.addSublayer(createGradient(colors: colors))
            view.layer.cornerRadius = 30
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = cardImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.opacity = 0.32
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let balanceLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "$\(balance)"
            label.font = .interFont(type: .bold, size: 27)
            return label
        }()
        
        let numberLabel: UILabel = {
            let label = UILabel()
            label.text = "****\(cardNumber)"
            label.textColor = .white
            label.font = .interFont(type: .regular, size: 16)
            label.layer.opacity = 0.35
            return label
        }()
        
        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(balanceLabel)
            stack.addArrangedSubview(numberLabel)
            return stack
        }()
        
        card.addSubview(imageView)
        card.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            card.widthAnchor.constraint(equalToConstant: 306),
            card.heightAnchor.constraint(equalToConstant: 175),
            
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: 30),
            
            hStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            hStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            hStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30),
        ])
        
        return card
    }
    
        func getCollection(id: String, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
            
            let collection: UICollectionView = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
                layout.itemSize = CGSize(width: 62, height: 62)
                layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
                
                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                collectionView.restorationIdentifier = id
                collectionView.dataSource = dataSource
                collectionView.delegate = delegate
                
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
                return collectionView
            }()
            
            return collection
        }
}
