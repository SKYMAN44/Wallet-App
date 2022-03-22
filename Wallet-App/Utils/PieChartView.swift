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
    private let path = UIBezierPath()
    private var items = [Item]() {
        didSet {
            validateItems(items: &items)
        }
    }
    private var arcs = [UIBezierPath]()
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
            items.append(Item(percent: 1 - sum, color: .systemGray6))
        } else if sum > 1 {
            items.removeLast()
            validateItems(items: &items)
        }
    }
    
    // MARK: - Interactions
    @objc
    func panHappend(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: self)
        let pickedColor = self.colorOfPoint(point: point)
        for item in self.items {
            if(item.color == pickedColor) {
                print(item.percent)
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
        path.removeAllPoints()
        arcs.removeAll()
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startAngle: CGFloat = 3 * .pi / 4
        
        for item in items {
            let endAngle = (startAngle + CGFloat((2 * .pi) * item.percent))
            drawSegment(startAngle: startAngle, endAngle: endAngle, center: center, color: item.color)
            startAngle = endAngle
        }
        maskLayer.path = path.cgPath
        self.layer.addSublayer(maskLayer)
        maskLayer.fillColor = UIColor.clear.cgColor
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
    
    // MARK: - API
    public func updateItems(items: [Item]) {
        self.items = items
        self.setNeedsDisplay()
    }
}

extension UIView
{
    func colorOfPoint(point: CGPoint) -> UIColor
    {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
                
        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)
        let color: UIColor = UIColor(
            red: CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue: CGFloat(pixel[2]) / 255.0,
            alpha: CGFloat(pixel[3]) / 255.0
        )
                
        return color
    }
}
