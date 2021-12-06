//
//  TimerAction.swift
//  Focus Timer
//
//  Created by Владислав on 21.03.2020.
//

import AVFoundation
import AudioToolbox

class TimerAction {

    @Published private(set) var time = 0.0
    @Published private(set) var strokeEnd: CGFloat = 0.0
    @Published private(set) var countDoneTimers = 0
    @Published private(set) var isFinished = false
    
    private var timer: Timer?
    
    private var countTime = 1500.00,
                countAfterPause = 1500.00,
                countPause = 0.00,
                countTimers = 0,
                timerFinished = false
    
    
    // MARK: - Данные для таймера
    func configureTimer(counter: Double, shouldUpdateCounter: Bool? = nil) {
        countTime = counter
        countAfterPause = countTime
        
        if let timerFinished = shouldUpdateCounter {
            self.timerFinished = timerFinished
        }
        

        time = countTime
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
        countPause = 0
    }
    
    func pause() {
        timer?.invalidate()
        countPause = countAfterPause - countTime
    }
    
    // MARK: - старт таймера при работе
    @objc func updateCounter() {
        decrement()
        
        if countTime < 1 && timerFinished == true {
            countTimers += 1
            countDoneTimers = countTimers
        }
        
        exampleTime(count: countTime)
    }
}

private extension TimerAction {
    
    func exampleTime(count: Double) {
        if count > 0 {
            time = count
        }
        
        if count < 1 {
            AudioNotifications.playFinishTimer()
            isFinished = !isFinished
        }
    }
    
    
    func decrement() {
        if countTime > 0 {
            let timeInterval = (self.timer?.userInfo as! Date).timeIntervalSinceNow
            countTime = countAfterPause - countPause + timeInterval
            strokeEnd = CGFloat((-timeInterval + countPause) / countAfterPause)
        }
    }
}
