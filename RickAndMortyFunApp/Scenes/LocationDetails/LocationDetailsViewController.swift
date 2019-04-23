//
//  LVC.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 20/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    let networkService = NetworkService()
    let imageColletionView = ImageColectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var id: String? {
        didSet {
            guard let id = id else { return }
            fetchLocation(from: id)
        }
    }
    var item: Location? {
        didSet {
            imageColletionView.showAllCharacters = true
            imageColletionView.items = item?.residents ?? [""]
            navigationItem.title = item?.name ?? ""
            imageColletionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageColletionView)
        imageColletionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        imageColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
        imageColletionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageColletionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
        imageColletionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/4)
             ])
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func fetchLocation(from id: String) {
        networkService.loadSingle(request: RickAndMortyRouter.getSingleLocation(id: id)) { [weak self] (response: Location) in
            self?.item = response
        }
    }

    func randomImageUrl(from item: [String]) -> [String] {
        var array = [String]()
        if item.count <= 4 {
            return item
        } else {
            for _ in 0...3 {
                if let random = item.randomElement() {
                    array.append(random)
                } else {
                    fatalError("nil from random")
                }
            }
            return array
        }
    }
}
