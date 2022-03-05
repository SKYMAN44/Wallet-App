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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, items: [Item]) {
        self.init(frame: frame)
        
        self.items = items
        
        let panG = UITapGestureRecognizer(target: self, action: #selector(panHappend(_:)))
        self.addGestureRecognizer(panG)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func panHappend(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: self)
        for (i, arc) in arcs.enumerated() {
            if arc.contains(point) {
                print(items[i].color)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let maskLayer = CAShapeLayer()
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startAngle: CGFloat = 3 * .pi / 4
        
        drawSegment(startAngle: startAngle, endAngle: startAngle + (2 * .pi), center: center, color: .black)
        
        for item in items {
            let endAngle = (startAngle + CGFloat((2 * .pi) * item.percent))
            endAngle
            drawSegment(startAngle: startAngle, endAngle: endAngle, center: center, color: item.color)
            startAngle = endAngle
        }
        maskLayer.path = path.cgPath
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
          radius: self.bounds.width / 3,
          startAngle: startAngle,
          endAngle: endAngle,
          clockwise: true
        )
        
        arc.lineWidth = self.bounds.width / 3
        color.setStroke()
        arc.stroke()
        
        path.append(arc)
        arcs.append(arc)
    }
}
