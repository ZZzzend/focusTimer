//
//  TimerStorage.swift
//  Focus Timer
//
//  Created by Владислав on 20.12.2021.
//

import Foundation

class TimerStorage: LocalStorage {
    
    enum KeyTimer: String {
        case work
        case rest
        
        var value: String {
            self.rawValue
        }
        
        var defaultValue: Double {
            switch self {
            case .work: return 1500
            case .rest: return 300
            }
        }
    }
    
    typealias Value = Double
    typealias Key = KeyTimer
    
    static func getValue(key: KeyTimer) -> Double {
        getValue(key: key) ?? key.defaultValue
    }
    
}
