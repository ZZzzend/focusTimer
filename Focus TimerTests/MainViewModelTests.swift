//
//  MainViewModelTests.swift
//  Focus TimerTests
//
//  Created by Владислав on 20.12.2021.
//

import XCTest
@testable import Focus_Timer

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!

    override func setUpWithError() throws {
        viewModel = MainViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() throws {
        
    }

}
