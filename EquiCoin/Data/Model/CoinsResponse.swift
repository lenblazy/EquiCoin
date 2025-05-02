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

struct CoinDto: Codable {
    var uuid: String? = nil
    var name: String? = nil
    var iconUrl: String? = nil
    var price: String? = nil
    var change: String? = nil
    var sparkline: [String?]? = nil
    var _24hVolume : String? = nil
    var marketCap : String? = nil
    var symbol : String? = nil
    var bitCoinPrice : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, iconUrl, price, change, sparkline, marketCap, symbol
        case _24hVolume = "24hVolume"
        case bitCoinPrice = "btcPrice"
    }
    
}
