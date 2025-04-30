//
//  CoinCell.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let coinLabel       = AppTitleLabel()
    let priceLabel      = AppBodyLabel()
    let minCapLabel     = AppBodyLabel()
    let maxCapLabel     = AppBodyLabel()
    let coinImageView   = AppImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.backgroundColor = AppColors.brand.withAlphaComponent(0.1)
        contentView.addSubview(coinLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(minCapLabel)
        contentView.addSubview(maxCapLabel)
        contentView.addSubview(coinImageView)
        
        let paddingH: CGFloat = 16
        let paddingV: CGFloat = 8
        
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: topAnchor, constant: paddingV),
            coinImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingV),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingH),
            coinImageView.widthAnchor.constraint(equalTo: coinImageView.heightAnchor),
            
            coinLabel.topAnchor.constraint(equalTo: topAnchor, constant: paddingV),
            coinLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: paddingH),
            coinLabel.heightAnchor.constraint(equalToConstant: 18),
            
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingV),
            priceLabel.leadingAnchor.constraint(equalTo: coinLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 16),
            
            maxCapLabel.topAnchor.constraint(equalTo: topAnchor, constant: paddingV),
            maxCapLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingH),
            maxCapLabel.heightAnchor.constraint(equalToConstant: 16),
            
            minCapLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingV),
            minCapLabel.trailingAnchor.constraint(equalTo: maxCapLabel.trailingAnchor),
            minCapLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
        
    }
    
    
    func set(coin: Coin) {
//        coinImageView.text = coin.name
        coinLabel.text = coin.name
        priceLabel.text = coin.price
        maxCapLabel.text = coin.price
        minCapLabel.text = coin.price
    }
    
}
