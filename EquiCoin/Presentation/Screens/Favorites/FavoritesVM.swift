//
//  CoinListViewModel.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

@MainActor
class FavoritesVM {
    var onCoinsUpdated: (([Coin]) -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    private let getFavoriteCoinsUseCase: GetFavoriteCoinsUseCase
    private let removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase
    
    init(getFavoriteCoinsUseCase: GetFavoriteCoinsUseCase, removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase) {
        self.getFavoriteCoinsUseCase = getFavoriteCoinsUseCase
        self.removeFavoriteCoinUseCase = removeFavoriteCoinUseCase
    }
    
    func fetchFavoriteCoins() {
        Task {
            self.isLoading?(true)
            let result = await getFavoriteCoinsUseCase.execute()
            self.isLoading?(false)
            switch result {
            case .success(let coins):
                self.onCoinsUpdated?(coins)
            case .failure(let error):
                self.onError?(error.rawValue)
            }
        }
    }
    
    func unFavoriteCoin(coin: Coin) {
        Task {
            do {
                try await removeFavoriteCoinUseCase.execute(coin: coin)
                fetchFavoriteCoins()
            } catch let error as AppError {
                self.onError?(error.rawValue)
            } catch {
                self.onError?(AppError.unknownError.localizedDescription)
            }
        }
    }
    
}
