//
//  WorkData.swift
//  Focus Timer
//
//  Created by Владислав on 01.12.2021.
//

import Foundation

protocol LocalStorage {
    associatedtype Key: RawRepresentable where Key.RawValue: StringProtocol
    associatedtype Value
    
    static func getValue(key: Key) -> Value?
    static func saveValue(_ value: Value, key: Key)
}

extension LocalStorage {
    static func getValue(key: Key) -> Value? {
        if let key = key.rawValue as? String {
            let value = UserDefaults.standard.object(forKey: key)
            return value as? Value
        }
        
        return nil
    }
    
    static func saveValue(_ value: Value, key: Key) {
        if let key = key.rawValue as? String {
            UserDefaults.standard.setValue(value, forKey: key)
        }
    }
    
}

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
