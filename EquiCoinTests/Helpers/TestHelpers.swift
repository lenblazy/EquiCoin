//
//  TestHelpers.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

@testable import EquiCoin

enum TestHelpers {
    static func makeCoinDto(id: String? = nil, name: String? = nil) -> CoinDto {
        return CoinDto(uuid: id, name: name)
    }
}


