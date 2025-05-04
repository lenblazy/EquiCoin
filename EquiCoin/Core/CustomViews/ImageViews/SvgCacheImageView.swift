//
//  AppUIImageView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit
import SVGKit

class SvgCacheImageView: SVGKFastImageView {
    
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
            guard let image = await SVGKImage.cacheImage(from: endPoint) else {
                return
            }
            
            self.image = image
        }
    }
    
    
    private func configure() {
        clipsToBounds       = true
        contentMode         = .scaleAspectFill
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}





