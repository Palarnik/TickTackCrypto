//
//  ParsableError.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

enum ParsableError: Error {
    case unexpectedArrayCount
    case unexpectedValueType(String)
}
