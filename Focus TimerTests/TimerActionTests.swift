//
//  TimerActionTests.swift
//  Focus TimerTests
//
//  Created by Владислав on 20.12.2021.
//

import XCTest
@testable import Focus_Timer

class TimerActionTests: XCTestCase {
    
    var timer: TimerAction!

    override func setUpWithError() throws {
        timer = TimerAction()
    }

    override func tearDownWithError() throws {
        timer = nil
    }

    func testConfigureSetCorrectTimeValue() throws {
        let counter = 0.0
        let isUpdate = true
        let expectedResult = true
        var currentResult: Bool
        
        timer.configureTimer(counter: counter, shouldUpdateCounter: isUpdate)
        
        currentResult = timer.leftTime == counter
        
        XCTAssertEqual(currentResult, expectedResult)
    }
    
    func testIsCorrectCountDown() throws {
        let expectation = self.expectation(description: #function)
        let expectedTime: Double = 2
        
        timer.configureTimer(counter: expectedTime * 2)
        timer.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + expectedTime) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: expectedTime + 1)
        timer.stop()
        
        XCTAssertLessThan(timer.leftTime - expectedTime, 1)
        XCTAssertLessThan(expectedTime - timer.leftTime, 1)
    }
    

    func testUpdateCounterWhenTimerOff() throws {
        timer.updateCounter()
    }

    func testIsUpdatedCountDoneTimers() throws {
        let expectation = self.expectation(description: #function)
        let expectedTime: Double = 1
        
        timer.configureTimer(counter: 0, shouldUpdateCounter: true)
        timer.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + expectedTime) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: expectedTime + 1)
        
        XCTAssertGreaterThan(timer.countDoneTimers, 0)
    }

}
