//
//  SettingsViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class SettingsViewController: UIViewController {

 //   var list = ["1","2","3"]
    let userDefaults = UserDefaults.standard
//    var currentTimer: TimerFocus?
    @IBOutlet var cityButtons: [UIDatePicker]!
    
    
    @IBOutlet weak var timeWorkDatePicker: UIDatePicker!
    @IBOutlet weak var timeRestDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pickerContainerViewWork: UIView!
    @IBOutlet weak var pickerContainerViewRest: UIView!
    
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     //   timeWorkDatePicker.translatesAutoresizingMaskIntoConstraints = false
     //   pickerContainerViewWork.translatesAutoresizingMaskIntoConstraints = false
     //   timeWorkDatePicker.topAnchor.constraint(equalTo: pickerContainerViewWork.topAnchor).isActive = true
//        pickerContainerViewWork.clipsToBounds = true
//        pickerContainerViewWork.backgroundColor = UIColor.cyan
//        stack.addArrangedSubview(pickerContainerViewWork)
//        pickerContainerViewWork.autoPinEdge(toSuperviewEdge: .leading)
//        pickerContainerViewWork.autoSetDimension(.height, toSize: 216)
//        pickerContainerViewWork.autoPinEdge(toSuperviewEdge: .leading)
//        pickerContainerViewWork.autoPinEdge(toSuperviewEdge: .trailing)
        
      //  workButton.layer.borderWidth = 1.0
        workButton.layer.borderWidth = 0.5
        workButton.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        restButton.layer.borderWidth = 0.5
        restButton.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
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
        userDefaults.setValue(timeWorkDatePicker.countDownDuration, forKey: "timer")
        userDefaults.setValue(timeRestDatePicker.countDownDuration, forKey: "rest")
        
        
//        let newTimerFocus = TimerFocus(timer: timeWorkDatePicker.countDownDuration, rest: timeRestDatePicker.countDownDuration)
//        if let currentTimer = currentTimer {
//            currentTimer.timer = newTimerFocus.timer
//            currentTimer.rest = newTimerFocus.rest
//        } else {
//            RealmModel.saveObject(newTimerFocus)
//        }
    }
    @IBAction func showPickerPressed(_ sender: UIButton) {
//        if pickerContainerView.isHidden == true {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.pickerContainerView.isHidden = false
//            })
//        } else {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.pickerContainerView.isHidden = true
//            })
//        }
//        UIView.animate(withDuration: 0.3, animations: {
//            self.pickerContainerViewWork.isHidden = !self.pickerContainerViewWork.isHidden
//        })
    }
    @IBAction func restShowPicker(_ sender: UIButton) {
//        if timeRestDatePicker.isHidden == true {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.timeRestDatePicker.isHidden = false
//                self.view.layoutIfNeeded()
//            })
//             //   timeRestDatePicker.isHidden = false
//            //}
//        } else {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.timeRestDatePicker.isHidden = true
//                self.view.layoutIfNeeded()
//            })
//        }
//        cityButtons.forEach { (button) in
//            UIView.animate(withDuration: 3) {
//                button.isHidden = !button.isHidden
//                self.view.layoutIfNeeded()
//            }
//        }
//        UIView.animate(withDuration: 0.3, animations: {
//            self.pickerContainerViewRest.isHidden = !self.pickerContainerViewRest.isHidden
//        })
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
