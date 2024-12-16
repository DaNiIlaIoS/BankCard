//
//  ViewBuilder.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class ViewBuilder: NSObject {
    private let manager = ViewManager.shared
    
    private let balance: Float = 9.999
    private let cardNumber = 1234
    
    private var card = UIView()
    
    private var colorCollection: UICollectionView!
    private var imageCollection: UICollectionView!
    
    var controller: UIViewController
    var view: UIView
    
    var cardColor: [String] = ["#16A085FF", "#003F32FF"] {
        willSet {
            if let colorView = view.viewWithTag(1) {
                colorView.layer.sublayers?.remove(at: 0)
                let gradien = manager.createGradient(colors: newValue)
                colorView.layer.insertSublayer(gradien, at: 0)
            }
        }
    }
    
    var cardImage: UIImage = .icon1 {
        willSet {
            //
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interFont(type: .bold, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func createTitle(title: String) {
        titleLabel.text = title
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func createCard() {
        card = manager.getCard(colors: cardColor, balance: balance, cardNumber: cardNumber, cardImage: cardImage)
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
        ])
    }
    
    func createColorCollection() {
        let title = CollectionLabel(title: "Select color")
        
        colorCollection = manager.getCollection(id: .colors, dataSource: self, delegate: self)
        colorCollection.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseId)
        
        view.addSubview(title)
        view.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 40),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            colorCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ViewBuilder: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case CollectionId.colors.rawValue: return manager.colors.count
        case CollectionId.images.rawValue: return manager.images.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case CollectionId.colors.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseId, for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            let colors = manager.colors[indexPath.item]
            cell.setColor(colors)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension ViewBuilder: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case CollectionId.colors.rawValue:
            let colors = manager.colors[indexPath.item]
            self.cardColor = colors
//        case CollectionId.images.rawValue: return manager.images.count
        default:
            return
        }

    }
}

enum CollectionId: String {
    case colors, images
}
