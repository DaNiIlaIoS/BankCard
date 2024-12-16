//
//  ViewController.swift
//  BankCard
//
//  Created by Даниил Сивожелезов on 16.12.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var builder: ViewBuilder = {
        return ViewBuilder(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI () {
        view.backgroundColor = UIColor(hex: "#141414FF")
        
        builder.createTitle(title: "Design your virtual card")
        builder.createCard()
    }
}
