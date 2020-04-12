//
//  ActionButtons.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

class ActionButtons {
    
    var state = State.initial {
        didSet {
            reloadInterface?()
        }
    }
    var actionStates: ((_ work: Bool) -> Void)?
    var dischargeTimer: (() -> Void)?
    var timerSheduled: (() -> Void)?
    var reloadInterface: (() -> Void)?
    
    //MARK: Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    
    func workAndPauseState() {
        switch state {
        case .initial:
            
            state = .workTimerIsActive
            actionStates?(true)
            timerSheduled?()
            
        case .workTimerIsActive:
            
            state = .pauseTimer
            actionStates?(true)
            
        case .pauseTimer:
            state = .workTimerIsActive
            timerSheduled?()
        }
    }
    
    //MARK: Изменение State при нажатии кнопки "Перерыв/Остановить"
    
    func breakAndStopState() {
        switch state {
            
        case .initial:
            state = .workTimerIsActive
            actionStates?(false)
            timerSheduled?()
            
        case .workTimerIsActive:
            dischargeTimer?()
            
        case .pauseTimer:
            dischargeTimer?()
        }
}
}
