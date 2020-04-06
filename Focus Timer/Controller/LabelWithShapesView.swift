//
//  ConfigShapeLayer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class LabelWithShapesView: UIView {
    
    var label = UILabel()
    
    var shapeLayer = CAShapeLayer()
    
    var overShapeLayer = CAShapeLayer()
    
    var text: String = "" {
     didSet {
           label.text = text
     }
  }

  var foregroundColor = UIColor() {
     didSet {
        overShapeLayer.strokeColor = (foregroundColor as! CGColor)
     }
  }

    required init?(coder: NSCoder) {
           super.init(coder: coder)
           configShapeLayer(shapeLayer, color: #colorLiteral(red: 0.951142132, green: 0.951142132, blue: 0.951142132, alpha: 1).cgColor, strokeEnd: 1)
           configShapeLayer(overShapeLayer, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, strokeEnd: 0)
           commonInit()
       }
       
    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame, text: text)
        label.text = text
    }
    
    func commonInit() {
        layer.addSublayer(shapeLayer)
        layer.addSublayer(overShapeLayer)
        addSubview(label)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer, color: CGColor, strokeEnd: CGFloat) {
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 26.0
    shapeLayer.lineCap = .round
    shapeLayer.fillColor = nil
    shapeLayer.strokeEnd = strokeEnd
        
    }


    
    func configFrameShapeLayer(_ shapeLayer: CAShapeLayer) {
        
        let path = UIBezierPath(arcCenter: CGPoint(x: CGFloat(self.bounds.size.width / 2), y:  CGFloat(self.bounds.size.height / 2)),
                                radius: CGFloat(self.bounds.size.width / 2),
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
        
        label.text = "25:00"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 60)
        label.frame = self.bounds
        label.center = CGPoint(x: CGFloat(self.bounds.size.width / 2), y: CGFloat(self.bounds.size.height / 2))
        label.textAlignment = .center
  }
}
