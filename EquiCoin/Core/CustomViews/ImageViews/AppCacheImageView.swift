//
//  AppUIImageView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class AppCacheImageView: UIImageView {
    
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
   
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    func loadImage(from endPoint: String) {
        Task {
            let image = await UIImage.cacheImage(from: endPoint)
            self.image = image
        }
    }
    
    
    private func configure() {
        self.clipsToBounds          = true
        self.image                  = AppImages.placeHolder
        
        self.translatesAutoresizingMaskIntoConstraints = false
        contentMode         = .scaleAspectFill
        layer.masksToBounds = true
    }
}





