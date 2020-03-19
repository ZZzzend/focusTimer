//
//  ConfigShapeLayer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

extension ViewController {
    
    //MARK: Изменение центра, радиуса, начало и конец окружности
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        
        var radius = labelTimer.bounds.size.width / 1.15
        
        if labelTimer.bounds.size.width / 1.15 > self.view.bounds.size.width / 2 - 40 {
            radius = self.view.bounds.size.width / 2 - 40
        }
        
        let path = UIBezierPath(arcCenter: labelTimer.center, radius: CGFloat(radius),
        startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(7 * Double.pi / 2), clockwise: true)
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
    }
}
