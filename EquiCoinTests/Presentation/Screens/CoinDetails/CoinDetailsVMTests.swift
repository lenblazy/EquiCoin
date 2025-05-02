//
//  CoinDetailsVMTests.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import XCTest
@testable import EquiCoin

@MainActor
final class CoinDetailsVMTests: XCTestCase {

    var mockGetCoinDetailsUseCase: MockGetCoinDetailsUseCase!
    var viewModel: CoinDetailsVM!

    override func setUp() {
        super.setUp()
        mockGetCoinDetailsUseCase = MockGetCoinDetailsUseCase()
        viewModel = CoinDetailsVM(fetchCoinDetails: mockGetCoinDetailsUseCase)
    }

    func testFetchCoinDetails_success_callsOnCoinUpdated() async {
        let expectedCoin = TestHelpers.makeCoinDto().toDomainModel()
        mockGetCoinDetailsUseCase.result = .success(expectedCoin)

        let expectation = expectation(description: "onCoinUpdated called")
        viewModel.onCoinUpdated = { coin in
            XCTAssertEqual(coin.id, expectedCoin.id)
            XCTAssertEqual(coin.name, expectedCoin.name)
            expectation.fulfill()
        }

        viewModel.fetchCoinDetails(coinID: "btc", period: "24h")
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testFetchCoinDetails_failure_callsOnError() async {
        mockGetCoinDetailsUseCase.result = .failure(AppError.coinNotFound)

        let expectation = expectation(description: "onError called")
        viewModel.onError = { errorMessage in
            XCTAssertEqual(errorMessage, AppError.coinNotFound.rawValue)
            expectation.fulfill()
        }

        viewModel.fetchCoinDetails(coinID: "btc", period: "7d")
        await fulfillment(of: [expectation], timeout: 1)
    }
}

final class MockGetCoinDetailsUseCase: GetCoinDetailsUseCase {
    var result: Result<Coin, AppError> = .failure(.unknownError)

    func execute(id: String, period: String) async -> Result<Coin, AppError> {
        return result
    }
}
