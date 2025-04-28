//
//  CoinsRepository.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

protocol CoinsRepository {
    
    func fetchCoins() async -> Result<[Coin], AppError>
    
}
