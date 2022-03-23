//
//  PieChartView.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 05.03.2022.
//

import Foundation
import UIKit

struct Item {
    let percent: Float
    let color: UIColor
    let message: String
}

struct ArcParameters {
    let startAngle: CGFloat
    let endAngle: CGFloat
    let minRadius: CGFloat
    let maxRadius: CGFloat
    let item: Item
}

class PieChart: UIView {
    private let path = UIBezierPath()
    private var items = [Item]() {
        didSet {
            validateItems(items: &items)
        }
    }
    private var itemsFrame = [ArcParameters]()
    private var arcs = [UIBezierPath]()
    private let maskLayer = CAShapeLayer()
    private var graphCenter: CGPoint = CGPoint(x: 0, y: 0)
    private var infoView: UIView?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, items: [Item]) {
        self.init(frame: frame)
        
        var newItems = items
        validateItems(items: &newItems)
        self.items = newItems
        self.backgroundColor = .clear
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
    
    // MARK: - Interactions
    @objc
    func panHappend(_ tap: UITapGestureRecognizer) {
//        let point = tap.location(in: self)
//        for item in itemsFrame {
//            if(arcContainsPoint(in: item, point: point)) {
//                showInfo(point: point, item: item.item)
//                break
//            } else {
//                infoView?.removeFromSuperview()
//            }
//        }
    }
    
    private func arcContainsPoint(in arc: ArcParameters, point: CGPoint) -> Bool {
        let distance = CGPointDistance(from: self.graphCenter, to: point)
        guard arc.maxRadius >= distance && arc.minRadius <= distance else { return false }

        let angle = angleToPoint(pointOnCircle: point)
        let startAngle = arc.startAngle
        let endAngle = arc.endAngle
        guard startAngle <= angle && endAngle >= angle else { return false }
        
        return true
    }
    
    private func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        let distance = (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
        
        return sqrt(distance)
    }
    
    private func angleToPoint(pointOnCircle: CGPoint) -> CGFloat {
        let originX = pointOnCircle.x - self.graphCenter.x
        let originY = pointOnCircle.y - self.graphCenter.y
        var radians = atan2(originY, originX)
            
        while radians < 0 {
            radians += CGFloat(2 * Double.pi)
        }
            
        return radians
    }
    
    private func showInfo(point: CGPoint, item: Item) {
        infoView?.removeFromSuperview()
        
        let label = UILabel()
        label.text = item.message
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 5, y: 5)
        
        let view = UIView(frame: CGRect(x: point.x , y: point.y, width: label.frame.width + 10, height: label.frame.height + 10))
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 4
        
        view.addSubview(label)
        view.frame.origin = point
        
        self.infoView = view
        
        self.addSubview(view)
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawPieChart()
    }
    
    private func drawPieChart() {
        maskLayer.removeFromSuperlayer()
        path.removeAllPoints()
        arcs.removeAll()
        itemsFrame.removeAll()
        
        self.graphCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startAngle: CGFloat = 0
        
        for item in items {
            let endAngle = (startAngle + CGFloat((2 * .pi) * item.percent))
            drawSegment(startAngle: startAngle, endAngle: endAngle, color: item.color, item: item)
            startAngle = endAngle
        }
        maskLayer.path = path.cgPath
        self.layer.addSublayer(maskLayer)
        maskLayer.fillColor = UIColor.clear.cgColor
    }
    
    private func drawSegment(
        startAngle: CGFloat,
        endAngle: CGFloat,
        color: UIColor,
        item: Item
    ) {
        let radius = self.bounds.height * 0.3
        let borderWidth = self.bounds.height * 0.2
        let arc = UIBezierPath(
            arcCenter: self.graphCenter,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        itemsFrame.append(ArcParameters(
            startAngle: startAngle,
            endAngle: endAngle,
            minRadius: radius,
            maxRadius: radius + borderWidth,
            item: item
        ))
        
        arc.lineWidth = borderWidth
        color.setStroke()
        arc.stroke()
        path.append(arc)
        arcs.append(arc)
    }
    
    // MARK: - API
    public func updateItems(items: [Item]) {
        self.items = items
        self.setNeedsDisplay()
    }
    
    public func touched(point: CGPoint, parentView: UIView) {
        let newPoint = parentView.convert(point, to: self)
        for item in itemsFrame {
            if(arcContainsPoint(in: item, point: newPoint)) {
                showInfo(point: newPoint, item: item.item)
                break
            } else {
                infoView?.removeFromSuperview()
            }
        }
    }
}
