//
//  CellViewModelTests.swift
//  TickTackCryptoTests
//
//  Created by Maciej Mejer on 18/09/2022.
//

import XCTest
@testable import TickTackCrypto

class CellViewModelTests: XCTestCase {
    var viewModel: CellViewModel!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = CellViewModel(element: Ticker(name: "tBTCUSD", value: 200, change: -0.534))
    }
    
    func testNameGetter() {
        assert(viewModel.name == "Bitcoin", "Name getter returned unexpected value")
    }
    
    func testAbbriviationGetter() {
        assert(viewModel.abbriviation == "BTC/USD", "Abbriviation getter returned unexpected value")
    }
    
    func testValueGetter() {
        assert(viewModel.value == "$ 200.0", "Value getter returned unexpected value")
    }
    
    func testChangeGetter() {
        assert(viewModel.change == "-0.53%", "Change getter returned unexpected value")
    }
    
    func testIsNegativeGetter() {
        assert(viewModel.isNegative, "isNegative getter returned unexpected value")
        viewModel = CellViewModel(element: Ticker(name: "tBTCUSD", value: 200, change: 0.534))
        assert(!viewModel.isNegative, "isNegative getter returned unexpected value")
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
}

