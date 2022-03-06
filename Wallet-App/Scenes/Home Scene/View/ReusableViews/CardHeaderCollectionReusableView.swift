//
//  CardHeaderCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

// remove
class CardHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "CardHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.text = "Cards"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .bottom
        
        return label
    }()
    
    private lazy var borderLayer: CAShapeLayer = {
        let border = CAShapeLayer()
        border.lineWidth = 2
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [3, 5]
        border.fillColor = nil

        return border
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.pinWidth(to: button.heightAnchor, 1)
        button.setHeight(to: 35)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        borderLayer.frame = addButton.bounds
        borderLayer.path = UIBezierPath(roundedRect: addButton.bounds, cornerRadius: addButton.layer.cornerRadius).cgPath
        addButton.layer.addSublayer(borderLayer)
    }
    
    // MARK: - UI setup
    private func setupView() {
        let sV = UIStackView(arrangedSubviews: [titleLabel, addButton])
        sV.distribution = .fill
        sV.alignment = .center
        sV.axis = .horizontal
        
        addSubview(sV)
        
        sV.pin(to: self)
    }
}
