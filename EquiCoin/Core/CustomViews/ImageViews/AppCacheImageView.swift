//
//  AppUIImageView.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit

class AppCacheImageView: UIImageView {
    
    
    //    private let activityIndicatorView: UIActivityIndicatorView = {
    //        let aiv = UIActivityIndicatorView()
    //        aiv.translatesAutoresizingMaskIntoConstraints = false
    //        return aiv
    //    }()
    
    
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
    
    
    
//    private func layoutActivityIndicator() {
        //        activityIndicatorView.removeFromSuperview()
        //
        //        addSubview(activityIndicatorView)
        //        NSLayoutConstraint.activate([
        //            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        //            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        //        ])
        
        //        if self.image == nil {
        //            activityIndicatorView.startAnimating()
        //        }
//    }
    
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
        //        layoutActivityIndicator()
    }
}





