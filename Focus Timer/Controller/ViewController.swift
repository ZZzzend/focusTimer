//
//  ViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    private var time = TimerFocus()
    private var myTimer: Timer?
    private var countTimers = 0

    lazy var counter = 300 //time.timer
    lazy var counterRest = 80 //time.rest

    @IBOutlet weak var CountTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonSettings.setImage(UIImage(named: "play.png"), for: .normal)
        labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
        
     //   labelTimer.text = "\(counter - ((counter/60)*60))"
    }

    @IBAction func pressedSettings(_ sender: UIButton) {
        
    }
    
    @objc func updateCounter() {
        decrement(count: &counter)
        if counter == 0 {
            countTimers += 1
            CountTimersLabel.text = "Timers: \(countTimers)"
        }
        exampleTime(count: counter)
    }
    
    @objc func restCounter() {
        decrement(count: &counterRest)
        exampleTime(count: counterRest)
    }
    
    func exampleTime(count: Int) {
            if count > 0 {
            print("\(count) seconds to the end of the world")
                if count > 59 {
                    labelTimer.text = String(format: "%02d:%02d", count / 60, count % 60)
                } else {
                    labelTimer.text = String(format: "%02d", count)
                }
        }
            
            if count == 0 {
               dischargeTimer()
            }
    }
    
    func decrement (count: inout Int){
        if count > 0 {
             count -= 1
         }
    }
    
    func dischargeTimer() {
        myTimer?.invalidate()
        counter = 300 //time.timer
        counterRest = 80 //time.rest
        labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
            
        buttonPause.setTitle("Начать работу", for: .normal)
            
        if buttonStop.backgroundColor == #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) {
            labelTimer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        buttonPause.backgroundColor = #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
        buttonStop.setTitle("Перерыв", for: .normal)
        buttonStop.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
        
    @IBAction func pressedButtonPause(_ sender: UIButton) {
        
        
        if sender.titleLabel?.text == "Начать работу" {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
           // counter -= 1
            
            sender.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            sender.setTitle("Пауза", for: .normal)
            
            buttonStop.backgroundColor = #colorLiteral(red: 0.8166441942, green: 0.1899396583, blue: 0.1593456727, alpha: 1)
            buttonStop.setTitle("Остановить", for: .normal)
        }
        
        if sender.titleLabel?.text == "Пауза" {
            myTimer?.invalidate()
            sender.backgroundColor = #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
            sender.setTitle("Возобновить", for: .normal)
        }
        
        if sender.titleLabel?.text == "Возобновить" {
            sender.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            sender.setTitle("Пауза", for: .normal)
            
        if buttonStop.backgroundColor == #colorLiteral(red: 0.8166441942, green: 0.1899396583, blue: 0.1593456727, alpha: 1) {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                
            } else {
                myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restCounter), userInfo: nil, repeats: true)
            }
        }
    }
    
    @IBAction func pressedButtonCancel(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Перерыв" {
            sender.setTitle("Остановить", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            labelTimer.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            
            buttonPause.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            buttonPause.setTitle("Пауза", for: .normal)
            
            labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restCounter), userInfo: nil, repeats: true)
         //   counterRest -= 1
        }
        
        if sender.titleLabel?.text == "Остановить" {
            dischargeTimer()
        }
        
    }
    
        @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let settingsVC = segue.source as? SettingsViewController else { return }
            settingsVC.saveSettings()
    }
}

