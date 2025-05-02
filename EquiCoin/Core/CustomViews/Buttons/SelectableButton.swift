//
//  SelectableButton.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import UIKit

class SelectableButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            updateButton()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(title: String) {
        self.init(frame: .zero)
        configuration?.title = title
    }
    
    
    private func configure() {
        configuration                       = .filled()
        configuration?.baseBackgroundColor  = AppColors.brand.withAlphaComponent(0.3)
        configuration?.baseForegroundColor  = AppColors.grayLight
        configuration?.cornerStyle          = .fixed
        configuration?.imagePadding         = 8
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func updateButton() {
        configuration?.image = isSelected ? UIImage(systemName: "checkmark") : nil
    }
    
}
