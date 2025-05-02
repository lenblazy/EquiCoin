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
    var isLoading: ((Bool) -> Void)?
    
    private let fetchCoinsUseCase: GetCoinsUseCase
    private let addFavoriteCoinUseCase: AddFavoriteCoinUseCase

    init(fetchCoinsUseCase: GetCoinsUseCase,addFavoriteCoinUseCase: AddFavoriteCoinUseCase) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.addFavoriteCoinUseCase = addFavoriteCoinUseCase
    }
    
    func fetchCoins(page: Int) {
        Task {
            self.isLoading?(true)
            let result = await fetchCoinsUseCase.execute(page: page)
            self.isLoading?(false)
            switch result {
            case .success(let coins):
                self.onCoinsUpdated?(coins)
            case .failure(let error):
                self.onError?(error.rawValue)
            }
        }
        
    }
    
    func favoriteCoin(coin: Coin) {
        Task {
            do {
                try await addFavoriteCoinUseCase.execute(coin: coin)
            } catch let error as AppError {
                self.onError?(error.rawValue)
            } catch {
                self.onError?(AppError.unknownError.localizedDescription)
            }
        }
    }
}
