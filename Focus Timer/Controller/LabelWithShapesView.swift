//
//  ConfigShapeLayer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

//extension MainViewController {
//
//    //MARK: Изменение центра, радиуса, начало и конец окружности
//
//    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
//
//        var radius = labelTimer.bounds.size.width / 1.15
//
//        if radius > self.view.bounds.size.width / 2 - 40 {
//            radius = self.view.bounds.size.width / 2 - 40
//        }
//
//        let path = UIBezierPath(arcCenter: labelTimer.center, radius: CGFloat(radius),
//        startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(7 * Double.pi / 2), clockwise: true)
//        shapeLayer.frame = view.bounds
//        shapeLayer.path = path.cgPath
//    }
//}

class LabelWithShapesView: UIView {
    
    var label: UILabel {
        didSet {
            label.text = "25:00"
            label.font = UIFont(name: "Arial Rounded MT Bold", size: 60)
        }
    }
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.strokeColor = #colorLiteral(red: 0.951142132, green: 0.951142132, blue: 0.951142132, alpha: 1).cgColor
            shapeLayer.lineWidth = 26.0
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            overShapeLayer.lineWidth = 26.0
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
        }
    }
    
  var text: String {
     didSet {
           label.text = text
     }
  }

  var foregroundColor: UIColor? {
     didSet {
        overShapeLayer.strokeColor = (foregroundColor as! CGColor)
     }
  }

    init(view: LabelWithShapesView) {
    view.layer.addSublayer(shapeLayer)
    view.layer.addSublayer(overShapeLayer)
    view.addSubview(label)
  }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        
  }
}
