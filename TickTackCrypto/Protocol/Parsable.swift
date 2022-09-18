//
//  Parsable.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

protocol Parsable {
    static func parse(from array: [Any]) throws -> Self
}
