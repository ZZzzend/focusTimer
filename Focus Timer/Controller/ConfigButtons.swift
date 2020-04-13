//
//  ConfigsForButtons.swift
//  Focus Timer
//
//  Created by Владислав on 12.04.2020.
//

import UIKit

extension MainViewController {
    func actionStates(buttonWork: Bool) {
        
        switch actionButtons.state {
            
        case .workTimerIsActive:
            
            if buttonWork == true {
                timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00, shouldUpdateCounter: true)
            } else {
                timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "rest") as? Double ?? 300.00, shouldUpdateCounter: false)
                
                labelwithShapesView.label.textColor = UIColor(named: "AppGreen")
                
                labelwithShapesView.overShapeLayer.strokeColor = UIColor(named: "AppGreen")?.cgColor
                
            }
        case .pauseTimer:
            if buttonWork == true {
                timerAction.timer?.invalidate()
                
                timerAction.workPause = timerAction.workCircleTimer - timerAction.workCounter
            }
        case .initial:
            break
        }
        
    }
    
    //MARK: Действия, при нажатии кнопки "Остановить"
    
    func dischargeTimer() {
        actionButtons.state = .initial
        timerAction.timer?.invalidate()
        timerAction.workPause = 0.00
        
        
        timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        labelwithShapesView.overShapeLayer.strokeEnd = 0
        labelwithShapesView.overShapeLayer.strokeColor = UIColor(named: "AppBlue")?.cgColor
        labelwithShapesView.label.textColor = (UIColor(named: "AppBlack"))
    }
}
