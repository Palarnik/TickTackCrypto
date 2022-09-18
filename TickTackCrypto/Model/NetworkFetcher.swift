//
//  NetworkFetcher.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

class NetworkFetcher: Fetcher {
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch() async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.generalNetworkError
        }
        return data
    }
}
