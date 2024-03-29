//
//  SettingsViewModel.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//

import Foundation

class SettingsViewModel {
    
    var getWorkValue: Double {
        TimerStorage.getValue(key: .work)
    }
    
    var getRestValue: Double {
        TimerStorage.getValue(key: .rest)
    }
    
    private(set) var textContent = (work: "Время работы",
                                    rest: "Время отдыха",
                                    save: "Сохранить",
                                    navigation: "Настройки")
    
    func saveWork(value: Double) {
        TimerStorage.saveValue(value, key: .work)
    }
    
    func saveRest(value: Double) {
        TimerStorage.saveValue(value, key: .rest)
    }
    
}
