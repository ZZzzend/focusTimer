//
//  ViewController.swift
//  Focus Timer
//
//  Created by Владислав on 08.11.2019.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSettings: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonSettings.setImage(UIImage(named: "play.png"), for: .normal)
    }

    @IBAction func pressedSettings(_ sender: UIButton) {
        
    }
    
}

