//
//  CoinsDatasource.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsDatasource {
    func coins(page: Int, orderBy: String?) async -> Result<[CoinDto], AppError>
    func coinDetails(id: String, period: String) async -> Result<CoinDto, AppError>
    func fetchFavoriteCoins() async -> Result<[Coin], AppError>
    func favoriteCoin(coin: Coin) async throws
    func unFavoriteCoin(coin: Coin) async throws
}

class CoinsDatasourceImpl: CoinsDatasource {
    
    private let apiManager: ApiManager
    private let storage: StorageManager
    
    init(apiManager: ApiManager, storage: StorageManager) {
        self.apiManager = apiManager
        self.storage    = storage
    }
    
    
    func coins(page: Int, orderBy: String? = nil) async -> Result<[CoinDto], AppError> {
        do {
            let endpoint = ApiEndpoints.fetchCoins(page: page, orderBy: orderBy)
            let response: CoinsResponse = try await apiManager.request(endpoint: endpoint)
            guard let coins = response.data?.coins, coins.isEmpty == false else {
                return .failure(AppError.noCoinsFound)
            }
            return .success(coins)
        } catch let error as AppError {
            return .failure(error)
        } catch {
            return .failure(AppError.unknownError)
        }
    }
    
    func coinDetails(id: String, period: String) async -> Result<CoinDto, AppError> {
        do {
            let endpoint = ApiEndpoints.coinDetails(id: id, timePeriod: period)
            let response: CoinResponse = try await apiManager.request(endpoint: endpoint)
            guard let coin = response.data?.coin else { return .failure(AppError.coinNotFound) }
            return .success(coin)
        } catch let error as AppError {
            return .failure(error)
        } catch {
            return .failure(AppError.unknownError)
        }
    }
    
    
    func fetchFavoriteCoins() async -> Result<[Coin], AppError> {
        do {
            let coins: [Coin] = try await storage.retrieveFavorites()
            return .success(coins)
        } catch let error as AppError {
            return .failure(error)
        } catch {
            return .failure(AppError.unknownError)
        }
    }
    
    
    func favoriteCoin(coin: Coin) async throws {
        try await storage.updateWith(favorite: coin, actionType: StorageActionType.add)
    }
    
    
    func unFavoriteCoin(coin: Coin) async throws {
        try await storage.updateWith(favorite: coin, actionType: StorageActionType.remove)
    }
    
}
