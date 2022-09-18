//
//  URLBuilder.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

enum URLBuilder {
    static func build(base: URLBase, path: URLPathComponent, query: [URLQueryKey: [URLQueryValue]]) -> URL? {
        guard var url = URLComponents(string: base.rawValue) else { return nil }
        url.path += path.rawValue
        
        var queryItems = [URLQueryItem]()
        for (key, values) in query {
            var valuesString = ""
            for element in values { valuesString.append("\(element.rawValue),") }
            if valuesString.last == "," { valuesString.removeLast() }
            queryItems.append( URLQueryItem(name: key.rawValue, value: valuesString))
        }
        url.queryItems = queryItems
        return url.url
    }
    
    enum URLBase: String {
        case bitfinex = "https://api-pub.bitfinex.com/v2/"
    }
    
    enum URLPathComponent: String {
        case tickers
    }
    
    enum URLQueryKey: String  {
        case symbols
    }
    
    enum URLQueryValue: String {
        case tBTCUSD,tETHUSD,tLTCUSD,tXRPUSD,tDSHUSD,tRRTUSD,tEOSUSD,tSANUSD,tDATUSD,tSNTUSD,tDOGEUSD,tLUNAUSD,tMATICUSD,tNEXOUSD,tOCEANUSD,tBESTUSD,tAAVEUSD,tPLUUSD,tFILUSD
    }
}

