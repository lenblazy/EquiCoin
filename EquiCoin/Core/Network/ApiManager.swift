//
//  RequestManager.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol ApiManager {
    func request<T: Codable>(endpoint: EnpointProvider) async throws -> T
}


enum ApiEndpoints: EnpointProvider {
    
    case fetchCoins(page: Int, orderBy: String?)
    case coinDetails(id: String, timePeriod: String?)
    
    var method: HttpMethod {
        switch self {
        case .fetchCoins:
            return .get
        case .coinDetails:
            return .get
        }
    }
    
    
    var queryItems: [URLQueryItem]? {
        let offSet = 20
        switch self {
        case .fetchCoins(let page, let orderBy):
            var queryList = [URLQueryItem(name: "offset", value: "\(page * offSet)"),URLQueryItem(name: "limit", value: "\(offSet)")]
            if orderBy != nil {
                queryList.append(URLQueryItem(name: "orderBy", value: orderBy))
            }
            return queryList
        case .coinDetails(id: _, timePeriod: let timePeriod):
            return [URLQueryItem(name: "timePeriod", value: timePeriod)]
        }
    }
    
    
    var endpoint: String {
        switch self {
        case .fetchCoins:
            return "/v2/coins"
        case .coinDetails(id: let id, timePeriod: _):
            return "/v2/coin/\(id)"
        }
    }
    
}

enum HttpMethod: String {
    case get = "GET"
}


