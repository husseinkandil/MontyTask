//
//  LaunchesCollectionViewCell.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import UIKit

class LaunchesCollectionViewCell: UICollectionViewCell {
    
    let dateFormatter = DateFormatter()
    
    private let backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let backGroundImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "shuttleImage")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3478"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "24 Feb 2022, 11:25 GMT+5"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Columbia Launching"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        defer {
            setupConstraints()
        }
        
        self.addSubview(backGroundView)
        backGroundView.addSubview(backGroundImage)
        backGroundImage.addSubview(highlightView)
        highlightView.addSubview(nameLabel)
        highlightView.addSubview(dateLabel)
        highlightView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            backGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            backGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backGroundImage.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor),
            backGroundImage.topAnchor.constraint(equalTo: backGroundView.topAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor),
            
            highlightView.leadingAnchor.constraint(equalTo: backGroundImage.leadingAnchor),
            highlightView.trailingAnchor.constraint(equalTo: backGroundImage.trailingAnchor),
            highlightView.topAnchor.constraint(equalTo: backGroundImage.topAnchor),
            highlightView.bottomAnchor.constraint(equalTo: backGroundImage.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: highlightView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: highlightView.trailingAnchor, constant: -3),
            nameLabel.topAnchor.constraint(equalTo: highlightView.topAnchor, constant: 25),
            
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: highlightView.bottomAnchor, constant: -35),
        ])
    }
    
    func populate(response: LaunchesResponse) {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        descriptionLabel.text = response.name
        nameLabel.text = String(Int(response.flight_number ?? 000))
        
        if let date = dateFormatter.date(from: response.date_utc ?? "") {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMM yyyy, HH:mm 'GMT'"
            let timeZoneOffset = outputDateFormatter.timeZone.secondsFromGMT() / 3600
            let formattedDateWithOffset = outputDateFormatter.string(from: date) + String(format: " %+d", timeZoneOffset)
            self.dateLabel.text = formattedDateWithOffset
        } else {
            print("Invalid date string")
        }
    }
}
