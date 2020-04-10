//
//  ActionButtons.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class ActionButtons {
    
    var mainViewController: MainViewController?
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch mainViewController!.state {
        case .initial:
            
            mainViewController?.state = .workTimerIsActive
            
            mainViewController?.timerAction.userDefaultsWork(counter: mainViewController?.timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)

            mainViewController?.timerAction.timerSheduled()
            
        case .workTimerIsActive:
            
            mainViewController?.state = .pauseTimer
            
            mainViewController?.timerAction.timer?.invalidate()
            
            mainViewController?.timerAction.workPause = (mainViewController?.timerAction.workCircleTimer)! - (mainViewController?.timerAction.workCounter)!
            
            
        case .pauseTimer:
            mainViewController?.state = .workTimerIsActive
            mainViewController?.timerAction.timerSheduled()
            
        }
    }
    
    //MARK: Изменение State при нажатии кнопки "Перерыв/Остановить"
    
    func breakAndStopState() {
        switch mainViewController!.state {
            
        case .initial:
            mainViewController?.state = .workTimerIsActive
            
            mainViewController?.timerAction.userDefaultsWork(counter: mainViewController?.timerAction.userDefaults.object(forKey: "rest") as? Double ?? 300.00)
            
            mainViewController?.timerAction.timerSheduled()
            
            mainViewController?.labelwithShapesView.label.textColor = UIColor(named: "AppGreen")

            mainViewController?.labelwithShapesView.overShapeLayer.strokeColor = UIColor(named: "AppGreen")?.cgColor
                

            mainViewController?.labelwithShapesView.label.text = String(format: "%02d:%02d", Int(mainViewController!.timerAction.workCounter) / 60, Int(mainViewController!.timerAction.workCounter) % 60)
            
            
        case .workTimerIsActive:
            dischargeTimer()
            
            
        case .pauseTimer:
            dischargeTimer()
        }
        
    }
    
    //MARK: Действия, при нажатии кнопки "Остановить"
    
    func dischargeTimer() {
        mainViewController?.state = .initial
        mainViewController?.timerAction.timer?.invalidate()
        mainViewController?.timerAction.workPause = 0.00
        
        
        mainViewController?.timerAction.userDefaultsWork(counter: mainViewController?.timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        mainViewController?.labelwithShapesView.overShapeLayer.strokeEnd = 0
        mainViewController?.labelwithShapesView.overShapeLayer.strokeColor = UIColor(named: "AppBlue")?.cgColor
        mainViewController?.labelwithShapesView.label.textColor = (UIColor(named: "AppBlack"))
    }
}
