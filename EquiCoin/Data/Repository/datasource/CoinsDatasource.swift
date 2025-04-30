//
//  CoinsDatasource.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsDatasource {
    func coins(page: Int) async -> Result<[CoinDto], AppError>
}

class ApiCoinsDatasource: CoinsDatasource {
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func coins(page: Int) async -> Result<[CoinDto], AppError> {
        do {
            let endpoint = ApiEndpoints.fetchCoins(page: page)
            let response: CoinsResponse = try await apiManager.request(endpoint: endpoint)
            guard let coins = response.data?.coins, coins.isEmpty == false else {
                return .failure(AppError.noCoinsFound)
            }
            return .success(coins)
        } catch {
            return .failure(error as? AppError ?? AppError.unableToComplete)
        }
    }
    
}
