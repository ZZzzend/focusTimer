//
//  MainViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class MainViewController: UIViewController {
    
    let actionButtons = ActionButtons()
    let timerAction = TimerAction()
    
    //MARK: Изначальное состояние приложения
    
    var state = State.initial {
        didSet {
            guard isViewLoaded else { return }
            reloadInterface()
        }
    }
    
    //MARK: время для таймера при 1) работе, 2) отдыхе, 3) паузы 4) и кол-во заверш. таймеров
    
    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var labelwithShapesView: LabelWithShapesView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        actionButtons.mainViewController = self
        
        
        timerAction.textUpdated = { [weak self] time in
            return self?.labelwithShapesView.label.text = time

        }
        
        timerAction.strokeEndUpdated = { [weak self] time in
            return self?.labelwithShapesView.overShapeLayer.strokeEnd = time
        }
        
        timerAction.dischargeTimer = { [weak self] in
            return self?.actionButtons.dischargeTimer()
        }
        
        timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        settingsButton.setImage(UIImage(named: "play.png"), for: .normal)
        
        reloadInterface()
        
    }
    
    //MARK: Начальный текст и цвет кнопок
    
    func reloadInterface() {
        buttonPause.setTitle(state.workAndPauseButtonTitle, for: .normal)
        buttonPause.backgroundColor = state.workAndPauseButtonColor
        
        buttonStop.setTitle(state.breakAndStopButtonTitle, for: .normal)
        buttonStop.backgroundColor = state.breakAndStopButtonColor
        
    }
    
    @IBAction func workAndPause(_ sender: UIButton) {
        actionButtons.workAndPauseState()
    } 
    
    @IBAction func breakAndStop(_ sender: UIButton) {
        actionButtons.breakAndStopState()
    }
    
    //MARK: Сохраняет данные при переходе с SettingsViewContr.
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let settingsVC = segue.source as? SettingsViewController else { return }
        settingsVC.saveSettings()
        timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
    }
}
