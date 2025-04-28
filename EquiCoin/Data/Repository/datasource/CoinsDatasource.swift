//
//  CoinsDatasource.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsDatasource {
    func coins() async -> Result<[CoinDto], AppError>
}

class ApiCoinsDatasource: CoinsDatasource {
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func coins() async -> Result<[CoinDto], AppError> {
        do {
            let response: CoinsResponse = try await apiManager.request(with: ApiType.fetchCoins)
            guard let coins = response.data?.coins, coins.isEmpty == false else {
                return .failure(AppError.noCoinsFound)
            }
            return .success(coins)
        } catch {
            return .failure(error as? AppError ?? AppError.unableToComplete)
        }
    }
    
}
