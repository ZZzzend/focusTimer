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

//        workButton.layer.borderWidth = 0.5
//        workButton.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
//        restButton.layer.borderWidth = 0.5
//       restButton.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        
      //  borderWidthAndColor(buttonWidth: 0.5, buttonColor: #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
     //   borderWidthAndColor(button: workButton)
     //   borderWidthAndColor(button: restButton)
        setCountDownDuration()
    }
    
//    func borderWidthAndColor(button: UIButton) {
//
//        button.layer.borderWidth = 0.5
//        button.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
//    }
    
    func setCountDownDuration() {
        
        if  let timer = userDefaults.object(forKey: "timer") {
            timeWorkDatePicker.countDownDuration = (timer as? Double)!
        } else {
            timeWorkDatePicker.countDownDuration = 1500.00
        }
        if  let rest = userDefaults.object(forKey: "rest") {
            timeRestDatePicker.countDownDuration = (rest as? Double)!
        } else {
            timeRestDatePicker.countDownDuration = 300.00
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
