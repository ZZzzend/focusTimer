//
//  TimerAction.swift
//  Focus Timer
//
//  Created by Владислав on 21.03.2020.
//

import AVFoundation
import AudioToolbox

class TimerAction {

    @Published private(set) var leftTime = 1500.00
    @Published private(set) var strokeEnd: CGFloat = 0.0
    @Published private(set) var countDoneTimers = 0
    @Published private(set) var isFinished = false
    
    private var timer: Timer?
    
    private var wholeTime = 1500.00,
                pauseTime = 0.00,
                isUpdateCount = false
    
    
    // MARK: - Данные для таймера
    func configureTimer(counter: Double,
                        shouldUpdateCounter: Bool? = nil) {
        leftTime = counter
        wholeTime = counter
        
        if let timerFinished = shouldUpdateCounter {
            self.isUpdateCount = timerFinished
        }
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
        pauseTime = 0
    }
    
    func pause() {
        timer?.invalidate()
        pauseTime = wholeTime - leftTime
    }
    
    // MARK: - старт таймера при работе
    @objc func updateCounter() {
        decrement()
        finishTime(count: leftTime)
    }
}

private extension TimerAction {
    
    func finishTime(count: Double) {
        if count < 1 {
            addCountDoneTimer()
            AudioNotifications.playFinishTimer()
            isFinished = !isFinished
            stop()
        }
    }
    
    
    func decrement() {
        guard leftTime > 0,
              let time = (self.timer?.userInfo as? Date) else { return }
        
            let timeInterval = time.timeIntervalSinceNow
            leftTime = wholeTime - pauseTime + timeInterval
            strokeEnd = CGFloat((-timeInterval + pauseTime) / wholeTime)
    }
    
    func addCountDoneTimer() {
        if isUpdateCount {
            countDoneTimers += 1
        }
    }
}
