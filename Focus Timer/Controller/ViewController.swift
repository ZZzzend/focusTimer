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
    
    
    private var timer: Timer?
    private let userDefaults = UserDefaults.standard
    
    var state = State.initial {
        didSet {
            guard isViewLoaded else { return }
            reloadInterface()
        }
    }
    
//    private var workCounter = 1500.00
//    private var breakCounter = 300.00
//    private var workPause = 0.00
//    private var breakPause = 0.00
//    private var countTimers = 0
    private var (workCounter, breakCounter, workPause, breakPause, countTimers) = (1500.00, 300.00, 0.00, 0.00, 0)
    
    private lazy var workCircleTimer = workCounter
    private lazy var breakCircleTimer = breakCounter

    private var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.strokeColor = #colorLiteral(red: 0.8875589534, green: 0.8875589534, blue: 0.8875589534, alpha: 1).cgColor
            shapeLayer.lineWidth = 26.0
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
        }
    }
    
    private var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            overShapeLayer.lineWidth = 26.0
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
        }
    }

   // @IBOutlet weak var viewForAnimation: UIView!
    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userDefaultsWork()
        
        settingsButton.setImage(UIImage(named: "play.png"), for: .normal)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
        
        reloadInterface()
        
    }
    
    
    func reloadInterface() {
        buttonPause.setTitle(state.workAndPauseButtonTitle, for: .normal)
        buttonPause.backgroundColor = state.workAndPauseButtonColor
        
        buttonStop.setTitle(state.breakAndStopButtonTitle, for: .normal)
        buttonStop.backgroundColor = state.breakAndStopButtonColor
        
    }
    
    override func viewDidLayoutSubviews() {
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        
        var radius = labelTimer.bounds.size.width / 1.15
        
        if labelTimer.bounds.size.width / 1.15 > self.view.bounds.size.width / 2 - 40 {
            radius = self.view.bounds.size.width / 2 - 40
        }
        
        let path = UIBezierPath(arcCenter: labelTimer.center, radius: CGFloat(radius),
        startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(7 * Double.pi / 2), clockwise: true)
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
    }
    
    func userDefaultsWork() {
        if  let timer = userDefaults.object(forKey: "timer") {
            workCounter = (timer as? Double)!
        } else {
            workCounter = 1500.00
        }
        workCircleTimer = workCounter
        
 //       counter = UserDefaults.standard.integer(forKey: "timer") ?? 1500
 //       counterRest = UserDefaults.standard.integer(forKey: "rest") ?? 300

        if  let rest = userDefaults.object(forKey: "rest") {

            breakCounter = (rest as? Double)!
        } else {
            breakCounter = 300.00
        }
        
        workCircleTimer = workCounter
        breakCircleTimer = breakCounter

        labelTimer.text = String(format: "%02d:%02d", Int(workCounter) / 60, Int(workCounter) % 60)
    }
    
    
    
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
    
    func dischargeTimer() {
        state = .initial
        timer?.invalidate()
   //     counter = 300 //time.timer
   //     counterRest = 80 //time.rest
        userDefaultsWork()
    //    labelTimer.text = String(format: "%02d:%02d", counter / 60, counter % 60)
        overShapeLayer.strokeEnd = 0
            
        overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        labelTimer.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
        
    @IBAction func workAndPause(_ sender: UIButton) {
        
        switch state {
        case .initial:
            state = .workTimerIsActive
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: Date(), repeats: true)
            
        case .workTimerIsActive:
            state = .pauseTimer(secondsRemaind: (self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .workTimerIsActive)
            timer?.invalidate()
            workPause = workCircleTimer - workCounter
         //   breakPause = workCircleTimer - breakCounter
            
        case .breakTimerIsActive:
            state = .pauseTimer(secondsRemaind: (self.timer?.userInfo as! Date).timeIntervalSinceNow, previousState: .breakTimerIsActive)
            timer?.invalidate()
          //  workPause = workCircleTimer - workCounter
            breakPause = breakCircleTimer - breakCounter
            
        case .pauseTimer(let secondsRemaind, let previousState):
            state = previousState
            
            switch previousState {
            case .workTimerIsActive:
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(unpauseCounter), userInfo: Date(), repeats: true)
                
            case .breakTimerIsActive:
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(breakUnpauseCounter), userInfo: Date(), repeats: true)
                
            case .initial:
                break
                
            case .pauseTimer(let secondsRemaind, let previousState):
                break
                
            }
        }
    }
    
    @IBAction func breakAndStop(_ sender: UIButton) {
        
        switch state {
            
        case .initial:
            state = .breakTimerIsActive
            labelTimer.textColor = #colorLiteral(red: 0.2965636993, green: 0.6915442732, blue: 0.3586270114, alpha: 1)
            overShapeLayer.strokeColor = #colorLiteral(red: 0.368627451, green: 0.862745098, blue: 0.4392156863, alpha: 1).cgColor
            labelTimer.text = String(format: "%02d:%02d", Int(breakCounter) / 60, Int(breakCounter) % 60)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(restCounter), userInfo: Date(), repeats: true)
            
        case .workTimerIsActive:
          //  state = .initial
            dischargeTimer()
            
        case .breakTimerIsActive:
          //  state = .initial
            dischargeTimer()
            
        case .pauseTimer(let secondsRemaind, let previousState):
        //    state = .initial
            dischargeTimer()
        }
        
    }
    
        @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let settingsVC = segue.source as? SettingsViewController else { return }
            settingsVC.saveSettings()
            userDefaultsWork()
    }
    
    indirect enum State {
        case initial,
             workTimerIsActive,
             breakTimerIsActive,
             pauseTimer(secondsRemaind: TimeInterval, previousState: State)
        
        var workAndPauseButtonTitle: String {
            switch self {
            case .initial:
                return "Начать работу"
            case .workTimerIsActive:
                return "Пауза"
            case .breakTimerIsActive:
                return "Пауза"
            case .pauseTimer( _):
                 return "Возобновить"
            }
        }

        var workAndPauseButtonColor: UIColor {
            switch self {
                 case .initial:
                       return #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
            case .workTimerIsActive:
                 return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            case .breakTimerIsActive:
                 return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            case .pauseTimer( _):
                 return #colorLiteral(red: 0.3579321173, green: 0.7841776604, blue: 0.3394897625, alpha: 1)
            }
        }
        
        var breakAndStopButtonTitle: String {
            switch self {
                 case .initial:
                       return "Перерыв"
            case .workTimerIsActive:
                return "Остановить"
            case .breakTimerIsActive:
                return "Остановить"
            case .pauseTimer( _):
                 return "Остановить"
            }
        }

        var breakAndStopButtonColor: UIColor {
            switch self {
                 case .initial:
                       return #colorLiteral(red: 0.2392156863, green: 0.6745098039, blue: 0.968627451, alpha: 1)
            case .workTimerIsActive:
                 return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            case .breakTimerIsActive:
                 return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            case .pauseTimer( _):
                 return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            }
        }
        
        
    }
}
