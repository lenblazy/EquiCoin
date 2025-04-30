//
//  FavoritesVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        showEmptyStateView(title: "Favorites", message: "No favorites yet")
    }
}
