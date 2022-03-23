//
//  StackedBarView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 07.03.2022.
//

import Foundation
import UIKit

class StackedBarView: UIView {
    private let path = UIBezierPath()
    private var items = [Item]()
    private var segments = [UIBezierPath]()
    private let maskLayer = CAShapeLayer()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, items: [Item]) {
        self.init(frame: frame)
        
        var newItems = items
        validateItems(items: &newItems)
        self.items = newItems
        
        self.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func validateItems(items: inout [Item]) {
        let sum = items.reduce(0) { $0 + $1.percent }
        if sum < 1 {
            items.append(Item(percent: 1 - sum, color: .systemGray6, message: "Undefined"))
        } else if sum > 1 {
            items.removeLast()
            validateItems(items: &items)
        }
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawStackedBar()
    }
    
    private func drawStackedBar() {
        maskLayer.removeFromSuperlayer()
        segments.removeAll()
        
        var startPoint = CGPoint(x: 0, y: 0)
        
        for item in items {
            let endPoint = CGPoint(x: startPoint.x + CGFloat(item.percent) * self.frame.width, y: 0)
            let width = endPoint.x - startPoint.x
            drawSegment(startPoint: startPoint, width: width, color: item.color)
            startPoint = endPoint
        }
        
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        
        let smoothMask = CAShapeLayer()
        smoothMask.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        
        self.layer.addSublayer(maskLayer)
        self.layer.mask = smoothMask
    }
    
    private func drawSegment(startPoint: CGPoint, width: CGFloat, color: UIColor) {
        let line = UIBezierPath(rect: CGRect(x: startPoint.x, y: startPoint.y, width: width, height: self.frame.height))
        color.setFill()
        line.fill()
        segments.append(line)
        path.append(line)
    }
    
    // MARK: - API
    public func updateItems(items: [Item]) {
        self.items = items
        self.setNeedsDisplay()
    }
}
