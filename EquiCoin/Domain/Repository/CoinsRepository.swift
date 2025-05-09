//
//  CoinsRepository.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsRepository {
    
    func fetchCoins(page: Int, orderBy: String?) async -> Result<[Coin], AppError>
    func coinDetails(id: String, period: String) async -> Result<Coin, AppError>
    func fetchFavoriteCoins() async -> Result<[Coin], AppError>
    func favoriteCoin(coin: Coin) async throws -> Void
    func unFavoriteCoin(coin: Coin) async throws -> Void
    
}
