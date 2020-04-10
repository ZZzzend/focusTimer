//
//  TimerAction.swift
//  Focus Timer
//
//  Created by Владислав on 21.03.2020.
//

import Foundation
import AVFoundation
import AudioToolbox

class TimerAction {

    var timer: Timer?
    let userDefaults = UserDefaults.standard
    var viewController: MainViewController?
    weak var actionButtons: ActionButtons?
    
    var (workCounter, workCircleTimer, workPause, countTimers)
        = (1500.00,       1500.00,       0.00,         0)


    //MARK: Данные с userDefaults для таймера
    
    func userDefaultsWork(counter: Double) {
        workCounter = counter
        workCircleTimer = workCounter
        
        viewController?.labelwithShapesView.label.text = String(format: "%02d:%02d", Int(workCounter) / 60, Int(workCounter) % 60)
    }
    
    func timerSheduled()  {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: Date(), repeats: true)
        
    }

    //MARK: старт таймера при работе

    @objc func updateCounter() {
        decrementPause(count: &workCounter, circleTimer: &workCircleTimer, pause: &workPause)
        if workCounter < 1 {
            countTimers += 1
            viewController?.countTimersLabel.text = "Завершенные таймеры: \(countTimers)"
        }
        exampleTime(count: workCounter)

    }

    //MARK:  Отображение времени таймера в label

    func exampleTime(count: Double) {
            if count > 0 {
                if count >= 60 {
                    viewController?.labelwithShapesView.label.text = String(format: "%02d:%02d", Int(count) / 60, Int(count) % 60)
                } else {
                    viewController?.labelwithShapesView.label.text = String(format: "%02d", Int(count))
                }
            }

            if count < 1 {
               AudioServicesPlaySystemSound(SystemSoundID(1022))
               actionButtons?.dischargeTimer()
            }
    }


    func decrementPause (count: inout Double, circleTimer: inout Double, pause: inout Double){
        if count > 0 {
            count = circleTimer - pause + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            viewController?.labelwithShapesView.overShapeLayer.strokeEnd = CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow + pause) / CGFloat(circleTimer)
         }
    }
}
