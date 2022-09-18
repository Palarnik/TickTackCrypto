//
//  TickerListViewModelTests.swift
//  TickTackCryptoTests
//
//  Created by Maciej Mejer on 18/09/2022.
//

import XCTest
import Combine
@testable import TickTackCrypto

class TickerListViewModelTests: XCTestCase {
    var viewModel: TickerListViewModel!
    var mockFetcher: MockFetcher!
    private var cancellables: Set<AnyCancellable>!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        mockFetcher = MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.validResponseBtcAndEth.rawValue) ?? Data())
        viewModel = TickerListViewModel(fetcher: mockFetcher, timerScheduler: MockTimer.self)
        cancellables = Set<AnyCancellable>()
    }
    
    //TODO: Check error handling
    func testReceivingError() async {
        let testExpectation = expectation(description: "Wait for error")
        mockFetcher.response = Data(base64Encoded: MockFetcher.MockResponse.errorResponse.rawValue) ?? Data()
        MockTimer.currentTimer.fire()
        await viewModel.$errorAppeared.sink { _ in
        } receiveValue: { isError in
            if isError {
                assert(isError)
                testExpectation.fulfill()
            }
        }.store(in: &cancellables)

        wait(for: [testExpectation], timeout: 5)
    }
    
    func testDataRefreshUsingTimer() async {
        let testExpectation = expectation(description: "Wait for refresh")
        mockFetcher.response = Data(base64Encoded: MockFetcher.MockResponse.validResponseBtcEthLtc.rawValue) ?? Data()
        MockTimer.currentTimer.fire()
        let expectedArray = [Ticker(name: "tBTCUSD", value: 19812.0, change: -0.0049), Ticker(name: "tETHUSD", value: 1427.0, change: -0.0039), Ticker(name: "tLTCUSD", value: 56.28, change: -0.0053)]
        await viewModel.$filteredTickerArray.sink { _ in
        } receiveValue: { array in
            if array == expectedArray {
                testExpectation.fulfill()
            } else {
                XCTFail("Arrays are not equal in parsed array"); return
            }
        }.store(in: &cancellables)
        
        wait(for: [testExpectation], timeout: 5)
    }

    func testFiltering() async {
        let testExpectation = expectation(description: "Wait for initial data download")
        var expectedArray = [Ticker(name: "tBTCUSD", value: 20003.0, change: 0.0046), Ticker(name: "tETHUSD", value: 1450.5, change: 0.0114)]

        let firstCancellable = await viewModel.$filteredTickerArray.sink { _ in
        } receiveValue: { array in
            if array == expectedArray {
                testExpectation.fulfill()
            } else {
                XCTFail("Arrays are not equal in parsed array"); return
            }
        }

        wait(for: [testExpectation], timeout: 5)
        firstCancellable.cancel()
        expectedArray = [Ticker(name: "tBTCUSD", value: 20003.0, change: 0.0046)]
        await viewModel.filter(for: "BTC")
        let filteredArray = await viewModel.filteredTickerArray
        assert(filteredArray == expectedArray)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFetcher = nil
        try super.tearDownWithError()
    }
}

