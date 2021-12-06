//
//  MainViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var countTimersLabel: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var buttonSettings: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var labelwithShapesView: LabelWithShapesView!
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataInTimerAction()
        
        viewModel.setValueTime()
        reloadInterface()
    }
    
    @IBAction func workAndPause(_ sender: UIButton) {
        viewModel.changeWorkState()
    } 
    
    @IBAction func breakAndStop(_ sender: UIButton) {
        viewModel.changeBreakState()
    }
    
    
    // MARK: - Сохраняет данные при переходе с SettingsViewContr.
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let settingsVC = segue.source as? SettingsViewController else { return }
        settingsVC.saveSettings()
        viewModel.setValueTime()
    }
    
}

// MARK: - Update interface when timer act
private extension MainViewController {
    
    // MARK: - Начальный текст и цвет кнопок
    func reloadInterface() {
        viewModel.$state
            .subscribe(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                    guard let self = self,
                    self.isViewLoaded else { return }
                    
                    self.buttonPause.setTitle(state.workAndPauseButtonTitle, for: .normal)
                    self.buttonPause.backgroundColor = state.workAndPauseButtonColor
                    
                    self.buttonStop.setTitle(state.breakAndStopButtonTitle, for: .normal)
                    self.buttonStop.backgroundColor = state.breakAndStopButtonColor
            })
            .store(in: &subscriptions)
    }
    
    func dataInTimerAction() {
        subscriptions = [
            viewModel.$strokeColor
                .assign(to: \.strokeColor,
                        on: labelwithShapesView.overShapeLayer),
            
            viewModel.$timerTextColor
                .assign(to: \.textColor,
                        on: labelwithShapesView.label),
            
            viewModel.$strokeEnd
                .assign(to: \.strokeEnd,
                        on: labelwithShapesView.overShapeLayer),
            
            viewModel.$timerTextUpdate
                .assign(to: \.text!,
                        on: labelwithShapesView.label),
            
            viewModel.$countTimersDone
                .assign(to: \.text!,
                        on: countTimersLabel)
        ]
    }
}
