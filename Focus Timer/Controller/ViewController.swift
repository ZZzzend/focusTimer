//
//  ViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    var time = TimerFocus()

    lazy var counter = time.timer
    lazy var counterRest = time.rest
    var myTimer: Timer?

    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelTimerSeconds:UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonSettings.setImage(UIImage(named: "play.png"), for: .normal)
        labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
        
        //"\(counter - (((counter + 1)/60)-1)*60)"
    }

    @IBAction func pressedSettings(_ sender: UIButton) {
        
    }
    
    @objc func updateCounter() {
        
        if counter > 0 {
        print("\(counter) seconds to the end of the world")
            if counter > 60 {
       //     labelTimer.text = "\(counter / 60):\(counter - (counter / 60) * 60)"
      //  labelTimerSeconds.text = "\(counter - (counter / 60) * 60)"
                labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
            } else {
                labelTimer.text = String(format: "%02d", counter)
            }
        counter -= 1
    }
//        if labelTimer.text == "0" {
//            labelTimer.isHidden = true
//            labelTimerSeconds.font = UIFont.systemFont(ofSize: 80)
//        }
        
        if counter == 0 {
           dischargeTimer()
        }
    }
    
    @objc func restCounter() {
            
        if counterRest > 0 {
        print("\(counterRest) seconds to the end of the world")
    //    labelTimer.text = "\(counterRest / 60):\(counterRest - (counterRest / 60) * 60)"
   //     labelTimerSeconds.text = "\(counterRest - (counterRest / 60) * 60)"
            if counter > 60 {
             //     labelTimer.text = "\(counter / 60):\(counter - (counter / 60) * 60)"
            //  labelTimerSeconds.text = "\(counter - (counter / 60) * 60)"
                      labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
                  } else {
                      labelTimer.text = String(format: "%02d", counterRest)
                  }
            
        counterRest -= 1
        }
        
        if counterRest == 0 {
           dischargeTimer()
        }
    }
    
    func dischargeTimer() {
        myTimer?.invalidate()
        counter = time.timer
        counterRest = time.rest
        labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
            
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
            labelTimerSeconds.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            
            buttonPause.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            buttonPause.setTitle("Пауза", for: .normal)
            
            labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restCounter), userInfo: nil, repeats: true)
        }
        
        if sender.titleLabel?.text == "Остановить" {
            dischargeTimer()
        }
        
    }    
}

