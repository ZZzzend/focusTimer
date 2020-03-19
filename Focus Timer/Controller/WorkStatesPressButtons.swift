//
//  dischargeTimer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

extension ViewController {
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch state {
        case .initial:
            state = .workTimerIsActive
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: Date(), repeats: true)
            
        case .workTimerIsActive:
            state = .pauseTimer(secondsRemaind: (self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .workTimerIsActive)
            timer?.invalidate()
            workPause = workCircleTimer - workCounter
            
        case .breakTimerIsActive:
            state = .pauseTimer(secondsRemaind: (self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .breakTimerIsActive)
            timer?.invalidate()
            breakPause = breakCircleTimer - breakCounter
            
        case .pauseTimer(let secondsRemaind, let previousState):
            state = previousState
            
            switch previousState {
            case .workTimerIsActive:
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(unpauseCounter), userInfo: Date(), repeats: true)
                
            case .breakTimerIsActive:
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(breakUnpauseCounter), userInfo: Date(), repeats: true)
                
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
            labelTimer.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            labelTimer.text = String(format: "%02d:%02d", Int(breakCounter) / 60, Int(breakCounter) % 60)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(restCounter), userInfo: Date(), repeats: true)
            
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
         timer?.invalidate()
    //     counter = 300 //time.timer
    //     counterRest = 80 //time.rest
         userDefaultsWork()
     //    labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
         overShapeLayer.strokeEnd = 0
             
         overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
         labelTimer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
     }
}
