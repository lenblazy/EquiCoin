//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol RemoveFavoriteCoinUseCase {
    func execute(coin: Coin) async throws -> Void
}

class RemoveFavoriteCoinUseCaseImpl: RemoveFavoriteCoinUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    
    func execute(coin: Coin) async throws -> Void {
        return try await repository.unFavoriteCoin(coin: coin)
    }
    
}
