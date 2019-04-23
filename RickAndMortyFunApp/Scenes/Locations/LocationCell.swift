//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    var imageCollectionView = ImageColectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        imageCollectionView.items = randomImageUrl(from: viewModel.residents ?? [""])
        imageCollectionView.reloadData()
    }

    func randomImageUrl(from item: [String]) -> [String] {
        var array = [String]()
        if item.count <= 4 {
            return item
        } else {
            for n in 0...3 {
                array.append(item[n])
            }
            return array
        }
    }

    private func setupViews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        addSubview(imageCollectionView)

        imageCollectionView.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: bottomAnchor,
                                   trailing: nil,
                                   padding: .init(top: 4, left: 4, bottom: 4, right: 0))
        imageCollectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3.5).isActive = true
        imageCollectionView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3.5).isActive = true

        addSubview(titleLabel)
        titleLabel.anchor(top: imageCollectionView.topAnchor,
                          leading: imageCollectionView.trailingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 8, bottom: 0, right: 4))
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2, constant: 8).isActive = true

        addSubview(detailsLabel)
        detailsLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: titleLabel.leadingAnchor,
                            bottom: imageCollectionView.bottomAnchor,
                            trailing: titleLabel.trailingAnchor,
                            padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }
}
