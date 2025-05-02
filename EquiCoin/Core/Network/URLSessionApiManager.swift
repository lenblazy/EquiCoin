//
//  ApiManager.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

struct UrlSessionApiManager: ApiManager {
    
    func request<T: Codable>(endpoint: EnpointProvider) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: endpoint.asURLRequest())

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw AppError.invalidResponse
            }
            
//            let jsonStr = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//            debugPrint(jsonStr)

            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint(error)
            throw AppError.invalidData
        }
    }
    
}
