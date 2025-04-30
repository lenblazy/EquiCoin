//
//  CoinListVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class CoinsVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var page = 0
    var hasMoreCoins = true
    var isLoadingMoreCoins = false
    var coins: [Coin] = []
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Coin>!
    
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
        configureCollectionView()
    }
    
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view, height: CGFloat(70)))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(CoinCell.self, forCellWithReuseIdentifier: CoinCell.reuseID)
        configureDataSource()
    }
    
    
    private func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Coin>(collectionView: collectionView, cellProvider: { collectionView, indexPath, coin in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCell.reuseID, for: indexPath) as! CoinCell
            cell.set(coin: coin)
            return cell
        })
    }
    
    
    private func updateData(on coins: [Coin]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Coin>()
        snapshot.appendSections([.main])
        snapshot.appendItems(coins)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    
    private func updateUI(with coins: [Coin]){
        if coins.count < pagCount { self.hasMoreCoins = false }
        self.coins.append(contentsOf: coins)
        if self.coins.isEmpty {
            showEmptyStateView(title: "Coins", message: "No coins found")
            return
        }
        
        updateData(on: self.coins)
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


extension CoinsVC: UICollectionViewDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = CoinDetailsVC()
        destVC.coin = coins[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}
