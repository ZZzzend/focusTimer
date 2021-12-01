//
//  ActionButtons.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit

class ActionButtons {
    
    var reloadInterface: (() -> Void)?
    weak var timerAction: TimerAction?
    weak var labelWithShapesView: LabelWithShapesView?
    
    lazy var state = State.initial {
        didSet {
            reloadInterface?()
        }
    }
    
    init(timerAction: TimerAction, labelwithShapesView: LabelWithShapesView) {
        self.timerAction = timerAction
        self.labelWithShapesView = labelwithShapesView
    }
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch state {
        case .initial:
            
            state = .workTimerIsActive
            actionButtonWorkActive()
            timerAction?.timerSheduled()
            
        case .workTimerIsActive:
            
            state = .pauseTimer
            actionButtonWorkPause()
            
        case .pauseTimer:
            state = .workTimerIsActive
            timerAction?.timerSheduled()
        }
    }
    
    //MARK: Изменение State при нажатии кнопки "Перерыв/Остановить"
    
    func breakAndStopState() {
        switch state {
        
        case .initial:
            state = .workTimerIsActive
            actionButtonBreakActive()
            timerAction?.timerSheduled()
            
        case .workTimerIsActive:
            dischargeTimer()
            
        case .pauseTimer:
            dischargeTimer()
        }
    }
    
    func actionButtonWorkActive() {
        timerAction?.userDefaultsWork(counter: timerAction?.userDefaults.object(forKey: "timer") as? Double ?? 1500.00, shouldUpdateCounter: true)
    }
    
    func actionButtonBreakActive() {
        timerAction?.userDefaultsWork(counter: timerAction?.userDefaults.object(forKey: "rest") as? Double ?? 300.00, shouldUpdateCounter: false)
        labelWithShapesView?.label.textColor = UIColor(named: "AppGreen")
        labelWithShapesView?.overShapeLayer.strokeColor = UIColor(named: "AppGreen")?.cgColor
    }
    
    func actionButtonWorkPause() {
        timerAction?.timer?.invalidate()
        timerAction?.workPause = timerAction!.workCircleTimer - timerAction!.workCounter
    }
    
    func dischargeTimer() {
        state = .initial
        
        timerAction?.timer?.invalidate()
        timerAction?.workPause = 0.00
        timerAction?.userDefaultsWork(counter: timerAction?.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        labelWithShapesView?.overShapeLayer.strokeEnd = 0
        labelWithShapesView?.overShapeLayer.strokeColor = UIColor(named: "AppBlue")?.cgColor
        labelWithShapesView?.label.textColor = (UIColor(named: "AppBlack"))
    }
    
}
