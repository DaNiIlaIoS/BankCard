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
            //
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
        colorCollection = manager.getCollection(id: "colors", dataSource: self, delegate: self)
        colorCollection.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseId)
    }
}

extension ViewBuilder: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension ViewBuilder: UICollectionViewDelegate {
    
}
