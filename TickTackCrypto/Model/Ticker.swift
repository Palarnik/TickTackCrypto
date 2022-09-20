//
//  Ticker.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

class Ticker: Identifiable {
    var id: String {
        return name
    }
    
    typealias ID = String
    let name: ID
    var value: Double
    var change: Double
  //  let id = UUID()
    
    required init(name: String, value: Double, change: Double) {
        self.name = name
        self.value = value
        self.change = change
    }
}

extension Ticker: Parsable {
    static func parse(from array: [Any]) throws -> Self {
        guard array.count == 11 else { throw ParsableError.unexpectedArrayCount }
        
        guard let name = array[0] as? String else { throw ParsableError.unexpectedValueType("SYMBOL") }
        
        guard let change = array[6] as? Double else { throw ParsableError.unexpectedValueType("DAILY_CHANGE_RELATIVE") }
        
        guard let value = array[7] as? Double else { throw ParsableError.unexpectedValueType("LAST_PRICE") }
        
        return Self.init(name: name, value: value, change: change)
    }
}

extension Ticker: Equatable {
    static func == (lhs: Ticker, rhs: Ticker) -> Bool {
        return lhs.name == rhs.name && lhs.change == rhs.change && lhs.value == rhs.value
    }
}
