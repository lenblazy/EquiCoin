//
//  CoinsResponse.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

struct CoinResponse: Codable {
    var status: String? = nil
    var data: CoinData? = nil
}

struct CoinData: Codable {
    var coin: CoinDto? = nil
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

extension CoinDto {
    func toDomainModel() -> Coin {
        return Coin(
            id: self.uuid ?? "0",
            name: self.name ?? "",
            iconUrl: self.iconUrl ?? "",
            price: (self.price ?? "").formatPrice(),
            change: "\(self.change ?? "0") %",
            volume: self._24hVolume ?? "",
            sparkLine: (self.sparkline ?? []).map { Double($0 ?? "0") ?? 0.0 },
            marketCap: self.marketCap ?? "",
            bitCoinPrice: self.bitCoinPrice ?? "",
            symbol: self.symbol ?? ""
        )
    }
}
