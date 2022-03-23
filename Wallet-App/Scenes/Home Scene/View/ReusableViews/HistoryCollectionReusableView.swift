//
//  HistoryCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 28.02.2022.
//

import UIKit
import Foundation

class HistoryCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "HistoryCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "History"
        label.textAlignment = .left
        
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(nil, action: #selector(seeAllPressed), for: .touchUpInside)
        
        return button
    }()
    
    public var transitionClosure: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, seeAllButton])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        
        addSubview(stackView)
        
        stackView.pin(to: self)
    }
    
    @objc
    private func seeAllPressed() {
        if let transitionClosure = transitionClosure {
            transitionClosure()
        }
    }
}
