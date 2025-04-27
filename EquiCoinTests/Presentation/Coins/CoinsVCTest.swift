//
//  CoinListVCTest.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import XCTest
@testable import EquiCoin

final class CoinListVCTest: XCTestCase {
    
    func test_viewDidLoad_rendersHeaderPage() {
        let sut = makeSUT()
        
    }
    
    
    // MARK: - Helpers
    func makeSUT() -> CoinListVC {
        let sut = CoinListVC()
        _ = sut.view
        return sut
    }
    
}
