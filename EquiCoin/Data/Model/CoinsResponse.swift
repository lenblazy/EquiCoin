//
//  CoinsResponse.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

struct CoinsResponse: Codable {
    var status: String? = nil
    var data: CoinsData? = nil
}

struct CoinsData: Codable {
    var coins: [CoinDto]? = nil
}

