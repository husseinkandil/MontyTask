//
//  CollectioViewDelegate.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCollectionViewCell.identifier, for: indexPath) as! LaunchesCollectionViewCell
        if let launchesData = viewModel.launchesData(index: indexPath.row) {
            cell.populate(response: launchesData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCellAt(index: indexPath.row)
    }
}
