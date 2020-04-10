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
        switch mainViewController?.state {
        case .initial:
            mainViewController?.state = .workTimerIsActive
            mainViewController?.timerAction.timerSheduled(selector: #selector(mainViewController?.timerAction.updateCounter))
            
        case .workTimerIsActive:
            mainViewController?.state = .pauseTimer(secondsRemaind: (mainViewController?.timerAction.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .workTimerIsActive)
            mainViewController?.timerAction.timer?.invalidate()
            mainViewController?.timerAction.workPause = (mainViewController?.timerAction.workCircleTimer)! - (mainViewController?.timerAction.workCounter)!
            
        case .breakTimerIsActive:
            mainViewController?.state = .pauseTimer(secondsRemaind: (mainViewController?.timerAction.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .breakTimerIsActive)
            mainViewController?.timerAction.timer?.invalidate()
            mainViewController?.timerAction.breakPause = (mainViewController?.timerAction.breakCircleTimer)! - (mainViewController?.timerAction.breakCounter)!
            
        case .pauseTimer(let secondsRemaind, let previousState):
            mainViewController?.state = previousState
            
            switch previousState {
            case .workTimerIsActive:
                mainViewController?.timerAction.timerSheduled(selector: #selector(mainViewController?.timerAction.unpauseCounter))
                
            case .breakTimerIsActive:
                mainViewController?.timerAction.timerSheduled(selector: #selector(mainViewController?.timerAction.breakUnpauseCounter))
                
            case .initial:
                break
                
            case .pauseTimer(let secondsRemaind, let previousState):
                break
                
            }
        case .none:
            break
        }
    }
    
    //MARK: Изменение State при нажатии кнопки "Перерыв/Остановить"
    
    func breakAndStopState() {
        switch mainViewController?.state {
            
        case .initial:
            mainViewController?.state = .breakTimerIsActive
            mainViewController?.labelwithShapesView.label.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            mainViewController?.labelwithShapesView.overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            mainViewController?.labelwithShapesView.label.text = String(format: "%02d:%02d", Int(mainViewController!.timerAction.breakCounter) / 60, Int(mainViewController!.timerAction.breakCounter) % 60)
            mainViewController?.timerAction.timerSheduled(selector: #selector(mainViewController?.timerAction.restCounter))
            
        case .workTimerIsActive:
            dischargeTimer()
            
        case .breakTimerIsActive:
            dischargeTimer()
            
        case .pauseTimer(let secondsRemaind, let previousState):
            dischargeTimer()
        case .none:
            break
        }
        
    }
    
    //MARK: Действия, при нажатии кнопки "Остановить"
    
    func dischargeTimer() {
        mainViewController?.state = .initial
        mainViewController?.timerAction.timer?.invalidate()
        mainViewController?.timerAction.userDefaultsWork()
        
        mainViewController?.labelwithShapesView.overShapeLayer.strokeEnd = 0
        mainViewController?.labelwithShapesView.overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        mainViewController?.labelwithShapesView.label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
