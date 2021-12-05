//
//  SettingsViewModel.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//

import Foundation

class SettingsViewModel {
    var getWorkValue: Double {
        LocalStorage.getValue(key: .timer) as? Double ?? 1500
    }
    
    var getRestValue: Double {
        LocalStorage.getValue(key: .rest) as? Double ?? 300.00
    }
    
    func saveWork(value: Double) {
        LocalStorage.saveValue(.timer, value)
    }
    
    func saveRest(value: Double) {
        LocalStorage.saveValue(.rest, value)
    }
    
}
