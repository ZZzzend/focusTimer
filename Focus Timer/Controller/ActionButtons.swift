//
//  dischargeTimer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class ActionButtons {
    
    var viewController = ViewController()
    let timerController = TimerController()
    var state = State.initial
    let userDefaults = UserDefaults.standard
    
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch state {
        case .initial:
            state = .workTimerIsActive
            timerController.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerController.updateCounter), userInfo: Date(), repeats: true)
            
        case .workTimerIsActive:
            state = .pauseTimer(secondsRemaind: (timerController.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .workTimerIsActive)
            timerController.timer?.invalidate()
            timerController.workPause = timerController.workCircleTimer - timerController.workCounter
            
        case .breakTimerIsActive:
            state = .pauseTimer(secondsRemaind: (timerController.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .breakTimerIsActive)
            timerController.timer?.invalidate()
            timerController.breakPause = timerController.breakCircleTimer - timerController.breakCounter
            
        case .pauseTimer(let secondsRemaind, let previousState):
            state = previousState
            
            switch previousState {
            case .workTimerIsActive:
                timerController.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerController.unpauseCounter), userInfo: Date(), repeats: true)
                
            case .breakTimerIsActive:
                timerController.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerController.breakUnpauseCounter), userInfo: Date(), repeats: true)
                
            case .initial:
                break
                
            case .pauseTimer(let secondsRemaind, let previousState):
                break
                
            }
        }
    }
    
    //MARK: Изменение State при нажатии кнопки "Перерыв/Остановить"
    
    func breakAndStopState() {
        switch state {
            
        case .initial:
            state = .breakTimerIsActive
            viewController.labelTimer.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            viewController.overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            viewController.labelTimer.text = String(format: "%02d:%02d", Int(timerController.breakCounter) / 60, Int(timerController.breakCounter) % 60)
            timerController.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerController.restCounter), userInfo: Date(), repeats: true)
            
        case .workTimerIsActive:
            dischargeTimer()
            
        case .breakTimerIsActive:
            dischargeTimer()
            
        case .pauseTimer(let secondsRemaind, let previousState):
            dischargeTimer()
        }
        
    }
    
    //MARK: Действия, при нажатии кнопки "Остановить"
    
     func dischargeTimer() {
         state = .initial
        timerController.timer?.invalidate()
    //     counter = 300 //time.timer
    //     counterRest = 80 //time.rest
        timerController.userDefaultsWork()
     //    labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
        viewController.overShapeLayer.strokeEnd = 0
             
        viewController.overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        viewController.labelTimer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
     }
}
