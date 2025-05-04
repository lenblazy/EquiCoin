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
    
    let tableView       = UITableView()
    let buttonPrice     = SelectableButton(title: "Highest Price")
    let buttonVolume    = SelectableButton(title: "Best 24H Performance")
    
    private let pagCount = 20
    private let viewModel: CoinsVMProtocol
    
    init(viewModel: CoinsVMProtocol) {
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
        viewModel.fetchCoins(page: page, orderBy: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("View will disappear")
        dismissLoadingView()
    }
    
    
    private func configureUI() {
        view.backgroundColor = AppColors.dark
        title = "Coins"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        [buttonPrice, buttonVolume].forEach {
            view.addSubview($0)
            $0.addTarget(self, action: #selector(filterResults), for: .touchUpInside)
        }
        
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            buttonPrice.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            buttonPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            buttonPrice.trailingAnchor.constraint(equalTo: buttonVolume.leadingAnchor, constant: -padding),
            buttonPrice.heightAnchor.constraint(equalToConstant: 50),
            
            buttonVolume.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            buttonVolume.leadingAnchor.constraint(equalTo: buttonPrice.trailingAnchor, constant: padding),
            buttonVolume.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            buttonVolume.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: buttonPrice.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
    
    @objc func filterResults(_ sender: SelectableButton) {
        [buttonPrice, buttonVolume].forEach { $0.isSelected = ($0 == sender) ? !$0.isSelected : false }
        page = 0
        
        let sort: String?
        
        if buttonPrice.isSelected {
            sort = "price"
        }
        else if buttonVolume.isSelected {
            sort = "24hVolume"
        }
        else {
            sort = nil
        }
        
        viewModel.fetchCoins(page: page, orderBy: sort)
        coins = []
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight         = 80
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.separatorColor    = AppColors.grayLight
        tableView.backgroundColor   = AppColors.dark
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
            viewModel.fetchCoins(page: page, orderBy: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = CoinDetailsVC(coin: coins[indexPath.row])
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
