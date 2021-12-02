//
//  MainViewModel.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//
import UIKit

class MainViewModel {
    
    private let timerAction = TimerAction()
    
    var reloadInterface: (() -> Void)?
    
    lazy var state = State.initial {
        didSet {
            reloadInterface?()
        }
    }
    
    var updateTimerInterface: ((_ strokeColor: CGColor,
                                _ textColor: UIColor) -> Void)?
    var updateCircumference: ((_ strokeEnd: CGFloat) -> Void)?
    
    var textTimerUpdated: ((_ time: String) -> Void)?
    var countTimersUpdated: ((_ time: Int) -> Void)?
    
    var workAndPauseButtonTitle: String {
        state.workAndPauseButtonTitle
    }

    var breakAndStopButtonTitle: String {
        state.breakAndStopButtonTitle
    }
    
    var workAndPauseButtonColor: UIColor {
        state.workAndPauseButtonColor
    }
    
    var breakAndStopButtonColor: UIColor {
        state.breakAndStopButtonColor
    }
    
    func setValueTime() {
        let value = LocalStorage.getValue(key: .timer) as? Double
        timerAction.userDefaultsWork(counter: value ?? 1500)
    }
    
    init() {
        timerAction.dischargeTimer = { [weak self] in
            self?.dischargeTimer()
        }
        
        timerAction.strokeEndUpdated = { [weak self] stroke in
            self?.updateCircumference?(stroke)
        }
        
        timerAction.textUpdated = { [weak self] text in
            self?.textTimerUpdated?(text)
        }
        
        timerAction.labelCountUpdated = { [weak self] count in
            self?.countTimersUpdated?(count)
        }
    }
    
    // MARK: - Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    func workAndPauseState() {
        switch state {
        case .initial:
            state = .workTimerIsActive
            actionButtonWorkActive()
            
        case .workTimerIsActive:
            state = .pauseTimer
            actionButtonWorkPause()
            
        case .pauseTimer:
            state = .workTimerIsActive
            timerAction.start()
        }
    }
    
    // MARK: - Изменение State при нажатии кнопки "Перерыв/Остановить"
    func breakAndStopState() {
        switch state {
        case .initial:
            state = .workTimerIsActive
            actionButtonBreakActive()
            
        case .workTimerIsActive:
            dischargeTimer()
            
        case .pauseTimer:
            dischargeTimer()
        }
    }
    
    func actionButtonWorkActive() {
        let value = LocalStorage.getValue(key: .timer) as? Double
        timerAction.userDefaultsWork(counter: value ?? 1500.00, shouldUpdateCounter: true)
        timerAction.start()
    }
    
    func actionButtonBreakActive() {
        let value = LocalStorage.getValue(key: .rest) as? Double
        timerAction.userDefaultsWork(counter: value ?? 300.00, shouldUpdateCounter: false)
        timerAction.start()
        
        guard let strokeColor = UIColor(named: "AppGreen")?.cgColor,
              let textColor = UIColor(named: "AppGreen") else { return }
        
        updateTimerInterface?(strokeColor, textColor)
    }
    
    func actionButtonWorkPause() {
        timerAction.pause()
    }
    
    func dischargeTimer() {
        state = .initial
        
        timerAction.stop()
        setValueTime()
        
        guard let strokeColor = UIColor(named: "AppBlue")?.cgColor,
              let textColor = UIColor(named: "AppBlack") else { return }
        
        updateTimerInterface?(strokeColor, textColor)
        updateCircumference?(0)
    }
    
}
