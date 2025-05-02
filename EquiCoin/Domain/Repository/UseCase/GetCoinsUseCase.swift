//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol GetCoinsUseCase {
    func execute(page: Int, orderBy: String?) async -> Result<[Coin], AppError>
}

class GetCoinsUseCaseImpl: GetCoinsUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(page: Int, orderBy: String? = nil) async -> Result<[Coin], AppError> {
        return await repository.fetchCoins(page: page, orderBy: orderBy)
    }
    
}
