//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol FetchCoinsUseCase {
    func execute(page: Int) async -> Result<[Coin], AppError>
}

class FetchCoinsUseCaseImpl: FetchCoinsUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(page: Int) async -> Result<[Coin], AppError> {
        return await repository.fetchCoins(page: page)
    }
    
}
