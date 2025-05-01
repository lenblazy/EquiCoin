//
//  FetchCoinsUseCase.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol RemoveFavoriteCoinUseCase {
    func execute(id: String) async throws -> Void
}

class RemoveFavoriteCoinUseCaseImpl: RemoveFavoriteCoinUseCase {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
    }
    
    func execute(id: String) async throws -> Void {
        return try await repository.unFavoriteCoin(id: id)
    }
    
}
