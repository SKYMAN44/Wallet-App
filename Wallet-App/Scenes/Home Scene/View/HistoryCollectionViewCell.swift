//
//  HistoryCollectionViewCell.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 28.02.2022.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HistoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let recieverLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - UI setup
    private func setupView() {
        let textSV = UIStackView(arrangedSubviews: [recieverLabel, dateLabel])
        textSV.distribution = .fill
        textSV.alignment = .fill
        textSV.axis = .vertical
        textSV.spacing = 5
        
        let mainSV = UIStackView(arrangedSubviews: [imageView, textSV, amountLabel])
        mainSV.distribution = .fill
        mainSV.alignment = .fill
        mainSV.axis = .horizontal
        mainSV.spacing = 12
        
        contentView.addSubview(mainSV)
        
        mainSV.pin(to: contentView)
    }
    
    public func configure(expense: HomeInfo.ShowInfo.ViewModel.DisplayedHistory) {
        recieverLabel.text = expense.recieverName
        dateLabel.text = expense.date
        amountLabel.text = expense.amount
    }

}
