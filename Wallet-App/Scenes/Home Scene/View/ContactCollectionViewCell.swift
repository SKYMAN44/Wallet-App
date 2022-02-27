//
//  ContactCollectionViewCell.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ContactCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        
        return button
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
        self.contentView.layer.cornerRadius = self.frame.width / 2
        self.contentView.backgroundColor = .cyan
        self.contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        imageView.pin(to: contentView)
    }
    
    public func configureNormal(contact: HomeInfo.ShowInfo.ViewModel.DisplayedContact) {
        
    }
    
    public func configureAdd() {
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.contentMode = .center
        self.contentView.backgroundColor = .clear
        let border = CAShapeLayer()
        border.lineWidth = 2
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [2, 5]
        border.frame = contentView.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.addSublayer(border)
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
