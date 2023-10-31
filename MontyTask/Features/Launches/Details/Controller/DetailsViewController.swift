//
//  DetailsViewController.swift
//  MontyTask
//
//  Created by Zein Abdalla on 31/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private let topImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "shuttleImage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "x.square.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let topRoundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "Columbia Launches"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "106"
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "24 Feb 2022, 11:25 GMT +5"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "akwjbdkja akjwbdkjan wkjnd kajnwdkj nakwj ndkjanwdkjnawkj ndkja wndkj nawkj nawkndkjawn dkjanw  kjnakwj nakwj nkjawn dkjawn dlawnd;akw;kdpoakwd;o aw;m alkwn lkanw lkanwd lkamwlkdn alwnlkamwd ;amw ;amdlamw lmaw;dmlfnk"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read more", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var shareButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(UIColor(named: "appOrange"), for: .normal)
        return button
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        setupView()
        activateBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupView() {
        defer {
            setupConstraints()
        }

        view.addSubview(topImageView)
        topImageView.addSubview(highlightView)
        highlightView.addSubview(backButton)
        view.addSubview(topRoundedView)
        topRoundedView.addSubview(titleLabel)
        topRoundedView.addSubview(nameLabel)
        topRoundedView.addSubview(lineView)
        topRoundedView.addSubview(dateLabel)
        topRoundedView.addSubview(descriptionLabel)
        
        topRoundedView.addSubview(readMoreButton)
        topRoundedView.addSubview(shareButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),

            highlightView.topAnchor.constraint(equalTo: topImageView.topAnchor),
            highlightView.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor),
            highlightView.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor),
            highlightView.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: highlightView.topAnchor, constant: 55),
            backButton.trailingAnchor.constraint(equalTo: highlightView.trailingAnchor, constant: -10),
            backButton.heightAnchor.constraint(equalTo: highlightView.heightAnchor, multiplier: 0.1),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            topRoundedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topRoundedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topRoundedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topRoundedView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: topRoundedView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: topRoundedView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: topRoundedView.widthAnchor, multiplier: 0.6),
            
            nameLabel.trailingAnchor.constraint(equalTo: topRoundedView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            lineView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            dateLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 13),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: readMoreButton.topAnchor, constant: -5),
            
            readMoreButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -5),
            readMoreButton.heightAnchor.constraint(equalTo: shareButton.heightAnchor),
            readMoreButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor),
            readMoreButton.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor),
            
            shareButton.bottomAnchor.constraint(equalTo: topRoundedView.bottomAnchor, constant: -30),
            shareButton.centerXAnchor.constraint(equalTo: topRoundedView.centerXAnchor),
            shareButton.heightAnchor.constraint(equalTo: topRoundedView.heightAnchor, multiplier: 0.1),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor, multiplier: 7),
        ])
    }
    
    private func activateBindings() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: rx.isLoading)
            .disposed(by: disposeBag)

        backButton.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.viewModel.closeButtonTapped.accept(())
            }.disposed(by: disposeBag)
        
        shareButton.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.viewModel.shareButtonTapped.accept(())
            }.disposed(by: disposeBag)
        
        readMoreButton.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSelf, _ in
                strongSelf.viewModel.readMoreButtonTapped.accept(())
            }.disposed(by: disposeBag)

        viewModel.showAlert
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { strongSelf, message in
                strongSelf.showAlert(message: message)
            }.disposed(by: disposeBag)
        
        self.viewModel.date
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.description
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.rocketName
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
