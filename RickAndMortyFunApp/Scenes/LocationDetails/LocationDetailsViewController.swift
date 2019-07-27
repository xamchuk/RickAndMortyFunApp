//
//  LVC.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 20/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    fileprivate let padding: CGFloat = 8
    let networkService = NetworkService()
    var id: String? {
        didSet {
            guard let id = id else { return }
            fetchLocation(from: id)
        }
    }
    var item: Location? {
        didSet {
            navigationItem.title = item?.name ?? ""
        }
    }

    // MARK: - Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: StretchyHeaderFlowLayout())
    var headerView: LocationDetailsHeader?

    // MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationController()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        amimationNavigationBar(scrollView: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        amimationNavigationBar(scrollView: scrollView)
    }

    func amimationNavigationBar(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3 ) {
            if y > 0 {
                self.navigationController?.navigationBar.alpha = 0
            }
            if y <= 0 {
                self.navigationController?.navigationBar.alpha = 1
            }
        }
    }
    func fetchLocation(from id: String) {
        networkService.loadSingle(request: RickAndMortyRouter.getSingleLocation(id: id)) { [weak self] (response: Location) in
            self?.item = response
        }
    }

    // MARK: - Setup UI
    fileprivate func setupNavigationController() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .gray
        navigationItem.largeTitleDisplayMode = .never
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
        collectionView.register(cellType: LocationDetailsCell.self)
        collectionView.register(reusableViewType: LocationDetailsHeader.self)
    }

    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? StretchyHeaderFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
}

// MARK: - CollectionView Data Source
extension LocationDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: LocationDetailsCell.self, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableView(with: LocationDetailsHeader.self, for: indexPath)

        return headerView!
    }
}

// MARK: - CollectionView Delegate
extension LocationDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (2 * padding), height: 72)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width)
    }
}
