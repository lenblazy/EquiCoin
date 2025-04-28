//
//  CoinsResponse.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

struct CoinsResponse: Codable {
    let status: String?
    let data: CoinsData?
}

struct CoinsData: Codable {
    let coins: [CoinDto]?
}

struct CoinDto: Codable {
    let uuid, symbol, name, color: String?
    let iconUrl: String?
    let price: String?
//    let listedAt: Int?
//    let change: String?
//    let rank: Int?
//    let sparkline: [String]?
//    let lowVolume: Bool?
//    let coinrankingURL: String?
//    let the24HVolume, btcPrice: String?
//    let contractAddresses: [String]?
//    let tier: Int?
}
