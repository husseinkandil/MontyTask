//
//  DetailsViewModel.swift
//  MontyTask
//
//  Created by Zein Abdalla on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailsViewModelProtocol {
    var isLoading: BehaviorRelay<Bool> { get }
    var showAlert: PublishRelay<String> { get }
    var closeButtonTapped: PublishRelay<Void> { get }
    var rocketName: BehaviorRelay<String> { get }
    var title: BehaviorRelay<String> { get }
    var description: BehaviorRelay<String> { get }
    var date: BehaviorRelay<String> { get }
    var shareButtonTapped: PublishRelay<Void> { get }
    var readMoreButtonTapped: PublishRelay<Void> { get }
}


class DetailsViewModel: DetailsViewModelProtocol {
    
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    var showAlert: PublishRelay<String> = .init()
    var closeButtonTapped: PublishRelay<Void> = .init()
    var rocketName: BehaviorRelay<String> = .init(value: "")
    var title: BehaviorRelay<String> = .init(value: "")
    var description: BehaviorRelay<String> = .init(value: "")
    var date: BehaviorRelay<String> = .init(value: "")
    var shareButtonTapped: PublishRelay<Void> = .init()
    var readMoreButtonTapped: PublishRelay<Void> = .init()
    
    var wikepediaUrl: String?
    
    let dateFormatter = DateFormatter()
    
    init(id: String, date: String, name: String, title: String) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: date) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMM yyyy, HH:mm 'GMT'"
            let timeZoneOffset = outputDateFormatter.timeZone.secondsFromGMT() / 3600
            let formattedDateWithOffset = outputDateFormatter.string(from: date) + String(format: " %+d", timeZoneOffset)
            self.date.accept(formattedDateWithOffset)
        } else {
            print("Invalid date string")
        }
        
        self.rocketName.accept(name)
        self.title.accept(title)
        isLoading.accept(true)
        getRocketInfo(id: id)
    }
    
    
    private func getRocketInfo(id: String) {
        
        APIManager.shared.getRocket(id: id) { [weak self] result in
            guard let self else { return }
            self.isLoading.accept(false)
            
            
            switch result {
            case.success(let result):
                self.description.accept(result.last?.description ?? "")
                self.wikepediaUrl = result.first?.wikipedia
            case.failure(let error):
                self.showAlert.accept(error.localizedDescription)
            }
        }
           
    }
}

