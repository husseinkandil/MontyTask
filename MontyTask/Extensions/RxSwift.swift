//
//  RxSwift.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import RxSwift

extension Reactive where Base: UIViewController {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { viewController, isLoading in
            let _ = isLoading ? viewController.showLoader() : viewController.hideLoader()
        }
    }
}
