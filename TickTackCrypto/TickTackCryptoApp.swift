//
//  TickTackCryptoApp.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import SwiftUI

@main
struct TickTackCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            if let url =  URLBuilder.build(base: .bitfinex, path: .tickers, query: [.symbols: [.tBTCUSD,.tETHUSD, .tLTCUSD,.tXRPUSD,.tDSHUSD,.tRRTUSD,.tEOSUSD,.tSANUSD,.tDATUSD,.tSNTUSD,.tDOGEUSD,.tLUNAUSD,.tMATICUSD,.tNEXOUSD,.tOCEANUSD,.tBESTUSD,.tAAVEUSD,.tPLUUSD,.tFILUSD]]) {
                TickerListView(viewModel: TickerListViewModel(fetcher: NetworkFetcher(url: url), timerScheduler: Timer.self))
            } else {
                TickerListView(viewModel: TickerListViewModel(fetcher: MockFetcher(response: Data(base64Encoded: MockFetcher.MockResponse.errorResponse.rawValue) ?? Data()), timerScheduler: Timer.self))
            }
        }
    }
}
