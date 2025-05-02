//
//  StatView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 02/05/2025.
//

import UIKit

class StatView: UIView {
    
    private let labelTitle  = AppBodyLabel(textAlignment: .left, fontSize: 16, color: AppColors.grayDark)
    private let labelValue  = AppTitleLabel(textAlignment: .right, fontSize: 18, color: AppColors.grayLight)
    private let stack       = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelValue)
        
        stack.axis          = .horizontal
        stack.distribution  = .equalCentering
        stack.spacing       = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    
    }
    
    func populate(title: String, message: String) {
        labelTitle.text = title
        labelValue.text = message
    }
    
}
