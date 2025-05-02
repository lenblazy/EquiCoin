//
//  CoinListViewModel.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

@MainActor
class CoinDetailsVM {
    var onCoinUpdated: ((Coin) -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    private let fetchCoinDetails: GetCoinDetailsUseCase

    init(fetchCoinDetails: GetCoinDetailsUseCase) {
        self.fetchCoinDetails = fetchCoinDetails
    }
    
    func fetchCoinDetails(coinID: String, period: String) {
        Task {
            self.isLoading?(true)
            let result = await fetchCoinDetails.execute(id: coinID, period: period)
            self.isLoading?(false)
            switch result {
            case .success(let coin):
                self.onCoinUpdated?(coin)
            case .failure(let error):
                self.onError?(error.rawValue)
            }
        }
    }
   
}
