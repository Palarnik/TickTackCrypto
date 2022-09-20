//
//  Parsere.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation
enum Parser {
    static func parse<T>(to type: T.Type, from data: Data) throws -> [T] where T: Parsable {
        guard let decodedArray = try (JSONSerialization.jsonObject(with: data) as? [[Any]]) else {
           throw ParsableError.unexpectedValueType("Could not decode to [[Any]]")
        }
        var array = [T]()
        for element in decodedArray {
            array.append(try T.parse(from: element))
        }
        return array
    }
}
