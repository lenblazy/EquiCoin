//
//  CoinCell.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    private let coinVM: CoinVM
    
    init(coinVM: CoinVM) {
        self.coinVM = coinVM
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
    }
    
    
    
}
