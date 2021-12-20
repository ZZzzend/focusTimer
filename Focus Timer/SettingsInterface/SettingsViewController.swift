//
//  SettingsViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var timeWorkDatePicker: UIDatePicker!
    @IBOutlet weak var timeRestDatePicker: UIDatePicker!
    
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentTexts()
        setDefaultValuesDatePickers()
    }
    
    func saveSettings() {
        saveValues()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// MARK: - Work with Values DatePickers
private extension SettingsViewController {
    
    func setDefaultValuesDatePickers() {
        timeWorkDatePicker.countDownDuration = viewModel.getWorkValue
        timeRestDatePicker.countDownDuration = viewModel.getRestValue
    }
    
    func saveValues() {
        let work = timeWorkDatePicker.countDownDuration
        let rest = timeRestDatePicker.countDownDuration
        
        viewModel.saveWork(value: work)
        viewModel.saveRest(value: rest)
    }
}

private extension SettingsViewController {
    
    func setContentTexts() {
        navigationItem.title = viewModel.textContent.navigation
        workTimeLabel.text = viewModel.textContent.work
        restTimeLabel.text = viewModel.textContent.rest
        saveButton.setTitle(viewModel.textContent.work,
                            for: .normal)
    }
    
}
