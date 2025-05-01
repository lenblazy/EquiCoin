//
//  FavoritesVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private let viewModel: FavoritesVM
    
    init(viewModel: FavoritesVM) {
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
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteCoins()
    }
    

    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        showEmptyStateView(title: "Favorites", message: "No favorites yet")
    }
    
    private func setupBindings() {
        viewModel.onCoinsUpdated = { [weak self] coins in
            guard let strongSelf = self else { return }
            debugPrint("Favorite coins \(coins)")
//            strongSelf.updateUI(with: coins)
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            strongSelf.presentAlert(message: errorMessage)
        }
        
        viewModel.isLoading = { [weak self] isLoading in
            guard let strongSelf = self else { return }
            isLoading ? strongSelf.showLoadingView() : strongSelf.dismissLoadingView()
        }
    }
    
}
