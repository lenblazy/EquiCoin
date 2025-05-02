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
        configureUI()
    }
    
    
    private func configureUI() {
        UINavigationBar.appearance().tintColor = AppColors.brand
        tabBar.barTintColor = AppColors.dark
        tabBar.unselectedItemTintColor = AppColors.grayDark
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.dark
        appearance.titleTextAttributes = [
            .foregroundColor: AppColors.light,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: AppColors.light,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        viewControllers = [createCoinsNC(repository: repository), createFavoritesNC(repository: repository)]
    }
    
    private func createCoinsNC(repository: CoinsRepository) -> UINavigationController {
        let usecase: GetCoinsUseCase = GetCoinsUseCaseImpl(repository: repository)
        let addFavoriteCoinUseCase: AddFavoriteCoinUseCase = AddFavoriteCoinUseCaseImpl(repository: repository)
        let coinsVM = CoinsVM(fetchCoinsUseCase: usecase, addFavoriteCoinUseCase: addFavoriteCoinUseCase)
        let coinsVC = CoinsVC(viewModel: coinsVM)
        coinsVC.tabBarItem = UITabBarItem(title: "Home", image: AppImages.home, tag: 0)
        
        return UINavigationController(rootViewController: coinsVC)
    }
    
    private func createFavoritesNC(repository: CoinsRepository) -> UINavigationController {
        let getFavoriteCoinsUseCase: GetFavoriteCoinsUseCase = GetFavoriteCoinsUseCaseImpl(repository: repository)
        let removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase = RemoveFavoriteCoinUseCaseImpl(repository: repository)
        let vm = FavoritesVM(getFavoriteCoinsUseCase: getFavoriteCoinsUseCase, removeFavoriteCoinUseCase: removeFavoriteCoinUseCase)
        let favoritesVC = FavoritesVC(viewModel: vm)
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
}
