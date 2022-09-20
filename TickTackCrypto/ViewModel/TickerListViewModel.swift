//
//  TickerListViewModel.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Combine
import Foundation

@MainActor class TickerListViewModel: ObservableObject {
    @Published var filteredTickerArray: [Ticker]
    private var tickerArray: [Ticker]
    private let fetcher: Fetcher
    private var timer: Timer?
    private var isArrayFiltered: Bool = false
    @Published var errorAppeared: Bool = false
    
    init(fetcher: Fetcher, timerScheduler: Timer.Type) {
        self.tickerArray = []
        self.filteredTickerArray = []
        self.fetcher = fetcher
        setUpTimer(timerScheduler: timerScheduler)
        timer?.fire()
    }
    
    func setUpTimer(timerScheduler: Timer.Type) {
        if timer != nil { timer?.invalidate() }
        timer = timerScheduler.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            Task { [weak self] in
                await self?.fetchTickers()
            }
        })
    }
    
    private func fetchTickers() async {
        do {
            let data = try await fetcher.fetch()
            let array = try Parser.parse(to: Ticker.self, from: data)
            tickerArray = array
            filteredTickerArray = isArrayFiltered ? tickerArray.filter({ a in filteredTickerArray.contains(where: { b in a.name == b.name })}) : tickerArray
            if errorAppeared { errorAppeared = false }
        } catch {
            errorAppeared = true
        }
    }
    
    func filter(for quarry: String) {
        isArrayFiltered = !quarry.isEmpty
        filteredTickerArray = isArrayFiltered ? tickerArray.filter({$0.name.lowercased().contains(quarry.lowercased())}) : tickerArray
    }
}
