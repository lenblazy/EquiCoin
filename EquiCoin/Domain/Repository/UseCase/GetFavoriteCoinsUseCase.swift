//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol GetFavoriteCoinsUseCase {
    func execute(page: Int) async -> Result<[Coin], AppError>
}

class GetFavoriteCoinsUseCaseImpl: GetCoinsUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(page: Int) async -> Result<[Coin], AppError> {
        return await repository.fetchCoins(page: page)
    }
    
}
