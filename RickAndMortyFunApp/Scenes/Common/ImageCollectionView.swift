//
//  ImageCollectionView.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 17/04/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class ImageColectionView: UICollectionView {

    var items = [String]()
    var customLayout = UICollectionViewFlowLayout()
    var showAllCharacters: Bool = false

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: customLayout)
        customLayout.minimumInteritemSpacing = 0
        customLayout.minimumLineSpacing = 0
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.register(cellType: ImageCollectionCell.self)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageColectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(with: ImageCollectionCell.self, for: indexPath)
        let urlString = items[indexPath.item]
        let characterId = URL(string: urlString)!.lastPathComponent
        cell.charactersImageView.setImage(
            from: "https://rickandmortyapi.com/api/character/avatar/\(characterId).jpeg",
            size: CGSize(width: frame.width / 2, height: frame.height / 2))
        return cell
    }
}

extension ImageColectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var count = items.count > 1 ? 2 : 1
        if showAllCharacters {
            count = 4
        }

        let width = frame.width / CGFloat(count)
        let height = width
        return CGSize(width: width, height: height)
    }
}
