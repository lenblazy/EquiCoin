//
//  CoinsDatasourceImplTest.swift
//  EquiCoinTests
//
//  Created by Lennox Mwabonje on 01/05/2025.
//

import XCTest
@testable import EquiCoin

final class ApiCoinsDatasourceTest: XCTestCase {
    
    func test_coins_returnsListOfCoins() async throws {
        
    }
    
    //MARK: - Helpers

    private func makeSUT() -> CoinsDatasource {
        return CoinsDatasourceImpl(apiManager: makeAPIManager(), storage: makeStorage())
    }
    
    private func makeAPIManager() -> ApiManager {
        return FakeApiMAnager()
    }
    
    private func makeStorage() -> Storage {
        return FakeStorage()
    }
    
}


class FakeApiMAnager: ApiManager {
    func request<T: Codable>(endpoint: EnpointProvider) async throws -> T {
        <#code#>
    }
    
}

class FakeStorage: Storage {
    func save<T>(_ object: T, for key: String) async throws where T : Decodable, T : Encodable {
        <#code#>
    }
    
    func fetch<T>(for key: String) async throws -> T? where T : Decodable, T : Encodable {
        <#code#>
    }
    
    func delete(for key: String) async {
        <#code#>
    }
    
    
}
