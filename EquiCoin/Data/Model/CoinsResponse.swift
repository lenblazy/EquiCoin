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
    let _24hVolume : String?
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, iconUrl, price
        case _24hVolume = "24hVolume"
    }
    
}
