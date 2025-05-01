//
//  CoinsDatasource.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsDatasource {
    func coins(page: Int) async -> Result<[CoinDto], AppError>
    func fetchFavoriteCoins(key: String) async -> Result<[Coin], AppError>
    func favoriteCoin(coin: Coin) async throws
    func unFavoriteCoin(id: String) async
}

class ApiCoinsDatasource: CoinsDatasource {
    
    private let apiManager: ApiManager
    private let storage: Storage
    
    init(apiManager: ApiManager, storage: Storage) {
        self.apiManager = apiManager
        self.storage    = storage
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
    
    func fetchFavoriteCoins(key: String) async -> Result<[Coin], AppError> {
        do {
            guard let result: [Coin] = try await storage.fetch(for: key) else {
                return .failure(AppError.noCoinsFound)
            }
            return .success(result)
        } catch let error as AppError {
            return .failure(error)
        } catch {
            return .failure(AppError.unknownError)
        }
    }
    
    func favoriteCoin(coin: Coin) async throws {
        try await storage.save(coin, for: StorageKeys.favorites)
    }
    
    func unFavoriteCoin(id: String) async {
        await storage.delete(for: id)
    }
    
    
}
