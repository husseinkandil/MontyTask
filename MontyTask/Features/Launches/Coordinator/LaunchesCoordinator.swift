//
//  MainCoordinator.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation

import RxSwift
import RxCocoa

class LaunchesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var isCompleted: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterNavigationProtocol
    
    init(router: RouterNavigationProtocol) {
            self.router = router
        }
    
    func start() {
        
        let viewModel = MainViewModel()
        let controller = MainViewController(viewModel: viewModel)
        
        viewModel.showDetailsView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, id in
                let date = viewModel.date
                let name = viewModel.name
                let title = viewModel.title
                strongSelf.showDetailsView(withRocketId: id, date: date, name: name, title: title)
            }.disposed(by: disposeBag)
        
        router.setRoot(controller, animated: true)
    }
    
    private func showDetailsView(withRocketId id: String, date: String, name: String, title: String) {
        
        let viewModel = DetailsViewModel(id: id, date: date, name: name, title: title)
        let vc = DetailsViewController(viewModel: viewModel)
        
        viewModel.closeButtonTapped
            .withUnretained(self)
            .bind { strongSelf, _ in
                strongSelf.router.pop(true)
            }.disposed(by: disposeBag)
        
        viewModel.readMoreButtonTapped
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                if let url = viewModel.wikepediaUrl {
                    strongSelf.router.navigationController.openSafariViewController(url: url)
                }
            }.disposed(by: disposeBag)
        
        viewModel.shareButtonTapped
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                let linkToSahre = viewModel.wikepediaUrl
                let itemsToShare: [Any] = [linkToSahre]
                
                let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

                self.router.present(activityViewController, animated: true)
            }.disposed(by: disposeBag)
        
        router.push(vc, animated: true, onNavigation: nil)
    }
}
