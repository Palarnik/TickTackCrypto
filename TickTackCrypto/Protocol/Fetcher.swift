//
//  Fetcher.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

protocol Fetcher {
    func fetch() async throws -> Data
}
