//
//  ActionButtons.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class ActionButtons {
    
    var viewController: MainViewController?
    let timerAction = TimerAction()
    weak var labelWithShapesView = LabelWithShapesView()

    init() {
        timerAction.actionButtons = self
    }
    
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch viewController?.state {
        case .initial:
            viewController?.state = .workTimerIsActive
            // timerAction.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction.updateCounter), userInfo: Date(), repeats: true)
            timerAction.timerSheduled(select: #selector(timerAction.updateCounter))
            
        case .workTimerIsActive:
            viewController?.state = .pauseTimer(secondsRemaind: (timerAction.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .workTimerIsActive)
            timerAction.timer?.invalidate()
            timerAction.workPause = timerAction.workCircleTimer - timerAction.workCounter
            
        case .breakTimerIsActive:
            viewController?.state = .pauseTimer(secondsRemaind: (timerAction.self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .breakTimerIsActive)
            timerAction.timer?.invalidate()
            timerAction.breakPause = timerAction.breakCircleTimer - timerAction.breakCounter
            
        case .pauseTimer(let secondsRemaind, let previousState):
            viewController?.state = previousState
            
            switch previousState {
            case .workTimerIsActive:
                timerAction.timerSheduled(select: #selector(timerAction.unpauseCounter))
                
            case .breakTimerIsActive:
                timerAction.timerSheduled(select: #selector(timerAction.breakUnpauseCounter))
                
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
        switch viewController?.state {
            
        case .initial:
            viewController?.state = .breakTimerIsActive
            labelWithShapesView?.label.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            labelWithShapesView?.overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            labelWithShapesView?.label.text = String(format: "%02d:%02d", Int(timerAction.breakCounter) / 60, Int(timerAction.breakCounter) % 60)
            timerAction.timerSheduled(select: #selector(timerAction.restCounter))
            
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
        viewController?.state = .initial
        timerAction.timer?.invalidate()
        
        timerAction.userDefaultsWork()
        //    labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
        labelWithShapesView?.overShapeLayer.strokeEnd = 0
        
        labelWithShapesView?.overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        labelWithShapesView?.label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
