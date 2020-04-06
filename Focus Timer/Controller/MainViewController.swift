//
//  ViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class MainViewController: UIViewController {
    
 //   let timerController = TimerController()
  //  var timer: Timer?
  //  let userDefaults = UserDefaults.standard
//    var timerController = TimerController()
  //  var actionButtons: ActionButtons?
    
//    var tai = "HI view"
    //MARK: Изначальное состояние приложения
    
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
    
    //MARK: время для таймера при 1) работе, 2) отдыхе, 3) паузы 4) и кол-во заверш. таймеров
    
    
    
    //MARK: Создание окружностей для таймера

//    var shapeLayer: CAShapeLayer! {
//        didSet {
//            shapeLayer.strokeColor = #colorLiteral(red: 0.951142132, green: 0.951142132, blue: 0.951142132, alpha: 1).cgColor
//            shapeLayer.lineWidth = 26.0
//            shapeLayer.lineCap = .round
//            shapeLayer.fillColor = nil
//            shapeLayer.strokeEnd = 1
//        }
//    }
//
//    var overShapeLayer: CAShapeLayer! {
//        didSet {
//            overShapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
//            overShapeLayer.lineWidth = 26.0
//            overShapeLayer.lineCap = .round
//            overShapeLayer.fillColor = nil
//            overShapeLayer.strokeEnd = 0
//        }
//    }

    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    //    timerController.userDefaultsWork()
        
        settingsButton.setImage(UIImage(named: "play.png"), for: .normal)
        
 //       shapeLayer = CAShapeLayer()
      //  view.layer.addSublayer()
        
   //     overShapeLayer = CAShapeLayer()
   //     view.layer.addSublayer(overShapeLayer)
        
        reloadInterface()
        
    }
    
    override func viewDidLayoutSubviews() {
     //   configShapeLayer(shapeLayer)
     //   configShapeLayer(overShapeLayer)
    }
    
    //MARK: Начальный текст и цвет кнопок
    
    func reloadInterface() {
        buttonPause.setTitle(state.workAndPauseButtonTitle, for: .normal)
        buttonPause.backgroundColor = state.workAndPauseButtonColor
        
        buttonStop.setTitle(state.breakAndStopButtonTitle, for: .normal)
        buttonStop.backgroundColor = state.breakAndStopButtonColor
        
    }

    @IBAction func workAndPause(_ sender: UIButton) {
    //    actionButtons.workAndPauseState()
//        let testovi = Testovi()
//        testovi.viewController = self
//        testovi.privet()
//        testovi.privet2()
        
    } 
    
    @IBAction func breakAndStop(_ sender: UIButton) {
     //   actionButtons.breakAndStopState()

    }
    
    //MARK: Сохраняет данные при переходе с SettingsViewContr.
    
        @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let settingsVC = segue.source as? SettingsViewController else { return }
            settingsVC.saveSettings()
    //        timerController.userDefaultsWork()
    }
}
