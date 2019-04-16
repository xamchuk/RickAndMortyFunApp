//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    private let imageSize = CGSize(width: 100, height: 100)

    var imageCollectionView: UICollectionView!
    var imageArray: [String]!

    let titleLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.title2
        label.font = UIFont.preferredFont(forTextStyle: style)
        return label
    }()

    let detailsLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.body
        label.font = UIFont.preferredFont(forTextStyle: style)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        detailsLabel.text = nil
    }

    func configure(with viewModel: LocationCellViewModel) {
        titleLabel.text = viewModel.name
        detailsLabel.text = viewModel.dimension
        randomImageUrl(from: viewModel.residents ?? [""])
    }

    func randomImageUrl(from item: [String]) {
        var array = [String]()
        if item.count <= 4 {
            imageArray = item
        } else {
            for _ in 0...3 {
                array.append(item.randomElement() ?? "")
            }
            imageArray = array
        }
    }

    private func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollectionView.register(cellType: CollectionCell.self)
        addSubview(imageCollectionView)
        imageCollectionView.dataSource = self

        imageCollectionView.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: bottomAnchor,
                                   trailing: nil,
                                   padding: .init(top: 4, left: 4, bottom: 4, right: 0),
                                   size: imageSize)

        addSubview(titleLabel)
        titleLabel.anchor(top: imageCollectionView.topAnchor,
                          leading: imageCollectionView.trailingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 8, bottom: 0, right: 4))
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2, constant: 8)

        addSubview(detailsLabel)
        detailsLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: titleLabel.leadingAnchor,
                            bottom: imageCollectionView.bottomAnchor,
                            trailing: titleLabel.trailingAnchor,
                            padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }
}

extension LocationCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(with: CollectionCell.self, for: indexPath)
        let urlString = imageArray[indexPath.item]
        let characterId = URL(string: urlString)!.lastPathComponent
        cell.charactersImageView.setImage(from: "https://rickandmortyapi.com/api/character/avatar/\(characterId).jpeg", size: imageSize)
        return cell
    }
}

class CollectionCell: UICollectionViewCell {

    let charactersImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.kf.indicatorType = .activity
        imageV.layer.cornerRadius = 10
        imageV.layer.masksToBounds = true
        return imageV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(charactersImageView)
        charactersImageView.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
