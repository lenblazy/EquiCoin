//
//  ECTabBarController.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class ECTabBarController: UITabBarController {
    
    private let repository: CoinsRepository
    
    init(repository: CoinsRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createCoinsNC(repository: repository), createFavoritesNC(repository: repository)]
    }
    
    private func createCoinsNC(repository: CoinsRepository) -> UINavigationController {
        let usecase: FetchCoinsUseCase = FetchCoinsUseCaseImpl(repository: repository)
        let coinsVM: CoinsVM = CoinsVM(fetchCoinsUseCase: usecase)
        let coinsVC = CoinsVC(viewModel: coinsVM)
        coinsVC.title = "Coins"
        coinsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: coinsVC)
    }
    
    private func createFavoritesNC(repository: CoinsRepository) -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
}
