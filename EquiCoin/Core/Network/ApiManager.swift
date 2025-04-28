//
//  RequestManager.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol ApiManager {
    func request<T: Codable>(with type: ApiType) async throws -> T
}



enum ApiType {
    case fetchCoins
    
    var endpoint: String {
        switch self {
        case .fetchCoins:
            return "?limit=20"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .fetchCoins:
            return .GET
        }
    }
}

enum HttpMethod {
    case GET
//    case POST
}
