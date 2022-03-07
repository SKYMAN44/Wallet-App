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
    private let stackedBar: StackedBarView
    private var heightConstraint: NSLayoutConstraint?
    private let tempItems = [Item(percent: 0.4, color: .cyan), Item(percent: 0.3, color: .orange), Item(percent: 0.2, color: .green)]
    
    // MARK: - Init
    override init(frame: CGRect) {
        pieChart = PieChart(frame: frame, items: tempItems)
        stackedBar = StackedBarView(frame: .zero, items: tempItems)
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(pieChart)
        addSubview(stackedBar)
        
        stackedBar.pin(to: self, [.left: 0, .right: 0, .top: 20, .bottom: 20])
        stackedBar.isHidden = true
        
        pieChart.pin(to: self)
        heightConstraint = self.setHeight(to: 300)
    }
    
    public func changeStyle(_ toCompact: Bool) {
        if toCompact {
            self.heightConstraint?.constant = 60
            UIView.animate(withDuration: 0.3) {
                self.pieChart.isHidden = true
                self.stackedBar.isHidden = false
                self.stackedBar.setNeedsDisplay()
            }
        } else {
            self.heightConstraint?.constant = 300
            self.pieChart.isHidden = false
            self.stackedBar.isHidden = true
        }
    }
    
}
