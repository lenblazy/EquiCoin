//
//  EndpointProvider.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import Foundation

protocol EnpointProvider {
    var scheme: String { get }
    var endpoint: String { get }
    var baseUrl: String { get }
    var fullStringUrl: String? { get }
    var method: HttpMethod { get }
    var queryItems: [URLQueryItem]? { get }
}


extension EnpointProvider {
    var scheme: String { "https" }
    var baseUrl: String { "api.coinranking.com" }
    var endpoint: String { "" }
    var fullStringUrl: String? { nil }
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseUrl
        components.path = endpoint
        
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
                
        debugPrint("URL components is \(components)")
        
        guard let url = fullStringUrl != nil ? URL(string: fullStringUrl!) : components.url else { throw AppError.invalidRequestUrl }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("x-access-token", forHTTPHeaderField: "coinranking2af8df56dd87dbda1d940c16c4033c0296b050867b4905e8")
        
        debugPrint(urlRequest.url?.absoluteString ?? "Nothing")
        
        return urlRequest
    }
    
}
