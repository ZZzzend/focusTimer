//
//  SettingsViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var timeWorkDatePicker: UIDatePicker!
    @IBOutlet weak var timeRestDatePicker: UIDatePicker!
    
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCountDownDuration()
    }
    
    //MARK: Данные для таймера в UserDefaults
    
    func setCountDownDuration() {
        
        if  let timer = userDefaults.object(forKey: "timer") {
            timeWorkDatePicker.countDownDuration = (timer as? Double)!
        }
        if  let rest = userDefaults.object(forKey: "rest") {
            timeRestDatePicker.countDownDuration = (rest as? Double)!
        }
        
    }
    
    func saveSettings() {
        userDefaults.setValue(timeWorkDatePicker.countDownDuration, forKey: "timer")
        userDefaults.setValue(timeRestDatePicker.countDownDuration, forKey: "rest")
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
