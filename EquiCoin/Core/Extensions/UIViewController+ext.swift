//
//  UIViewController+ext.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 14/06/2024.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController{
    
    func presentAlert(title: String = "Request Failed", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = AppColors.dark
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        activityIndicator.color = AppColors.grayLight
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
    
    func showEmptyStateView(title: String, message: String, image: UIImage = AppImages.favorite) {
        var config                              = UIContentUnavailableConfiguration.empty()
        config.image                            = image
        config.text                             = title
        config.secondaryText                    = message
        config.imageProperties.tintColor        = AppColors.grayDark
        config.textProperties.color             = AppColors.grayLight
        config.secondaryTextProperties.color    = AppColors.grayDark
        contentUnavailableConfiguration         = config
    }
    
    //    func presentSafariVC(with url: URL){
    //        let safariVC = SFSafariViewController(url: url)
    //        safariVC.preferredControlTintColor = .systemGreen
    //        present(safariVC, animated: true)
    //    }
    
}
