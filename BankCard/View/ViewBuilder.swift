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
        didSet {
            updateCardColor(value: cardColor)
            saveCard()
        }
    }
    
    var cardImage: String = "icon1" {
        didSet {
            updateCardImage(value: cardImage)
            saveCard()
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
        
        let defaults = UserDefaults.standard
        if let savedColors = defaults.array(forKey: "savedCardColor") as? [String] {
            self.cardColor = savedColors
        }
        if let savedImage = defaults.string(forKey: "savedCardImage") {
            self.cardImage = savedImage
        }
        
        super.init()
        self.setScrollView()
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interFont(type: .bold, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
        label.font = .interFont(type: .semiBold, size: 14)
        label.setLineHeight(lineHeight: 10)
        label.textColor = UIColor(hex: "#6F6F6FFF")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .interFont(type: .bold, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 10
        
        return button
    }()
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    
    func createCard() {
        card = manager.getCard(colors: cardColor,
                               balance: balance,
                               cardNumber: cardNumber,
                               cardImage: cardImage)
        contentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            card.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
        ])
    }
    
    func createColorCollection() {
        let title = CollectionLabel(title: "Select color")
        
        colorCollection = manager.getCollection(id: .colors, dataSource: self, delegate: self)
        colorCollection.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseId)
        
        contentView.addSubview(title)
        contentView.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 60),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            colorCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func createImageCollection() {
        let title = CollectionLabel(title: "Add shapes")
        
        imageCollection = manager.getCollection(id: .images, dataSource: self, delegate: self)
        imageCollection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseId)
        
        contentView.addSubview(title)
        contentView.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 50),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            imageCollection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    
    func setContinueButton() {
        contentView.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func saveCard() {
        // Сохранение значений в UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(cardColor, forKey: "savedCardColor")
        defaults.set(cardImage, forKey: "savedCardImage")
        
        // Можно добавить принт для проверки
        print("Card color and card image saved!")
    }
    
    private func updateCardColor(value: [String]) {
        if let colorView = view.viewWithTag(1) {
            colorView.layer.sublayers?.remove(at: 0)
            let gradien = manager.createGradient(colors: value)
            colorView.layer.insertSublayer(gradien, at: 0)
        }
    }
    
    private func updateCardImage(value: String) {
        if let imageView = view.viewWithTag(2) as? UIImageView {
            imageView.image = UIImage(named: value) ?? .icon1
        }
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
        case CollectionId.images.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseId, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            let image = manager.images[indexPath.item]
            cell.setImage(UIImage(named: image) ?? .icon1)
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
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell
            cell?.selectImage()
            
        case CollectionId.images.rawValue:
            let image = manager.images[indexPath.item]
            self.cardImage = image
            
            let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
            cell?.selectImage()
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case CollectionId.colors.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell
            cell?.deselectImage()
            
        case CollectionId.images.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
            cell?.deselectImage()
            
        default:
            return
        }
    }
}

enum CollectionId: String {
    case colors, images
}
