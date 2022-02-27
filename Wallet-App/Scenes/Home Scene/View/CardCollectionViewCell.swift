//
//  CardCollectionViewCell.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CardCollectionViewCell"
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .left
        
        return label
    }()
    
    private let endingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        
        return label
    }()
    
    private let balanceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Balance"
        label.textAlignment = .left
        
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "purpleGradient.jpg"))
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
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
        self.contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .purple
        contentView.addSubview(backgroundImage)
        contentView.layer.masksToBounds = true
        
        backgroundImage.pin(to: contentView, [.top, .left, .right, .bottom])
        
        let topSV = UIStackView(arrangedSubviews: [typeLabel, endingLabel])
        topSV.distribution = .fill
        topSV.alignment = .fill
        topSV.axis = .horizontal
        
        let balanceSV = UIStackView(arrangedSubviews: [balanceNameLabel, balanceLabel])
        balanceSV.distribution = .fill
        balanceSV.alignment = .fill
        balanceSV.axis = .vertical
        balanceSV.spacing = 8
        
        let mainSV = UIStackView(arrangedSubviews: [topSV, balanceSV])
        mainSV.distribution = .fill
        mainSV.alignment = .fill
        mainSV.axis = .vertical
        mainSV.spacing = 50
        
        contentView.addSubview(mainSV)
        mainSV.pin(to: contentView, [.left: 15, .right: 15, .top: 15, .bottom: 15])
    }
    
    public func configure(card: HomeInfo.ShowInfo.ViewModel.DisplayedCard) {
        typeLabel.text = card.type
        endingLabel.text = card.edningNumbers
        balanceLabel.text = card.balance
    }
}

// MARK: - Transformation
extension CardCollectionViewCell {
    public func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.contentView.alpha = 1
        }
    }
    
    public func transformBack() {
        UIView.animate(withDuration: 0.1) {
            self.contentView.alpha = 0.5
            self.transform = CGAffineTransform.identity
        }
    }
}
