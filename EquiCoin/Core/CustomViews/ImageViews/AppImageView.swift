//
//  AppUIImageView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class AppImageView: UIImageView {

//    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    
    private func configure() {
        self.clipsToBounds          = true
        self.image                  = AppImages.placeHolder
    
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
