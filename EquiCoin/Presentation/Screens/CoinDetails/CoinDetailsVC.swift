//
//  CoinVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class CoinDetailsVC: UIViewController {
    
    var coin: Coin!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = coin.name
    }

}
