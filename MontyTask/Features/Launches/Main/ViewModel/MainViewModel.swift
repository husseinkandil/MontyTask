//
//  MainViewModel.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelProtocol {
    var isLoading: BehaviorRelay<Bool> { get }
    var isViewHidden: BehaviorRelay<Bool> { get }
    var showAlert: PublishRelay<String> { get }
    var launchesResponse: BehaviorRelay<[LaunchesResponse]?> { get }
    var reloadCollectionView: PublishRelay<Void> { get }
    var numberOfRows: Int { get }
    var showDetailsView: PublishRelay<String> { get }
    var date: String { get }
    var name: String { get }
    var title: String { get }
    
    func didSelectCellAt(index: Int)
    func launchesData(index: Int) -> LaunchesResponse?
}


class MainViewModel: MainViewModelProtocol {
    
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    var isViewHidden: BehaviorRelay<Bool> = .init(value: true)
    var showAlert: PublishRelay<String> = .init()
    var reloadCollectionView: PublishRelay<Void> = .init()
    var launchesResponse: BehaviorRelay<[LaunchesResponse]?> = .init(value: [])
    var showDetailsView: PublishRelay<String> = .init()
    var numberOfRows: Int = 0
    
    var date: String = ""
    var name: String = ""
    var title: String = ""
    
    init() {
        isLoading.accept(true)
        getLaunches() 
    }
    
    
    let dateFormatter = DateFormatter()
    
    private func getLaunches() {
        
        APIManager.shared.getLaunches { [weak self] result in
            guard let self else { return }
            
            switch result {
            case.success(let result):
                
                self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let currentDate = Date()
                let threeYearsAgo = Calendar.current.date(byAdding: .year, value: -3, to: currentDate)
                let filteredData = result.filter { data in
                    if let date = self.dateFormatter.date(from: data.date_utc ?? "") {
                        return date > threeYearsAgo!
                    }
                    return false
                }
                
                let launchesData = filteredData.filter { data in
                    return data.failures.isEmpty
                }
                self.launchesResponse.accept(launchesData.reversed())
                self.numberOfRows = filteredData.count
                self.reloadCollectionView.accept(())
                self.isLoading.accept(false)
                self.isViewHidden.accept(false)
            case.failure(let error):
                self.isLoading.accept(false)
                self.showAlert.accept("An error occured, please try again later. \(error.localizedDescription)")
            }
        }
    }
    
    func launchesData(index: Int) -> LaunchesResponse? {
        let launchesResponse = launchesResponse.value
        return launchesResponse?[index]
    }
    
    func didSelectCellAt(index: Int) {
        if let launchesData = launchesResponse.value,
           let rocketId = launchesData[index].id,
            let date = launchesData[index].date_utc,
           let name = launchesData[index].flight_number,
           let title = launchesData[index].name
        {
            self.name = String(Int(name))
            self.title = title
            self.date = date
            showDetailsView.accept(rocketId)
        } else {
            showAlert.accept("Error occured please try again later.")
        }
    }
}
