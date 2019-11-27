//
//  ViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    
    private var time = TimerFocus()
    private var myTimer: Timer?
    private var countTimers = 0
    let userDefaults = UserDefaults.standard
    
    var counter = 1500 //time.timer
    var counterRest = 300 //time.rest
    var pause = 0
    var pauseBreak = 0
    lazy var circleTimerWork = counter
    lazy var circleTimerRest = counterRest

    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.strokeColor = #colorLiteral(red: 0.8875589534, green: 0.8875589534, blue: 0.8875589534, alpha: 1).cgColor
            shapeLayer.lineWidth = 30.0
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            overShapeLayer.lineWidth = 30.0
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
        }
    }

    @IBOutlet weak var CountTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userDefaultsWork()
        
        buttonSettings.setImage(UIImage(named: "play.png"), for: .normal)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
        
     //   labelTimer.text = "\(counter - ((counter/60)*60))"
    }
    
    override func viewDidLayoutSubviews() {
        
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.view.bounds.size.width / 2, y: 350), radius: CGFloat(150),
        startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(7 * Double.pi / 2), clockwise: true)
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
    }

    @IBAction func pressedSettings(_ sender: UIButton) {
        
    }
    
    func userDefaultsWork() {
        if  let timer = userDefaults.object(forKey: "timer") {
            counter = (timer as? Int)!
        } else {
            counter = 1500
        }
        circleTimerWork = counter
        
 //       counter = UserDefaults.standard.integer(forKey: "timer") ?? 1500
 //       counterRest = UserDefaults.standard.integer(forKey: "rest") ?? 300

        if  let rest = userDefaults.object(forKey: "rest") {

            counterRest = (rest as? Int)!
        } else {
            counterRest = 300
        }
        
        circleTimerWork = counter
        circleTimerRest = counterRest

        labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
    }
    
    
    
    @objc func updateCounter() {
        decrement(count: &counter, circleTimer: &circleTimerWork)
        if counter == 0 {
            countTimers += 1
            CountTimersLabel.text = "Завершенные таймеры: \(countTimers)"
        }
        exampleTime(count: counter)
        
    }
    
    @objc func restCounter() {
        decrement(count: &counterRest, circleTimer: &circleTimerRest)
        exampleTime(count: counterRest)
        
    }
    
    @objc func unpauseCounter() {
        decrementPause(count: &counter, circleTimer: &circleTimerWork, pause: &pause)
        exampleTime(count: counter)
        
    }
    
    @objc func breakUnpauseCounter() {
        decrementPause(count: &counter, circleTimer: &circleTimerWork, pause: &pauseBreak)
        exampleTime(count: counter)
        
    }
    
    func exampleTime(count: Int) {
            if count > 0 {
           // print("\(count) seconds to the end of the world")
                if count > 59 {
                    labelTimer.text = String(format: "%02d:%02d", count / 60, count % 60)
                } else {
                    labelTimer.text = String(format: "%02d", count)
                }
        }
            
            if count == 0 {
               AudioServicesPlaySystemSound(SystemSoundID(1022))
               dischargeTimer()
            }
    }
    
    func decrement (count: inout Int, circleTimer: inout Int){
        if count > 0 {
            count = circleTimer - -Int((self.myTimer?.userInfo as! Date).timeIntervalSinceNow)
            overShapeLayer.strokeEnd += 1 / CGFloat(circleTimer)
         }
    }
    
    func decrementPause (count: inout Int, circleTimer: inout Int, pause: inout Int){
        if count > 0 {
            count = circleTimer - pause - -Int((self.myTimer?.userInfo as! Date).timeIntervalSinceNow)
            overShapeLayer.strokeEnd += 1 / CGFloat(circleTimer)
         }
    }
    
    func dischargeTimer() {
        myTimer?.invalidate()
   //     counter = 300 //time.timer
   //     counterRest = 80 //time.rest
        userDefaultsWork()
    //    labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
        overShapeLayer.strokeEnd = 0
            
        buttonPause.setTitle("Начать работу", for: .normal)
        overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        if buttonStop.backgroundColor == #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) {
            labelTimer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        buttonPause.backgroundColor = #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
        buttonStop.setTitle("Перерыв", for: .normal)
        buttonStop.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
    }
        
    @IBAction func pressedButtonPause(_ sender: UIButton) {
        
        
        if sender.titleLabel?.text == "Начать работу" {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: Date(), repeats: true)
           // counter -= 1
            
            sender.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            sender.setTitle("Пауза", for: .normal)
            
            buttonStop.backgroundColor = #colorLiteral(red: 0.8166441942, green: 0.1899396583, blue: 0.1593456727, alpha: 1)
            buttonStop.setTitle("Остановить", for: .normal)
        }
        
        if sender.titleLabel?.text == "Пауза" {
            myTimer?.invalidate()
            sender.backgroundColor = #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
            sender.setTitle("Возобновить", for: .normal)
            pause = circleTimerWork - counter
            pauseBreak = circleTimerWork - counterRest
        }
        
        if sender.titleLabel?.text == "Возобновить" {
            sender.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            sender.setTitle("Пауза", for: .normal)
            
        if buttonStop.backgroundColor == #colorLiteral(red: 0.8166441942, green: 0.1899396583, blue: 0.1593456727, alpha: 1) {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(unpauseCounter), userInfo: Date(), repeats: true)
                
            } else {
                myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakUnpauseCounter), userInfo: Date(), repeats: true)
            }
        }
    }
    
    @IBAction func pressedButtonCancel(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Перерыв" {
            sender.setTitle("Остановить", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            labelTimer.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            
            buttonPause.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            buttonPause.setTitle("Пауза", for: .normal)
            
            labelTimer.text = String(format: "%02d:%02d", counterRest / 60, counterRest % 60)
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(restCounter), userInfo: Date(), repeats: true)
         //   counterRest -= 1
        }
        
        if sender.titleLabel?.text == "Остановить" {
            dischargeTimer()
        }
        
    }
    
        @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let settingsVC = segue.source as? SettingsViewController else { return }
            settingsVC.saveSettings()
            userDefaultsWork()
    }
    
//    func shapeFLayer() {
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.view.bounds.size.width / 2, y: 350), radius: CGFloat(150), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//
//        //change the fill color
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        //you can change the stroke color
//        shapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
//        //you can change the line width
//        shapeLayer.lineWidth = 20.0
//
//        view.layer.addSublayer(shapeLayer)
//    }
}

