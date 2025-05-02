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
    let volume: String
}
