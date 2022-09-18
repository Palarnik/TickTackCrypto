//
//  URLBuilderTests.swift
//  TickTackCryptoTests
//
//  Created by Maciej Mejer on 18/09/2022.
//

import XCTest
@testable import TickTackCrypto

class URLBuilderTests: XCTestCase {
    
    func testURLBuilder() {
        guard let url = URLBuilder.build(base: .bitfinex, path: .tickers, query: [.symbols: [.tAAVEUSD,.tBESTUSD,.tBTCUSD]]) else {
            XCTFail("Could not create url")
            return
        }
        assert(url.absoluteString == "https://api-pub.bitfinex.com/v2/tickers?symbols=tAAVEUSD,tBESTUSD,tBTCUSD")
    }

}
