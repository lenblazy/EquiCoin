//
//  CoinListVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class CoinsVC: UIViewController {
    
    var page = 0
    var hasMoreCoins = true
    var isLoadingMoreCoins = false
    var coins: [Coin] = []
    
    let tableView = UITableView()
    
    private let pagCount = 20
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
        viewModel.fetchCoins(page: page)
    }
    
    
    private func configureUI() {
        view.backgroundColor = AppColors.dark
        title = "Coins"
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
    
    
    private func updateUI(with coins: [Coin]){
        if coins.count < pagCount { self.hasMoreCoins = false }
        self.coins.append(contentsOf: coins)
        if self.coins.isEmpty {
            showEmptyStateView(title: "Coins", message: "No coins found")
            return
        }
        
        tableView.reloadData()
    }
    
    
    private func setupBindings() {
        viewModel.onCoinsUpdated = { [weak self] coins in
            guard let strongSelf = self else { return }
            strongSelf.updateUI(with: coins)
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


extension CoinsVC: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreCoins, !isLoadingMoreCoins else { return }
            if coins.count >= 100 {
                presentAlert(message: "You have loaded a Maximum of 100 coins")
                return
            }
            page += 1
            viewModel.fetchCoins(page: page)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC  = CoinDetailsVC()
        destVC.coin = coins[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension CoinsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseID) as! CoinCell
        let coin = coins[indexPath.row]
        cell.set(coin: coin)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let coin = self.coins[indexPath.row]
            viewModel.favorite(coin: coin)
            completionHandler(true)
        }

        favoriteAction.backgroundColor  = AppColors.brandDark
        favoriteAction.image            = AppImages.favorite

        let configuration               = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
