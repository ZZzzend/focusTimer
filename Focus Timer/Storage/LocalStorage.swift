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
