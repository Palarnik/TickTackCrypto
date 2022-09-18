//
//  CellViewModel.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

struct CellViewModel {
    private let element: Ticker
    
    init(element: Ticker) {
        self.element = element
    }
    
    var name: String { return Self.fullNameDictionary[element.name] ?? element.name }
    var abbriviation: String {
        var temporary = element.name
        temporary.removeFirst()
        let characterCount = temporary.count
        let index = temporary.index(temporary.startIndex, offsetBy: characterCount - 3)
        temporary.insert("/", at: index)
        return temporary
    }
    var value: String { return "$ \(element.value)" }
    var change: String { return "\(String(format: "%0.2f",element.change))%"}
    var isNegative: Bool { return element.change < 0}
    
    static let fullNameDictionary = [
        "tBTCUSD" : "Bitcoin",
        "tETHUSD" : "Ethereum",
        "tLTCUSD" : "Litecoin",
        "tXRPUSD" : "XRP Ripple",
        "tDSHUSD" : "Dashcoin",
        "tRRTUSD" : "Recovery Right Token",
        "tEOSUSD" : "EOS.IO",
        "tSANUSD" : "Santiment",
        "tDATUSD" : "Datum",
        "tSNTUSD" : "Status",
        "tDOGEUSD" : "Dogecoin",
        "tLUNAUSD" : "Luna",
        "tMATICUSD" : "Polygon",
        "tNEXOUSD" : "NEXO",
        "tOCEANUSD" : "OCEAN",
        "tBESTUSD" : "BEST",
        "tAAVEUSD" : "Aave",
        "tPLUUSD" : "Pluton",
        "tFILUSD" : "Filecoin",
    ]
}
