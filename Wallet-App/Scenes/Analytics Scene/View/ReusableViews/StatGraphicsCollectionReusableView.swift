//
//  StatGraphicsCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 06.03.2022.
//

import UIKit

class StatGraphicsCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "StatGraphicsCollectionReusableView"
    
    private let pieChart: PieChart
    
    // MARK: - Init
    override init(frame: CGRect) {
        pieChart = PieChart(frame: frame, items: [Item(percent: 0.4, color: .cyan), Item(percent: 0.3, color: .orange), Item(percent: 0.2, color: .green)])
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(pieChart)
        
        pieChart.pin(to: self)
    }
}
