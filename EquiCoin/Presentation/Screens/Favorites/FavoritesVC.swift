//
//  FavoritesVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var coins: [Coin] = []
    
    let tableView = UITableView()
    
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
        configureTableView()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 80
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.separatorColor    = AppColors.grayLight
        tableView.backgroundColor   = AppColors.dark
        
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseID)
    }
    
    
    private func setupBindings() {
        viewModel.onCoinsUpdated = { [weak self] coins in
            guard let strongSelf = self else { return }
            strongSelf.coins = coins
            strongSelf.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            strongSelf.showEmptyStateView(title: "Favorites", message: errorMessage)
        }
        
        viewModel.isLoading = { [weak self] isLoading in
            guard let strongSelf = self else { return }
            isLoading ? strongSelf.showLoadingView() : strongSelf.dismissLoadingView()
        }
    }
    
}


extension FavoritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC  = CoinDetailsVC(coin: coins[indexPath.row])
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseID) as! CoinCell
        let coin = coins[indexPath.row]
        cell.set(coin: coin)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.unFavoriteCoin(coin: coins[indexPath.row])
    }
    
}
