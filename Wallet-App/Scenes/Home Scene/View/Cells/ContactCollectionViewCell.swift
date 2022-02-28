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
    
    private lazy var borderLayer: CAShapeLayer = {
        let border = CAShapeLayer()
        border.lineWidth = 2
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [3, 5]
        border.fillColor = nil
        
        return border
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
        
        borderLayer.removeFromSuperlayer()
    }
    
    //MARK: - UI setup
    private func setupView() {
        self.contentView.layer.cornerRadius = self.frame.width / 2
        self.contentView.backgroundColor = .clear
        self.contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        imageView.pin(to: contentView)
    }
    
    public func configureNormal(contact: HomeInfo.ShowInfo.ViewModel.DisplayedContact) {
        imageView.image = UIImage(named: contact.imageURL)
        imageView.contentMode = .scaleToFill
    }
    
    public func configureAdd() {
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.contentMode = .center
        
        borderLayer.frame = contentView.bounds
        borderLayer.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.addSublayer(borderLayer)
    }
}
