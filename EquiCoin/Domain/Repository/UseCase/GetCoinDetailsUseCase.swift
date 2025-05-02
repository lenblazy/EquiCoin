//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol GetCoinDetailsUseCase {
    func execute(id: String, period: String) async -> Result<Coin, AppError>
}

class GetCoinDetailsUseCaseImpl: GetCoinDetailsUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(id: String, period: String) async -> Result<Coin, AppError> {
        return await repository.coinDetails(id: id, period: period)
    }
    
}
