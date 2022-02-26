//
//  CardCollectionViewCell.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CardCollectionViewCell"
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setup
    private func setupView() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .purple
    }
    
    public func configure() {
        
    }
}
