//
//  ApiManager.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

struct UrlSessionApiManager: ApiManager {
    private let baseURL = "https://api.coinranking.com/v2/coins"
    
    func request<T: Codable>(with type: ApiType) async throws -> T {
        guard let url = URL(string: baseURL + type.endpoint) else {
            throw AppError.invalidRequestUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw AppError.invalidResponse
            }
            
            let jsonStr = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            debugPrint(jsonStr)
//            debugPrint(data)

            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint(error)
            throw AppError.invalidData
        }
    }
    
}
