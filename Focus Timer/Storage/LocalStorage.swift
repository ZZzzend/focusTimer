//
//  WorkData.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//

import Foundation

class LocalStorage {
    
    enum Keys: String {
        case timer
        case rest
        
        var value: String {
            self.rawValue
        }
        
        var defaultValue: Double {
            switch self {
            case .timer: return 1500
            case .rest: return 300
            }
        }
    }
    
    static func getValue(key: Keys) -> Any? {
        UserDefaults.standard.object(forKey: key.value)
    }
    
    static func saveValue<T>(_ key: Keys,_ value: T) {
        UserDefaults.standard.setValue(value, forKey: key.value)
    }
}
