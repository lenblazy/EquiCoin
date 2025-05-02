//
//  Coin.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import Foundation

struct Coin: Hashable, Codable {
    let id: String
    let name: String
    let iconUrl: String
    let price: String
    let change: String
    let volume: String
    let sparkLine: [Double]
    let marketCap: String
    let bitCoinPrice: String
    let symbol: String
    let circulatingSupply: String
    let allTimeHigh: String
}
