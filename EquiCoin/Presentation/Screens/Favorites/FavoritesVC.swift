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
        self.view.backgroundColor = .systemBackground
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
