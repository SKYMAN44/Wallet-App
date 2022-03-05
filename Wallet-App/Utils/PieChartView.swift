//
//  PieChartView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 05.03.2022.
//

import Foundation
import UIKit

struct Item {
    let percent: CGFloat
    let color: UIColor
}

class PieChart: UIView {
    let path = UIBezierPath()
    private var items = [Item]()
    private var arcs = [UIBezierPath]()
    let maskLayer = CAShapeLayer()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, items: [Item]) {
        self.init(frame: frame)
        
        var newItems = items
        validateItems(items: &newItems)
        self.items = newItems
        
        let panG = UITapGestureRecognizer(target: self, action: #selector(panHappend(_:)))
        self.addGestureRecognizer(panG)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func validateItems(items: inout [Item]) {
        let sum = items.reduce(0) { $0 + $1.percent }
        if sum < 1 {
            items.append(Item(percent: 1 - sum, color: .gray))
        } else if sum > 1 {
            items.removeLast()
            validateItems(items: &items)
        }
    }
    
    //MARK: - Interactions
    @objc
    func panHappend(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: self)
        for (i, arc) in arcs.enumerated() {
            if arc.contains(point) {
                print(items[i].color)
            }
        }
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawPieChart()
    }
    
    private func drawPieChart() {
        maskLayer.removeFromSuperlayer()
        arcs.removeAll()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startAngle: CGFloat = 3 * .pi / 4
        
        for item in items {
            let endAngle = (startAngle + CGFloat((2 * .pi) * item.percent))
            drawSegment(startAngle: startAngle, endAngle: endAngle, center: center, color: item.color)
            startAngle = endAngle
        }
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(maskLayer)
    }
    
    private func drawSegment(
        startAngle: CGFloat,
        endAngle: CGFloat,
        center: CGPoint,
        color: UIColor
    ) {
        let arc = UIBezierPath(
          arcCenter: center,
          radius: self.bounds.height * 0.3,
          startAngle: startAngle,
          endAngle: endAngle,
          clockwise: true
        )
        
        arc.lineWidth = self.bounds.height * 0.2
        color.setStroke()
        arc.stroke()
        path.append(arc)
        arcs.append(arc)
    }
    
    
    public func updateItems(items: [Item]) {
        self.items = items
        drawPieChart()
    }
}
