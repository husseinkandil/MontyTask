//
//  UIViewController.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    private var loaderTag: Int { return 987654321 }
    
    func showLoader() {
        
        if let _ = view.viewWithTag(loaderTag) {
            return
        }
        
        let loaderView = UIView(frame: view.bounds)
        loaderView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loaderView.tag = loaderTag
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loaderView.center
        activityIndicator.startAnimating()
        
        loaderView.addSubview(activityIndicator)
        
        view.addSubview(loaderView)
    }
    
    func hideLoader() {
        if let loaderView = view.viewWithTag(loaderTag) {
            loaderView.removeFromSuperview()
        }
    }
    
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}

extension UIViewController: SFSafariViewControllerDelegate {
    
    func openSafariViewController(url: String) {
        let urlString = url
        
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self

            present(safariViewController, animated: true, completion: nil)
        }
    }
}
