//
//  CoinsRepository.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsRepository {
    
    func fetchCoins(page: Int) async -> Result<[Coin], AppError>
    func fetchFavoriteCoins() async -> Result<[Coin], AppError>
    func favoriteCoin(id: String) async throws -> Void
    func unFavoriteCoin(id: String) async throws -> Void
    
}
