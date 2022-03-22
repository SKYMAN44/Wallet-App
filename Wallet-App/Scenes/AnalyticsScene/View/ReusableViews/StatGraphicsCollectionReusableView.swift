//
//  StatGraphicsCollectionReusableView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 06.03.2022.
//

import UIKit

class StatGraphicsCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "StatGraphicsCollectionReusableView"
    
    private var itemsToShow = [Item]()
    static private var oldBalance: Double = 0
    private var newBalance: Double = 0
    private let pieChart: PieChart
    private let stackedBar: StackedBarView
    private let spendingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        
        return label
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    private var barTopConstraintToSuperView: NSLayoutConstraint?
    private var barTopConstraintToLabel: NSLayoutConstraint?
    private var isAnimating: Bool = false
    private var isCompact: Bool = false
    private var animationStart = Date()
    private var animationDuration = 1.5
    
    // MARK: - Init
    override init(frame: CGRect) {
        pieChart = PieChart(frame: .zero, items: itemsToShow)
        stackedBar = StackedBarView(frame: .zero, items: itemsToShow)
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabelText() {
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc
    private func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStart)
        
        if elapsedTime > animationDuration {
            self.spendingsLabel.text = "$ \(newBalance)"
            StatGraphicsCollectionReusableView.oldBalance = newBalance
            
        } else {
            let percentage = elapsedTime / animationDuration
            let value = StatGraphicsCollectionReusableView.oldBalance + percentage * (newBalance - StatGraphicsCollectionReusableView.oldBalance)
            self.spendingsLabel.text = "$ \(value.rounded())"
        }
    }
    
    // MARK: - UI setup
    private func setupView() {
        addSubview(pieChart)
        addSubview(stackedBar)
        addSubview(spendingsLabel)
        
        spendingsLabel.pin(to: self, [.bottom: 10, .right: 0, .left: 0])
        
        barTopConstraintToSuperView = stackedBar.pinTop(to: self.topAnchor, 20)
        
        stackedBar.pin(to: self, [.left: 0, .right: 0])
        stackedBar.setHeight(to: 20)
        stackedBar.alpha = 0
        
        pieChart.pin(to: self, [.left: 0 , .right: 0, .top: 20])
        pieChart.setHeight(to: 250)
        
        heightConstraint = self.setHeight(to: 300)
    }
    
    
    // MARK: - API
    public func changeStyle(_ toCompact: Bool, updateCollectionView: () -> ())
    {
        guard !isAnimating else { return }
        
        if toCompact && !isCompact {
            isAnimating = true
            self.heightConstraint?.constant = 90
            UIView.animate(withDuration: 0.25) {
                self.pieChart.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.pieChart.alpha = 0
            }
            UIView.animate(withDuration: 0.25, delay: 0.05, animations: {
                self.stackedBar.alpha = 1
                self.spendingsLabel.textAlignment = .right
            }) { _ in
                self.isAnimating = false
                self.isCompact = true
            }
            updateCollectionView()
        } else if !toCompact && isCompact {
            isAnimating = true
            self.heightConstraint?.constant = 300
            UIView.animate(withDuration: 0.2, animations: {
                self.stackedBar.alpha = 0
            })
            UIView.animate(withDuration: 0.25, delay: 0.2, animations: {
                self.pieChart.transform = .identity
                self.pieChart.alpha = 1
                self.spendingsLabel.textAlignment = .center
            }) { _ in
                self.isAnimating = false
                self.isCompact = false
            }
            updateCollectionView()
        }
    }
    
    public func setData(data: AnalyticsInfo.ShowInfo.ViewModel.GraphStatistics) {
        self.itemsToShow = data.sectors.map {
            return Item(percent: $0.percentage, color: $0.color)
        }
        newBalance = data.totalSum
        animationStart = Date()
        setLabelText()
        
        self.pieChart.updateItems(items: self.itemsToShow)
        self.stackedBar.updateItems(items: self.itemsToShow)
        self.setNeedsLayout()
    }
    
}
