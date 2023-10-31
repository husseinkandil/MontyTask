//
//  Coordinator.swift
//  AzadWallet
//
//  Created by Hussein kandil on 25/08/2023.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var isCompleted: (()-> Void)? { get set }
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
