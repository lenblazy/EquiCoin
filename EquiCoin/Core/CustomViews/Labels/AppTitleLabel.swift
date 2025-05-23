//
//  AppTitleLabel.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class AppTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, color: UIColor) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textColor = color
    }
    
    
    private func configure() {
        textColor                   = AppColors.grayLight
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        font                        = UIFont.systemFont(ofSize: 18, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
}
