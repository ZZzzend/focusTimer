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
    
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    
    private let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
