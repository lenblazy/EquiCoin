//
//  FavoritesVMTest.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import XCTest
@testable import EquiCoin

@MainActor
final class FavoritesVMTests: XCTestCase {

    var mockGetFavoritesUseCase: MockGetFavoriteCoinsUseCase!
    var mockRemoveFavoriteUseCase: MockRemoveFavoriteCoinUseCase!
    var viewModel: FavoritesVM!

    override func setUp() {
        super.setUp()
        mockGetFavoritesUseCase = MockGetFavoriteCoinsUseCase()
        mockRemoveFavoriteUseCase = MockRemoveFavoriteCoinUseCase()
        viewModel = FavoritesVM(
            getFavoriteCoinsUseCase: mockGetFavoritesUseCase,
            removeFavoriteCoinUseCase: mockRemoveFavoriteUseCase
        )
    }

    func testFetchFavoriteCoins_success_callsOnCoinsUpdated() async {
        let expectation = expectation(description: "onCoinsUpdated called")
        let expectedCoin = TestHelpers.makeCoinDto().toDomainModel()
        mockGetFavoritesUseCase.result = .success([expectedCoin])

        viewModel.onCoinsUpdated = { coins in
            XCTAssertEqual(coins.count, 1)
            XCTAssertEqual(coins.first?.id, expectedCoin.id)
            expectation.fulfill()
        }

        viewModel.fetchFavoriteCoins()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testFetchFavoriteCoins_failure_callsOnError() async {
        let expectation = expectation(description: "onError called")
        mockGetFavoritesUseCase.result = .failure(.noCoinsFound)

        viewModel.onError = { error in
            XCTAssertEqual(error, AppError.noCoinsFound.rawValue)
            expectation.fulfill()
        }

        viewModel.fetchFavoriteCoins()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testUnFavoriteCoin_success_fetchesUpdatedFavorites() async {
        let coin = TestHelpers.makeCoinDto().toDomainModel()
        mockRemoveFavoriteUseCase.shouldSucceed = true

        let expectation = expectation(description: "onCoinsUpdated called after unfavorite")
        mockGetFavoritesUseCase.result = .success([])

        viewModel.onCoinsUpdated = { coins in
            XCTAssertEqual(coins.count, 0)
            expectation.fulfill()
        }

        viewModel.unFavoriteCoin(coin: coin)
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testUnFavoriteCoin_failure_callsOnError() async {
        let coin = TestHelpers.makeCoinDto().toDomainModel()
        mockRemoveFavoriteUseCase.shouldSucceed = false

        let expectation = expectation(description: "onError called on unfavorite")
        viewModel.onError = { error in
            XCTAssertEqual(error, AppError.unknownError.rawValue)
            expectation.fulfill()
        }

        viewModel.unFavoriteCoin(coin: coin)
        await fulfillment(of: [expectation], timeout: 1)
    }
}

final class MockGetFavoriteCoinsUseCase: GetFavoriteCoinsUseCase {
    var result: Result<[Coin], AppError> = .success([])

    func execute() async -> Result<[Coin], AppError> {
        return result
    }
}

final class MockRemoveFavoriteCoinUseCase: RemoveFavoriteCoinUseCase {
    var shouldSucceed = true

    func execute(coin: Coin) async throws {
        if !shouldSucceed {
            throw AppError.unknownError
        }
    }
}
