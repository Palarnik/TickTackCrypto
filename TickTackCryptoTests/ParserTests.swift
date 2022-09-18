//
//  ParserTests.swift
//  TickTackCryptoTests
//
//  Created by Maciej Mejer on 18/09/2022.
//

import XCTest
@testable import TickTackCrypto

class ParserTests: XCTestCase {
    
    func testParserToTickerArray() async throws {
        let tickers: [Ticker] = try await Parser.parse(to: Ticker.self, from: MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.validResponseBtcAndEth.rawValue) ?? Data()).fetch())
        let expectedArray = [Ticker(name: "tBTCUSD", value: 20003.0, change: 0.0046), Ticker(name: "tETHUSD", value: 1450.5, change: 0.0114)]
        for element in expectedArray {
            guard tickers.contains(where: { $0.name == element.name && $0.value == element.value && $0.change == element.change }) else { XCTFail("\(element) not found in parsed array"); return }
        }
        assert(true)
    }
    
    func testParserThrowsError() async throws {
        do {
            let _ : [Ticker] = try await Parser.parse(to: Ticker.self, from: MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.errorResponse.rawValue) ?? Data()).fetch())
            XCTFail("Parser did not throw the expected error")
        } catch {
            assert(true)
        }
    }
}
