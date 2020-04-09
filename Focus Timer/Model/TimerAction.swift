//
//  TimerController.swift
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
    weak var viewController: MainViewController?
    let labelWithShapesView = LabelWithShapesView()
    var actionButtons: ActionButtons?
    
    var (workCounter, breakCounter, workPause, breakPause, countTimers) = (30.00, 30.00, 0.00, 0.00, 0)

    var workCircleTimer = 30.00
    var breakCircleTimer = 30.00

    //MARK: Данные с userDefaults для таймера

       func userDefaultsWork() {

           if  let timer = userDefaults.object(forKey: "timer") {
               workCounter = (timer as? Double)!
           }

          // workCircleTimer = workCounter

           if  let rest = userDefaults.object(forKey: "rest") {
               breakCounter = (rest as? Double)!
           }

           workCircleTimer = workCounter
           breakCircleTimer = breakCounter
     //   labelWithShapesView.overShapeLayer.strokeEnd = 1
        labelWithShapesView.text = String(format: "%02d:%02d", Int(workCounter) / 60, Int(workCounter) % 60)
       }
    
    func timerSheduled(select: Selector)  {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: select, userInfo: Date(), repeats: true)
    }

    //MARK: старт таймера при 1) Работе 2) Перерыве 3) Возобнов. работы 4) Возобн. перерыва

    @objc func updateCounter() {
        decrement(count: &workCounter, circleTimer: &workCircleTimer)
        if workCounter < 1 {
            countTimers += 1
            viewController?.countTimersLabel.text = "Завершенные таймеры: \(countTimers)"
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
                if count >= 60 {
                    labelWithShapesView.label.text = String(format: "%02d:%02d", Int(count) / 60, Int(count) % 60)
                } else {
                    labelWithShapesView.label.text = String(format: "%02d", Int(count))
                }
            }

            if count < 1 {
               AudioServicesPlaySystemSound(SystemSoundID(1022))
               actionButtons?.dischargeTimer()
            }
    }

    //MARK: Подсчет времени таймера

    func decrement (count: inout Double, circleTimer: inout Double){
        if count > 0 {
            count = circleTimer + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            labelWithShapesView.overShapeLayer.strokeEnd = CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow) / CGFloat(circleTimer)
         }

    }

    func decrementPause (count: inout Double, circleTimer: inout Double, pause: inout Double){
        if count > 0 {
            count = circleTimer - pause + (self.timer?.userInfo as! Date).timeIntervalSinceNow
            labelWithShapesView.overShapeLayer.strokeEnd = CGFloat(-(self.timer?.userInfo as! Date).timeIntervalSinceNow + pause) / CGFloat(circleTimer)
         }
    }
}
