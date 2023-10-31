//
//  Drawable.swift
//  AzadWallet
//
//  Created by Hussein kandil on 25/08/2023.
//

import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
