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
    
    case fetchCoins(page: Int)
    case downloadImage(url: String)
    
    var method: HttpMethod {
        switch self {
        case .fetchCoins:
            return .get
        case .downloadImage:
            return .get
        }
        
    }
    
    
    var fullStringUrl: String? {
        switch self {
        case .downloadImage(let url):
            return url
        default:
            return nil
        }
    }
    
    
    var queryItems: [URLQueryItem]? {
        let offSet = 20
        switch self {
        case .fetchCoins(let page):
            return [URLQueryItem(name: "offset", value: "\(page * offSet)"),URLQueryItem(name: "limit", value: "\(offSet)")]
        default:
            return nil
        }
    }
    

    var endpoint: String {
        switch self {
        case .fetchCoins:
            return "/v2/coins"
        default:
            return ""
        }
    }
   
}

enum HttpMethod: String {
    case get = "GET"
}


