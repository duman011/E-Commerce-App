//
//  CustomLoadingVC.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 17.11.2023.
//


import UIKit

final class CustomLoadingVC: UIViewController {
    // MARK: - Properties
    private var containerView: UIView!
    
    // MARK: - Loading View Methods
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.05) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.centerInSuperview()
        
        activityIndicator.startAnimating()
    }
    
    // MARK: - Dismiss Loading View Methods
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
