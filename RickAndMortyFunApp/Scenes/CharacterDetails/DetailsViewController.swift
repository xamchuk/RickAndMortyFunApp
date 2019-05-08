//
//  DetailsViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: StretchyHeaderFlowLayout())
    fileprivate let padding: CGFloat = 8
    var characterDetailsArray: [CharacterDetails]!
    var character: CharacterOfShow! {
        didSet {
            fetchingData()
            collectionView.reloadData()
        }
    }
    var headerView: CharacterDetailsHeader? 

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupNavigationController()
        setupCollectionView()
        setupCollectionViewLayout()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        headerView?.alpha = 1
    }

    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: CharactersDetailsCell.self)
        collectionView.register(reusableViewType: CharacterDetailsHeader.self)
    }

    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY > 0 {
            headerView?.alphaOfBlur = 0
            return
        }
        headerView?.alphaOfBlur = abs(contentOffsetY) / 100
    }

    func fetchingData() {
        characterDetailsArray = [
            CharacterDetails(isButton: false, title: "Status", value: character.status),
            CharacterDetails(isButton: false, title: "Species", value: character.species),
            CharacterDetails(isButton: false, title: "Type", value: character.type),
            CharacterDetails(isButton: false, title: "Gender", value: character.gender),
            CharacterDetails(isButton: false, title: "Origin", value: character.origin.name),
            CharacterDetails(isButton: true, title: "Location", value: character.location.name),
            CharacterDetails(isButton: false, title: "111", value: "1111"),
            CharacterDetails(isButton: false, title: "222", value: "2222")
        ]
    }

    @objc func handleLocationAction() {
        let vc = LocationDetailsViewController()
        let url = URL(string: character.location.url)
        vc.id = url?.lastPathComponent
        show(vc, sender: nil)
    }
}

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
        headerView?.alpha = 0
        headerView?.imageView.setImage(from: character.image,
                                       size: .init(width: 300, height: 300))
        headerView?.nameLabel.text = character.name

        return headerView!
    }
}

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
