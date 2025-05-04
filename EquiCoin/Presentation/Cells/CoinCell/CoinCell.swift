//
//  CoinCell.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class CoinCell: UITableViewCell {
    
    static let reuseID = "FollowerCell"
    
    let coinLabel       = AppTitleLabel()
    let priceLabel      = AppBodyLabel()
    let minCapLabel     = AppBodyLabel()
    let maxCapLabel     = AppTitleLabel(textAlignment: .left, fontSize: 14, color: AppColors.grayDark)
    let coinImageView   = AppCacheImageView()
    let svgCoinIV       = SvgCacheImageView()
    var stackMain       = UIStackView()
    var stackPerform    = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.backgroundColor = AppColors.dark
        contentView.addSubview(stackMain)
        contentView.addSubview(stackPerform)
        contentView.addSubview(coinImageView)
        contentView.addSubview(svgCoinIV)
        
        stackMain.axis      = .vertical
        stackMain.spacing   = 4
        stackMain.addArrangedSubview(coinLabel)
        stackMain.addArrangedSubview(priceLabel)
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        
        stackPerform.axis      = .vertical
        stackPerform.spacing   = 4
        stackPerform.alignment = .trailing
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
            
            svgCoinIV.topAnchor.constraint(equalTo: topAnchor, constant: paddingV),
            svgCoinIV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingV),
            svgCoinIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingH),
            svgCoinIV.widthAnchor.constraint(equalTo: svgCoinIV.heightAnchor),
            
            stackMain.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackMain.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: paddingH),
            stackMain.trailingAnchor.constraint(equalTo: stackPerform.leadingAnchor, constant: -paddingH),
            
            stackPerform.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackPerform.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingH),
        ])
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        svgCoinIV.image     = nil
        coinImageView.image = nil
    }
    
    
    func set(coin: Coin) {
        coinLabel.text          = coin.name
        priceLabel.text         = coin.price
        minCapLabel.text        = coin.volume
        maxCapLabel.text        = "24H Volume:"
        coinImageView.isHidden  = false
        svgCoinIV.isHidden      = false
        
        if coin.iconUrl.contains(".svg") {
            coinImageView.isHidden = true
            svgCoinIV.loadImage(from: coin.iconUrl)
            return
        }
        svgCoinIV.isHidden = true
        coinImageView.loadImage(from: coin.iconUrl)
    }
    
}
