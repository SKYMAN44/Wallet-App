//
//  ContactHeaderCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class ContactHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "ContactHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Send Money"
        label.textAlignment = .left
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        
        titleLabel.pinTop(to: self)
        titleLabel.pinLeft(to: self)
    }
}
