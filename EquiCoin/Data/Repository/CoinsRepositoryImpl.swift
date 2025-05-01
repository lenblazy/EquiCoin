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
    
    func fetchCoins(page: Int) async -> Result<[Coin], AppError> {
        let result = await datasource.coins(page: page)
        switch result {
        case .success(let coinsDto):
            let coins = coinsDto.map { coinDto in
                Coin(id: coinDto.uuid ?? "0", name: coinDto.name ?? "", iconUrl: coinDto.iconUrl ?? "", price: coinDto.price ?? "")
            }
            return .success(coins)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchFavoriteCoins() async -> Result<[Coin], AppError> {
        return await datasource.fetchFavoriteCoins()
    }
    
    func favoriteCoin(id: String) async throws {
        debugPrint("Coin in repo")
    }
    
    func unFavoriteCoin(id: String) async throws {
        debugPrint("Coin out from repo")
    }
    
}
