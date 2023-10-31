//
//  RouterNavigation.swift
//  AzadWallet
//
//  Created by Hussein kandil on 25/08/2023.
//

import UIKit

class RouterNavigation: NSObject, RouterNavigationProtocol {
    
    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func push(_ drawable: Drawable, animated: Bool, onNavigation closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ animated: Bool) {
        if let poppedViewController = navigationController.popViewController(animated: animated) {
            if !animated {
                executeClosure(poppedViewController)
            }
        }
    }
    
    func popToDrawable(_ drawable: Drawable, animated: Bool) {
        guard let viewController = drawable.viewController else { return }
        if let poppedViewControllers = navigationController.popToViewController(viewController, animated: animated) {
            if !animated {
                poppedViewControllers.forEach(executeClosure(_:))
            }
        }
            
    }
    
    func popToRoot(_ animated: Bool) {
        if let poppedViewCntroller = navigationController.popToRootViewController(animated: animated) {
            if !animated {
                poppedViewCntroller.forEach(executeClosure(_:))
            }
        }
    }
    
    func present(_ drawable: Drawable, animated: Bool) {
        guard let viewController = drawable.viewController else { return }
        if navigationController.presentedViewController == nil {
            navigationController.present(viewController, animated: animated)
        } else if let topController = navigationController.topViewController {
            topController.present(viewController, animated: animated)
        }
    }
    
    func dismiss(_ animated: Bool, onDismiss closure: NavigationBackClosure?) {
        navigationController.dismiss(animated: animated, completion: closure)
    }
    
    func setRoot(_ drawable: Drawable, animated: Bool) {
        navigationController.viewControllers = [drawable.viewController!]
        navigationController.setViewControllers([drawable.viewController!], animated: animated)
    }
    
    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension RouterNavigation: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(previousController) else { return }
        executeClosure(previousController)
    }
}
