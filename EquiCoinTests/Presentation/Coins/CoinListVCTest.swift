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
        XCTAssertEqual(makeSUT().title, "Coins")
    }
    
    
    func test_viewDidLoad_pageHasBlackBackground() {
        XCTAssertEqual(makeSUT().view.backgroundColor, AppColors.dark)
    }
    
    
    func test_viewDidLoad_rendersListOfCoins() {
        let sut = makeSUT()
        
    }
    
    
    // MARK: - Helpers
    private func makeSUT() -> CoinsVC {
        let sut = CoinsVC()
        _ = sut.view
        return sut
    }
    
}
