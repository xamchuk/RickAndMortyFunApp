//
//  DetailsViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    fileprivate let padding: CGFloat = 8
    var viewModel: CharacterDetailsViewModel

// MARK: - Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var headerView: CharacterDetailsHeader?
    var backgroundView = DetailsBackGroundView()

// MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupCollectionView()
        setupCollectionViewLayout()

        viewModel.reload = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    // MARK: - Init
    init(viewModel: CharacterDetailsViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

// MARK: - Setup UI
    fileprivate func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.fillWithSafeAreaSuperview()
        backgroundView.imageView.setImage(from: viewModel.character.image, size: view.frame.size)
    }

    fileprivate func setupNavigationController() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .gray
    }

    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.anchor(top: view.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(cellType: CharactersDetailsCell.self)
        collectionView.register(reusableViewType: CharacterDetailsHeader.self)
    }

    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
// MARK: - Actions
    @objc func handleLocationAction() {
        let vc = LocationDetailsViewController()
        let url = URL(string: viewModel.character.location.url)
        vc.viewModel.id = url?.lastPathComponent
        show(vc, sender: nil)
    }
}

// MARK: - CollectionView Data Source
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterDetailsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CharactersDetailsCell.self, for: indexPath)
        cell.detail = viewModel.characterDetailsArray[indexPath.item]
        cell.valueButton.addTarget(self, action: #selector(handleLocationAction), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableView(with: CharacterDetailsHeader.self, for: indexPath)
        headerView?.profileImageView.setImage(from: viewModel.character.image,
                                       size: .init(width: 150, height: 150))
        headerView?.nameLabel.text = viewModel.character.name

        return headerView!
    }
}

// MARK: - CollectionView Delegate
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (2 * padding), height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width)
    }
}
