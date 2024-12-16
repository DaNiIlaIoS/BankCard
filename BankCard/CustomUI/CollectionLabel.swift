//
//  CollectionLabel.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

final class CollectionLabel: UILabel {
    let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        createLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() {
        text = title
        textColor = .white
        font = .interFont(type: .bold, size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
