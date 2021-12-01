//
//  TimerAction.swift
//  Focus Timer
//
//  Created by Владислав on 21.03.2020.
//

import AVFoundation
import AudioToolbox

class TimerAction {
    
    var timer: Timer?
    let userDefaults = UserDefaults.standard
    var textUpdated: ((_ time: String) -> Void)?
    var strokeEndUpdated: ((_ time: CGFloat) -> Void)?
    var labelCountUpdated: ((_ time: Int) -> Void)?
    var dischargeTimer: (() -> Void)?
    
    var workCounter = 1500.00,
        workCircleTimer = 1500.00,
        workPause = 0.00,
        countTimers = 0,
        timerFinished = false
    
    
    //MARK: Данные с userDefaults для таймера
    
    func userDefaultsWork(counter: Double, shouldUpdateCounter: Bool? = nil) {
        workCounter = counter
        workCircleTimer = workCounter
        
        if shouldUpdateCounter != nil {
            timerFinished = shouldUpdateCounter!
        }
        
        textUpdated?(String(format: "%02d:%02d", Int(workCounter) / 60, Int(workCounter) % 60))
        
    }
    
    func timerSheduled()  {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: Date(), repeats: true)
    }
    
    //MARK: старт таймера при работе
    
    @objc func updateCounter() {
        decrement(count: &workCounter, circleTimer: &workCircleTimer, pause: &workPause)
        if workCounter < 1 && timerFinished == true {
            countTimers += 1
            labelCountUpdated?(countTimers)
        }
        exampleTime(count: workCounter)
        
    }
    
    //MARK:  Отображение времени таймера в label
    
    func exampleTime(count: Double) {
        
        if count > 0 {
            if count >= 60 {
                textUpdated?(String(format: "%02d:%02d", Int(count) / 60, Int(count) % 60))
            } else {
                textUpdated?(String(format: "%02d", Int(count)))
            }
        }
        
        if count < 1 {
            AudioServicesPlaySystemSound(SystemSoundID(1022))
            dischargeTimer?()
        }
    }
    
    
    func decrement (count: inout Double, circleTimer: inout Double, pause: inout Double){
        if count > 0 {
            count = circleTimer - pause + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            
            strokeEndUpdated?(CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow + pause) / CGFloat(circleTimer))
        }
    }
}
