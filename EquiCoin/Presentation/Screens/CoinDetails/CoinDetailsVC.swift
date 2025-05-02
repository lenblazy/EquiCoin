//
//  CoinVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class CoinDetailsVC: UIViewController {
    
    let labelPrice = AppTitleLabel(textAlignment: .center, fontSize: 24, color: AppColors.light)
    
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = coin.name
    }

}
