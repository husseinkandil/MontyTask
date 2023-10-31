//
//  AppCoordinator.swift
//  AzadWallet
//
//  Created by Hussein kandil on 25/08/2023.
//

import Foundation
import RxSwift
import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var isCompleted: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterNavigationProtocol
    
    init(router: RouterNavigationProtocol) {
        self.router = router
    }

    func start() {
        self.showMainView()
    }
    
    func showMainView() {
        let coordinator = LaunchesCoordinator(router: router)
        add(coordinator: coordinator)
        coordinator.isCompleted = { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.remove(coordinator: coordinator)
        }
        coordinator.start()
    }
}
