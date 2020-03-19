//
//  WorkTimer.swift
//  Focus Timer
//
//  Created by Владислав on 15.01.2020.
//

import UIKit
import AVFoundation
import AudioToolbox

extension ViewController {
    
       //MARK: Данные с userDefaults для таймера
    
       func userDefaultsWork() {
        
           if  let timer = userDefaults.object(forKey: "timer") {
               workCounter = (timer as? Double)!
   //        } else {
   //            workCounter = 1500.00
           }
        
          // workCircleTimer = workCounter

           if  let rest = userDefaults.object(forKey: "rest") {

               breakCounter = (rest as? Double)!
         //  } else {
         //      breakCounter = 300.00
           }
           
           workCircleTimer = workCounter
           breakCircleTimer = breakCounter

           labelTimer.text = String(format: "%02d:%02d", Int(workCounter) / 60, Int(workCounter) % 60)
       }
    
    //MARK: старт таймера при 1) Работе 2) Перерыве 3) Возобнов. работы 4) Возобн. перерыва
    
    @objc func updateCounter() {
        decrement(count: &workCounter, circleTimer: &workCircleTimer)
        if workCounter < 1 {
            countTimers += 1
            countTimersLabel.text = "Завершенные таймеры: \(countTimers)"
        }
        exampleTime(count: workCounter)
        
    }
    
    @objc func restCounter() {
        decrement(count: &breakCounter, circleTimer: &breakCircleTimer)
        exampleTime(count: breakCounter)
        
    }
    
    @objc func unpauseCounter() {
        decrementPause(count: &workCounter, circleTimer: &workCircleTimer, pause: &workPause)
        exampleTime(count: workCounter)
        
    }
    
    @objc func breakUnpauseCounter() {
        decrementPause(count: &breakCounter, circleTimer: &breakCircleTimer, pause: &breakPause)
        exampleTime(count: breakCounter)
        
    }
    
    //MARK: Отображение времени таймера в label
    
    func exampleTime(count: Double) {
            if count > 0 {
           // print("\(count) seconds to the end of the world")
                if count >= 60 {
                    labelTimer.text = String(format: "%02d:%02d", Int(count) / 60, Int(count) % 60)
                } else {
                    labelTimer.text = String(format: "%02d", Int(count))
                }
            }
            
            if count < 1 {
               AudioServicesPlaySystemSound(SystemSoundID(1022))
               dischargeTimer()
            }
    }
    
    //MARK: Подсчет времени таймера
    
    func decrement (count: inout Double, circleTimer: inout Double){
        if count > 0 {
            count = circleTimer + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            overShapeLayer.strokeEnd = CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow) / CGFloat(circleTimer)
         }
    }
    
    func decrementPause (count: inout Double, circleTimer: inout Double, pause: inout Double){
        if count > 0 {
            count = circleTimer - pause + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            overShapeLayer.strokeEnd = CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow + pause) / CGFloat(circleTimer)
         }
    }
}
