//
//  RealmModel.swift
//  Focus Timer
//
//  Created by Владислав on 12.11.2019.
//

import RealmSwift

let realm = try! Realm()

class  RealmModel {
    
    static func saveObject (_ timer: TimerFocus){
try! realm.write {
    realm.add(timer)
}
}
    
//        static func writeObject (_ timer: TimerFocus){
//    try! realm.write {
//        timer.timer =
//    }
}
