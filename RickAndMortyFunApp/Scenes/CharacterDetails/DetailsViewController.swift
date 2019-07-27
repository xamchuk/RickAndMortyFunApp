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
    var characterDetailsArray: [CharacterDetails]!
    var character: CharacterOfShow! {
        didSet {
            backgroundView.imageView.setImage(from: character.image, size: .init(width: view.frame.width, height: view.frame.width))
            fetchingData()
            collectionView.reloadData()

        }
    }

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

// MARK: - Setup UI
    fileprivate func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.fillWithSafeAreaSuperview()
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

    func fetchingData() {
        characterDetailsArray = [
            CharacterDetails(isButton: false, title: "Status", value: character.status),
            CharacterDetails(isButton: false, title: "Species", value: character.species),
            CharacterDetails(isButton: false, title: "Type", value: character.type),
            CharacterDetails(isButton: false, title: "Gender", value: character.gender),
            CharacterDetails(isButton: false, title: "Origin", value: character.origin.name),
            CharacterDetails(isButton: true, title: "Location", value: character.location.name)
        ]
    }
// MARK: - Actions
    @objc func handleLocationAction() {
        let vc = LocationDetailsViewController()
        let url = URL(string: character.location.url)
        vc.id = url?.lastPathComponent
        show(vc, sender: nil)
    }
}

// MARK: - CollectionView Data Source
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterDetailsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CharactersDetailsCell.self, for: indexPath)
        cell.detail = characterDetailsArray[indexPath.item]
        cell.valueButton.addTarget(self, action: #selector(handleLocationAction), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableView(with: CharacterDetailsHeader.self, for: indexPath)
        headerView?.profileImageView.setImage(from: character.image,
                                       size: .init(width: 150, height: 150))
        headerView?.nameLabel.text = character.name

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
