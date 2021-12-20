//
//  TimerStorageTests.swift
//  Focus TimerTests
//
//  Created by Владислав on 20.12.2021.
//

import XCTest
@testable import Focus_Timer

class LocalStorageMock: LocalStorage {
    typealias Value = Double
    typealias Key = KeyTest
    
    enum KeyTest: String {
        case empty
        case exist
    }
    
}

class LocalStorageTests: XCTestCase {

    func testGetEmptyValue() throws {
        let emptyValue = LocalStorageMock.getValue(key: .empty)
        XCTAssertNil(emptyValue)
        
    }
    
    func testExistValue() throws {
        let expectedResult = 2.0
        LocalStorageMock.deleteValue(key: .exist)
        LocalStorageMock.saveValue(2, key: .exist)
        let realResult = LocalStorageMock.getValue(key: .exist)
        
        XCTAssertEqual(realResult, expectedResult)
    }

}
