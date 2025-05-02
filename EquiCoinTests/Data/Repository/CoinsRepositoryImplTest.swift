//
//  CoinsRepositoryImplTest.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import XCTest
@testable import EquiCoin

final class CoinsRepositoryImplTests: XCTestCase {
    
    var mockDatasource: MockCoinsDatasource!
    var repository: CoinsRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockDatasource = MockCoinsDatasource()
        repository = CoinsRepositoryImpl(datasource: mockDatasource)
    }
    
    func testFetchCoins_success() async {
        mockDatasource.coinsResult = .success([makeCoinDto()])
        
        let result = await repository.fetchCoins(page: 1)
        
        switch result {
        case .success(let coins):
            XCTAssertEqual(coins.count, 1)
        case .failure:
            XCTFail("Expected success")
        }
    }
    
    func testFetchCoins_failure() async {
        mockDatasource.coinsResult = .failure(AppError.invalidData)
        
        let result = await repository.fetchCoins(page: 1)
        
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure(let error):
            XCTAssertEqual(error, AppError.invalidData)
        }
    }
    
    func testCoinDetails_success() async {
        mockDatasource.coinDetailsResult = .success(makeCoinDto(name: "Ethereum"))
        
        let result = await repository.coinDetails(id: "", period: "")
        
        switch result {
        case .success(let coin):
            XCTAssertEqual(coin.name, "Ethereum")
        case .failure:
            XCTFail("Expected success")
        }
    }
    
    func testCoinDetails_failure() async {
        mockDatasource.coinDetailsResult = .failure(.coinNotFound)
        
        let result = await repository.coinDetails(id: "", period: "")
        
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure(let error):
            XCTAssertEqual(error, .coinNotFound)
        }
    }
    
    func testFetchFavoriteCoins_success() async {
        mockDatasource.favoriteCoinsResult = .success([makeCoinDto(id: "btc").toDomainModel()])
        
        let result = await repository.fetchFavoriteCoins()
        
        switch result {
        case .success(let coins):
            XCTAssertEqual(coins.count, 1)
            XCTAssertEqual(coins.first?.id, "btc")
        case .failure:
            XCTFail("Expected success")
        }
    }
    
    func testFavoriteCoin_callsDatasource() async throws {
        try await repository.favoriteCoin(coin: makeCoinDto(id: "btc").toDomainModel())
        XCTAssertEqual(mockDatasource.lastFavoriteCoin?.id, "btc")
        XCTAssertEqual(mockDatasource.lastFavoriteAction, .add)
    }
    
    func testUnFavoriteCoin_callsDatasource() async throws {
        try await repository.unFavoriteCoin(coin: makeCoinDto(id: "eth").toDomainModel())
        
        XCTAssertEqual(mockDatasource.lastFavoriteCoin?.id, "eth")
        XCTAssertEqual(mockDatasource.lastFavoriteAction, .remove)
    }
    
    func makeCoinDto(id: String? = nil, name: String? = nil) -> CoinDto {
        return CoinDto(uuid: id, name: name)
    }
    
}


final class MockCoinsDatasource: CoinsDatasource {
    
    var coinsResult: Result<[CoinDto], AppError> = .success([])
    var coinDetailsResult: Result<CoinDto, AppError> = .success(CoinDto())
    var favoriteCoinsResult: Result<[Coin], AppError> = .success([])
    
    var lastFavoriteCoin: Coin?
    var lastFavoriteAction: StorageActionType?
    
    func coins(page: Int, orderBy: String?) async -> Result<[CoinDto], AppError> {
        return coinsResult
    }
    
    func coinDetails(id: String, period: String) async -> Result<CoinDto, AppError> {
        return coinDetailsResult
    }
    
    func fetchFavoriteCoins() async -> Result<[Coin], AppError> {
        return favoriteCoinsResult
    }
    
    func favoriteCoin(coin: Coin) async throws {
        lastFavoriteCoin = coin
        lastFavoriteAction = .add
    }
    
    func unFavoriteCoin(coin: Coin) async throws {
        lastFavoriteCoin = coin
        lastFavoriteAction = .remove
    }
}
