//
//  BigLaunchView.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation
import UIKit

class BigLaunchView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Big Launch"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let goldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GOLD"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemOrange.withAlphaComponent(0.8)
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.layer.masksToBounds = true
        return label
    }()
    
    private let spaceShipsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SPACE SHIPS"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let backGroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ISSImage")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let backgrounView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "appOrange")
        return view
    }()
    
    private let profileView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "appOrange")
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profileImage")
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let engLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "by Eng. Dieter Rams"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ISS geosynchronous and \nis it stationary"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString()

        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.white
        ]
        let boldText = NSAttributedString(string: "2355", attributes: boldAttributes)
        attributedString.append(boldText)
        
        let newlineText = NSAttributedString(string: "\n\n")

        attributedString.append(newlineText)

        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]
        let regularText = NSAttributedString(string: "24 Feb 2022 \n11:25 GMT+5", attributes: regularAttributes)
        attributedString.append(regularText)

        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adiposcing elit. Pellentesque eros enim, dictum vitae quam nec, congue feugiat neque. Vivamus ut luctus enim.Lorem ipsum dolor sit amet, consectetur adiposcing elit. Pellentesque eros enim, dictum vitae quam nec, congue feugiat neque. Vivamus ut luctus enim."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
           
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        setupView()
        }
    
    private func setupView() {
        defer {
            setupConstraints()
        }
        
        profileView.clipsToBounds = true
        
        self.addSubview(titleLabel)
        self.addSubview(backgrounView)
        self.addSubview(goldLabel)
        self.addSubview(spaceShipsLabel)
        self.addSubview(backGroundImageView)
        self.addSubview(profileView)
        self.profileView.addSubview(profileImageView)
        self.backGroundImageView.addSubview(highlightView)
        self.backGroundImageView.addSubview(engLabel)
        self.backGroundImageView.addSubview(detailsLabel)
        self.addSubview(dateLabel)
        self.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            goldLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            goldLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            goldLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.04),
            goldLabel.widthAnchor.constraint(equalTo: goldLabel.heightAnchor, multiplier: 3),
            
            spaceShipsLabel.centerYAnchor.constraint(equalTo: goldLabel.centerYAnchor),
            spaceShipsLabel.leadingAnchor.constraint(equalTo: goldLabel.trailingAnchor, constant: 8),
            
            backGroundImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            backGroundImageView.topAnchor.constraint(equalTo: goldLabel.bottomAnchor, constant: 25),
            backGroundImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.43),
            backGroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            highlightView.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor),
            highlightView.trailingAnchor.constraint(equalTo: backGroundImageView.trailingAnchor),
            highlightView.topAnchor.constraint(equalTo: backGroundImageView.topAnchor),
            highlightView.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor),
            
            profileView.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor, constant: 30),
            profileView.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor, constant: 35),
            profileView.heightAnchor.constraint(equalToConstant: 70),
            profileView.widthAnchor.constraint(equalTo: profileView.heightAnchor),
            
            profileImageView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            engLabel.centerXAnchor.constraint(equalTo: backGroundImageView.centerXAnchor),
            engLabel.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: -5),
            
            detailsLabel.leadingAnchor.constraint(equalTo: engLabel.leadingAnchor),
            detailsLabel.topAnchor.constraint(equalTo: engLabel.bottomAnchor, constant: 5),
            detailsLabel.bottomAnchor.constraint(equalTo: backGroundImageView.bottomAnchor, constant: -10),
            
            dateLabel.leadingAnchor.constraint(equalTo: backGroundImageView.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: backGroundImageView.bottomAnchor, constant: 15),
            
            backgrounView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgrounView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgrounView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgrounView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.62)
        ])
        
    }
}
