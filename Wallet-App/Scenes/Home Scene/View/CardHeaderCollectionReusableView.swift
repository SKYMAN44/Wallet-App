//
//  CardHeaderCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class CardHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "CardHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.text = "Cards"
        label.textAlignment = .left
        
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.dashed"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.pinWidth(to: button.heightAnchor)
        button.tintColor = .black
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let sV = UIStackView(arrangedSubviews: [titleLabel, addButton])
        sV.distribution = .fill
        sV.alignment = .fill
        sV.axis = .horizontal
        
        addSubview(sV)
        
        sV.pin(to: self)
    }
}
