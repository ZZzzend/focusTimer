//
//  MainViewModel.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//
import UIKit
import Combine

class MainViewModel {
    
    private let timerAction = TimerAction()
    private var subscriptions = Set<AnyCancellable>()
    
    var reloadInterface: (() -> Void)?
    
    @Published private(set) var strokeColor = UIColor(named: "AppBlue")?.cgColor
    @Published private(set) var timerTextColor = UIColor(named: "AppBlack")
    @Published private(set) var strokeEnd: CGFloat = 0
    @Published private(set) var timerTextUpdate = "00:00"
    @Published private(set) var countTimersUpdated = 0
    
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
    
    @Published var state = State.initial
    //{
//        didSet {
//            reloadInterface?()
//        }
 //   }
    
    // MARK: - Init timer actions
    init() {
        timerAction.dischargeTimer = { [weak self] in
            self?.dischargeTimer()
        }
        
        subscriptions = [
            timerAction.$strokeEnd
                .assign(to: \.strokeEnd, on: self),
            
            timerAction.$time
                .map {
                    var text: String
                    if $0 >= 60 {
                        text = String(format: "%02d:%02d", Int($0) / 60, Int($0) % 60)
                    } else {
                        text = String(format: "%02d", Int($0))
                    }
                    
                    return text
                }.assign(to: \.timerTextUpdate, on: self),
            
            timerAction.$countDoneTimers
                .assign(to: \.countTimersUpdated, on: self)
        ]
    }
    
    func setValueTime() {
        let value = LocalStorage.getValue(key: .timer) as? Double
        timerAction.configureTimer(counter: value ?? 1500)
    }
    
    func changeWorkState() {
        workAndPauseState()
    }
    
    func changeBreakState() {
        breakAndStopState()
    }
}

// MARK: - Change states
private extension MainViewModel {
    // MARK: - Изменение State при нажатии кнопки "Начать работу/Пауза/Возобновить"
    func workAndPauseState() {
        switch state {
        case .initial:
            state = .workTimerIsActive
            workActive()
            
        case .workTimerIsActive:
            state = .pauseTimer
            workPause()
            
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
            breakActive()
            
        case .workTimerIsActive:
            dischargeTimer()
            
        case .pauseTimer:
            dischargeTimer()
        }
    }
}

// MARK: - Actions when change states
private extension MainViewModel {
    func workActive() {
        let value = LocalStorage.getValue(key: .timer) as? Double
        timerAction.configureTimer(counter: value ?? 1500.00, shouldUpdateCounter: true)
        timerAction.start()
    }
    
    func breakActive() {
        let value = LocalStorage.getValue(key: .rest) as? Double
        timerAction.configureTimer(counter: value ?? 300.00, shouldUpdateCounter: false)
        timerAction.start()
        
        strokeColor = UIColor(named: "AppGreen")?.cgColor
        timerTextColor = UIColor(named: "AppGreen")
    }
    
    func workPause() {
        timerAction.pause()
    }
    
    func dischargeTimer() {
        state = .initial
        
        timerAction.stop()
        setValueTime()
        
        strokeColor = UIColor(named: "AppBlue")?.cgColor
        timerTextColor = UIColor(named: "AppBlack")
        strokeEnd = 0
    }
}
