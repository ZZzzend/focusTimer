//
//  TimerAction.swift
//  Focus Timer
//
//  Created by Владислав on 21.03.2020.
//

import AVFoundation
import AudioToolbox

class TimerAction {
    
    var dischargeTimer: (() -> Void)?
    @Published var time = 0.0
    @Published var strokeEnd: CGFloat = 0.0
    @Published var countDoneTimers = 0
    
    
    private var timer: Timer?
    
    private var workCounter = 1500.00,
                workCircleTimer = 1500.00,
                workPause = 0.00,
                countTimers = 0,
                timerFinished = false
    
    
    // MARK: - Данные для таймера
    func configureTimer(counter: Double, shouldUpdateCounter: Bool? = nil) {
        workCounter = counter
        workCircleTimer = workCounter
        
        if let timerFinished = shouldUpdateCounter {
            self.timerFinished = timerFinished
        }
        

        time = workCounter
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: Date(),
                                     repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
        workPause = 0
    }
    
    func pause() {
        timer?.invalidate()
        workPause = workCircleTimer - workCounter
    }
    
    // MARK: - старт таймера при работе
    @objc func updateCounter() {
        decrement()
        
        if workCounter < 1 && timerFinished == true {
            countTimers += 1
            countDoneTimers = countTimers
        }
        
        exampleTime(count: workCounter)
    }
}

private extension TimerAction {
    
    private func exampleTime(count: Double) {
        if count > 0 {
            time = count
        }
        
        if count < 1 {
            AudioNotifications.playFinishTimer()
            dischargeTimer?()
        }
    }
    
    
    private func decrement() {
        if workCounter > 0 {
            let timeInterval = (self.timer?.userInfo as! Date).timeIntervalSinceNow
            workCounter = workCircleTimer - workPause + timeInterval
            strokeEnd = CGFloat((-timeInterval + workPause) / workCircleTimer)
        }
    }
}
