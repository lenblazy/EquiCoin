//
//  CoinsRepository.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

struct CoinsRepositoryImpl: CoinsRepository {
    
    private let datasource: CoinsDatasource
    
    init(datasource: CoinsDatasource) {
        self.datasource = datasource
    }
    
    
    func fetchCoins(page: Int, orderBy: String? = nil) async -> Result<[Coin], AppError> {
        let result = await datasource.coins(page: page, orderBy: orderBy)
        switch result {
        case .success(let coinsDto):
            let coins = coinsDto.map { $0.toDomainModel() }
            return .success(coins)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    func coinDetails(id: String, period: String) async -> Result<Coin, AppError> {
        let result = await datasource.coinDetails(id: id, period: period)
        switch result {
        case .success(let coinDto):
            return .success(coinDto.toDomainModel())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    func fetchFavoriteCoins() async -> Result<[Coin], AppError> {
        return await datasource.fetchFavoriteCoins()
    }
    
    func favoriteCoin(coin: Coin) async throws {
        try await datasource.favoriteCoin(coin: coin)
    }
    
    func unFavoriteCoin(coin: Coin) async throws {
        try await datasource.unFavoriteCoin(coin: coin)
    }
    
}
