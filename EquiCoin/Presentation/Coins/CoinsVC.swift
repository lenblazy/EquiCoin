//
//  CoinListVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class CoinsVC: UIViewController {
    
    private let viewModel: CoinsVM
    
    init(viewModel: CoinsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchCoins()
    }
    
    
    private func configureUI() {
        self.view.backgroundColor = AppColors.dark
        self.title = "Coins"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupBindings() {
        viewModel.onCoinsUpdated = { [weak self] coins in
            debugPrint("Counts count \(coins.count) with values coins")
        }
        
        viewModel.onError = { [weak self] errorMessage in
            debugPrint("Error occurred: \(errorMessage)")
        }
    }
    
}
