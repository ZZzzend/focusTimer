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
    
    @Published private(set) var state = State.initial
    @Published private(set) var strokeColor = UIColor(named: "AppBlue")?.cgColor
    @Published private(set) var timerTextColor = UIColor(named: "AppBlack")
    @Published private(set) var strokeEnd: CGFloat = 0
    @Published private(set) var timerTextUpdate = "00:00"
    @Published private(set) var countTimersUpdated = 0
    
    init() {
        bindingTimer()
    }
    
    func setValueTime() {
        let value = TimerStorage.getValue(key: .work)
        timerAction.configureTimer(counter: value)
    }
    
    func changeWorkState() {
        workAndPauseState()
    }
    
    func changeBreakState() {
        breakAndStopState()
    }
}

// MARK: - Timer bindings
private extension MainViewModel {
    func bindingTimer() {
        subscriptions = [
            timerAction.$isFinished
                .sink(receiveValue: { [weak self] _ in
                    self?.dischargeTimer()
                }),
            
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
        let value = TimerStorage.getValue(key: .work)
        timerAction.configureTimer(counter: value, shouldUpdateCounter: true)
        timerAction.start()
    }
    
    func breakActive() {
        let value = TimerStorage.getValue(key: .rest)
        timerAction.configureTimer(counter: value, shouldUpdateCounter: false)
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
