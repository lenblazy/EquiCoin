//
//  CoreDatasourceImplTest.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 02/05/2025.
//


import XCTest
@testable import EquiCoin

final class CoinsDatasourceImplTests: XCTestCase {

    var mockApiManager: MockApiManager!
    var mockStorage: MockStorageManager!
    var datasource: CoinsDatasourceImpl!

    override func setUp() {
        super.setUp()
        mockApiManager = MockApiManager()
        mockStorage = MockStorageManager()
        datasource = CoinsDatasourceImpl(apiManager: mockApiManager, storage: mockStorage)
    }

    // MARK: - coins(page:orderBy:)

    func testCoins_successfulFetch_returnsCoins() async {
        let expectedCoin = [TestHelpers.makeCoinDto()]
        mockApiManager.resultToReturn = CoinsResponse(data: .init(coins: expectedCoin))

        let result = await datasource.coins(page: 1)
        switch result {
        case .success(let coins):
            XCTAssertEqual(coins.count, 1)
        case .failure:
            XCTFail("Expected success")
        }
    }

    func testCoins_emptyList_returnsNoCoinsFound() async {
        mockApiManager.resultToReturn = CoinsResponse(data: .init(coins: []))
        let result = await datasource.coins(page: 1)
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure(let error):
            XCTAssertEqual(error, AppError.noCoinsFound)
        }
    }

}

final class MockApiManager: ApiManager {
    var resultToReturn: Any?
    var errorToThrow: Error?

    func request<T>(endpoint: EnpointProvider) async throws -> T where T: Decodable {
        if let error = errorToThrow {
            throw error
        }
        guard let result = resultToReturn as? T else {
            throw AppError.invalidResponse
        }
        return result
    }
}

final class MockStorageManager: StorageManager {
    var favoritesToReturn: [Coin] = []
    var errorToThrow: Error?
    var lastAction: StorageActionType?

    func retrieveFavorites() async throws -> [Coin] {
        if let error = errorToThrow { throw error }
        return favoritesToReturn
    }

    func updateWith(favorite: Coin, actionType: StorageActionType) async throws {
        if let error = errorToThrow { throw error }
        lastAction = actionType
    }
}
