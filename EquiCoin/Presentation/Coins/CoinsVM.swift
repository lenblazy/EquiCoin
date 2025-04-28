//
//  CoinListViewModel.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

@MainActor
class CoinsVM {
    var onCoinsUpdated: (([Coin]) -> Void)?
    var onError: ((String) -> Void)?
    
    private let fetchCoinsUseCase: FetchCoinsUseCase
    
    init(fetchCoinsUseCase: FetchCoinsUseCase) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
    }
    
    func fetchCoins() {
        Task {
            let result = await fetchCoinsUseCase.execute()
            switch result {
            case .success(let coins):
                self.onCoinsUpdated?(coins)
            case .failure(let error):
                self.onError?(error.rawValue)
            }
        }
        
    }
}
