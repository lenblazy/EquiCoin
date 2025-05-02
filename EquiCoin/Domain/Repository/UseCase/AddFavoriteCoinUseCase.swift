//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol AddFavoriteCoinUseCase {
    func execute(coin: Coin) async throws -> Void
}

class AddFavoriteCoinUseCaseImpl: AddFavoriteCoinUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(coin: Coin) async throws -> Void {
        return try await repository.favoriteCoin(coin: coin)
    }
    
}
