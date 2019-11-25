//
//  ModelTimer.swift
//  Focus Timer
//
//  Created by Владислав on 12.11.2019.
//

import RealmSwift

class TimerFocus: Object {
    
 //   static var sh
    
    @objc dynamic var timer = 1500.00,
                      rest = 300.00
    
    convenience init(timer: TimeInterval, rest: TimeInterval){
        self.init()
        self.timer = timer
        self.rest = rest
    }
}
