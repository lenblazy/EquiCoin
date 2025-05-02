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
    let uuid: String?
    let name: String?
    let iconUrl: String?
    let price: String?
    let change: String?
    let sparkline: [String]?
    let _24hVolume : String?
    let marketCap : String?
    let symbol : String?
    let bitCoinPrice : String?
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, iconUrl, price, change, sparkline, marketCap, symbol
        case _24hVolume = "24hVolume"
        case bitCoinPrice = "btcPrice"
    }
    
}
