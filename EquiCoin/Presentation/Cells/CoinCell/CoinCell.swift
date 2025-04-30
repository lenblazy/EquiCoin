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
    let coinImageView   = AppCacheImageView()
    var stackMain       = UIStackView()
    var stackPerform    = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.backgroundColor = AppColors.brand.withAlphaComponent(0.1)
        contentView.addSubview(stackMain)
        contentView.addSubview(stackPerform)
        contentView.addSubview(coinImageView)
        
        stackMain.axis      = .vertical
        stackMain.spacing   = 4
        stackMain.addArrangedSubview(coinLabel)
        stackMain.addArrangedSubview(priceLabel)
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackPerform.axis      = .vertical
        stackPerform.spacing   = 4
        stackPerform.addArrangedSubview(maxCapLabel)
        stackPerform.addArrangedSubview(minCapLabel)
        stackPerform.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingH: CGFloat = 16
        let paddingV: CGFloat = 8
        
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: topAnchor, constant: paddingV),
            coinImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingV),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingH),
            coinImageView.widthAnchor.constraint(equalTo: coinImageView.heightAnchor),
            
            stackMain.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackMain.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: paddingH),
            
            stackPerform.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackPerform.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingH),
        ])
        
    }
    
    
    func set(coin: Coin) {
        coinImageView.loadImage(from: coin.iconUrl)
        coinLabel.text      = coin.name
        priceLabel.text     = coin.price
        maxCapLabel.text    = coin.price
        minCapLabel.text    = coin.price
    }
    
}
