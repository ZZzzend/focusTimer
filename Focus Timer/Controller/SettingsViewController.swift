//
//  SettingsViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class SettingsViewController: UIViewController {

 //   var list = ["1","2","3"]
    var currentTimer: TimerFocus?
    @IBOutlet weak var timeWorkDatePicker: UIDatePicker!
    @IBOutlet weak var timeRestDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        return cell
//    }
    func saveSettings() {
        
        let newTimerFocus = TimerFocus(timer: timeWorkDatePicker.countDownDuration, rest: timeRestDatePicker.countDownDuration)
        if let currentTimer = currentTimer {
            currentTimer.timer = newTimerFocus.timer
            currentTimer.rest = newTimerFocus.rest
        } else {
            RealmModel.saveObject(newTimerFocus)
        }
    }
    @IBAction func showPickerPressed(_ sender: UIButton) {
        if timeWorkDatePicker.isHidden == true {
            timeWorkDatePicker.isHidden = false
        } else {
            timeWorkDatePicker.isHidden = true
        }
    }
    @IBAction func restShowPicker(_ sender: UIButton) {
        if timeRestDatePicker.isHidden == true {
    //        UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>) {
                timeRestDatePicker.isHidden = false
            //}
        } else {
            timeRestDatePicker.isHidden = true
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
