//
//  MainViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class MainViewController: UIViewController {
    
    let timerAction = TimerAction()
    lazy var actionButtons = ActionButtons(timerAction: self.timerAction, labelwithShapesView: self.labelwithShapesView)
    
    
    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var labelwithShapesView: LabelWithShapesView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataInTimerAction()
        dataInActionButtons()
        
        timerAction.userDefaultsWork(counter: timerAction.userDefaults.object(forKey: "timer") as? Double ?? 1500.00)
        
        settingsButton.setImage(UIImage(named: "IconSettings.png"), for: .normal)
        
        reloadInterface()
    }
    
    func dataInTimerAction() {
        timerAction.textUpdated = { [weak self] time in
            return (self?.labelwithShapesView.label.text = time)!
        }
        timerAction.strokeEndUpdated = { [weak self] time in
            return (self?.labelwithShapesView.overShapeLayer.strokeEnd = time)!
        }
        timerAction.dischargeTimer = { [weak self] in
            return (self?.actionButtons.dischargeTimer())!
        }
        timerAction.labelCountUpdated = { [weak self] time in
            return (self?.countTimersLabel.text = "Завершенные таймеры: \(time)")!
        }
    }
    
    func dataInActionButtons() {
        actionButtons.reloadInterface = { [weak self] in
            return (self?.reloadInterface())!
        }
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
