//
//  RouterNavigationProtocol.swift
//  AzadWallet
//
//  Created by Hussein kandil on 25/08/2023.
//

import UIKit.UINavigationController

typealias NavigationBackClosure = (() -> Void)

protocol RouterNavigationProtocol: AnyObject {
    func push(_ drawable: Drawable, animated: Bool, onNavigation: NavigationBackClosure?)
    func pop(_ animated: Bool)
    func popToDrawable(_ drawable: Drawable, animated: Bool)
    func popToRoot(_ animated: Bool)
    func present(_ drawable: Drawable, animated: Bool)
    func dismiss(_ animated: Bool, onDismiss: NavigationBackClosure?)
    func setRoot(_ drawable: Drawable, animated: Bool)
    
    var navigationController: UINavigationController { get }
}
