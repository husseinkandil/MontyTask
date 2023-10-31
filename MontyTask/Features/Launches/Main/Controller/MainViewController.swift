//
//  ViewController.swift
//  MontyTask
//
//  Created by Hussein kandil on 26/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var mainTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Launches"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: view.frame.width / 2 , height: view.frame.width / 2)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LaunchesCollectionViewCell.self, forCellWithReuseIdentifier: LaunchesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let bigLaunchView = BigLaunchView()

    let viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigLaunchView.isHidden = true
        view.backgroundColor = .systemBackground
        
        addNavigationItems()
        setupView()
        activateBindings()
    }

    
    private func addNavigationItems() {
        
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.red)
        let notificationImage = UIImage(systemName: "bell")
        
        let searchButton = UIBarButtonItem(image: searchImage)
        let notificationButton = UIBarButtonItem(image: notificationImage)

        navigationItem.rightBarButtonItems = [notificationButton, searchButton]
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: mainTitle)]
    }
    
    private func setupView() {
        defer {
            setupConstraints()
        }
        
        view.addSubview(collectionView)
        view.addSubview(bigLaunchView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            bigLaunchView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            bigLaunchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bigLaunchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bigLaunchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func activateBindings() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: rx.isLoading)
            .disposed(by: disposeBag)
        
        viewModel.isViewHidden
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { strongSelf, hidden in
                if !hidden {
                    strongSelf.collectionView.isHidden = false
                    strongSelf.bigLaunchView.isHidden = false
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.reloadCollectionView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { strongSlef, _ in
                strongSlef.collectionView.reloadData()
            }.disposed(by: disposeBag)
        
        viewModel.showAlert
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { strongSelf, message in
                strongSelf.showAlert(message: message)
            }.disposed(by: disposeBag)
    }
}

