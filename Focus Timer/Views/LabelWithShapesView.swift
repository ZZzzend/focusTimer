//
//  LabelWithShapesView.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class LabelWithShapesView: UIView {
    
    var label = UILabel()
    var shapeLayer = CAShapeLayer()
    var overShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        label.text = "00:00"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 60)
        
        configShapeLayer(shapeLayer, color: #colorLiteral(red: 0.951142132, green: 0.951142132, blue: 0.951142132, alpha: 1).cgColor, strokeEnd: 1)
        configShapeLayer(overShapeLayer, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, strokeEnd: 0)
        
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(shapeLayer)
        layer.addSublayer(overShapeLayer)
        addSubview(label)
    }
    
    private func configShapeLayer(_ shapeLayer: CAShapeLayer, color: CGColor, strokeEnd: CGFloat) {
        
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 26.0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = nil
        shapeLayer.strokeEnd = strokeEnd
    }
    
    private func configFrameShapeLayer(_ shapeLayer: CAShapeLayer) {
        
        let path = UIBezierPath(arcCenter: CGPoint(x: CGFloat(self.bounds.midX),
                                                   y:  CGFloat(self.bounds.midY)),
                                radius: CGFloat(self.bounds.midX),
                                startAngle: CGFloat(3 * Double.pi / 2),
                                endAngle: CGFloat(7 * Double.pi / 2),
                                clockwise: true)
        
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configFrameShapeLayer(shapeLayer)
        configFrameShapeLayer(overShapeLayer)
        
        label.frame = self.bounds
        label.center = CGPoint(x: CGFloat(self.bounds.midX),
                               y: CGFloat(self.bounds.midY))
        label.textAlignment = .center
    }
    
}
