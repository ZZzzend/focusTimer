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
    
    
    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var labelwithShapesView: LabelWithShapesView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        timerAction.textUpdated = { [weak self] time in
            return self?.labelwithShapesView.label.text = time
            
        }
        
        timerAction.strokeEndUpdated = { [weak self] time in
            return self?.labelwithShapesView.overShapeLayer.strokeEnd = time
        }
        
        timerAction.dischargeTimer = { [weak self] in
            return self?.dischargeTimer()
        }
        
        timerAction.labelCountUpdated = { [weak self] time in
            return self?.countTimersLabel.text = "Завершенные таймеры: \(time)"
        }
        
        actionButtons.reloadInterface = { [weak self] in
            return self?.reloadInterface()
        }
        
        actionButtons.actionStates = { [weak self] work in
            return self?.actionStates(buttonWork: work)
        }
        
        actionButtons.dischargeTimer = { [weak self] in
            return self?.dischargeTimer()
        }
        
        actionButtons.timerSheduled = { [weak self] in
            return self?.timerAction.timerSheduled()
        }
        
        
        timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        settingsButton.setImage(UIImage(named: "play.png"), for: .normal)
        
        reloadInterface()
        
    }
    
    //MARK: Начальный текст и цвет кнопок
    
    func reloadInterface() {
        guard isViewLoaded else { return }
        buttonPause.setTitle(actionButtons.state.workAndPauseButtonTitle, for: .normal)
        buttonPause.backgroundColor = actionButtons.state.workAndPauseButtonColor
        
        buttonStop.setTitle(actionButtons.state.breakAndStopButtonTitle, for: .normal)
        buttonStop.backgroundColor = actionButtons.state.breakAndStopButtonColor
        
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
