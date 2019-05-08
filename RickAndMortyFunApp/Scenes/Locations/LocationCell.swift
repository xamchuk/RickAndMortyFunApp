//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    var customLayout = UICollectionViewFlowLayout()
    var imageCollectionView: UICollectionView!
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

    var imageArray: [String]!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageCollectionView()
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
        imageArray = randomImageUrl(from: viewModel.residents ?? [""])
        imageCollectionView.reloadData()
    }

    func randomImageUrl(from item: [String]) -> [String] {
        var array = [String]()
        if item.count <= 4 {
            return item
        } else {
            for _ in 0...3 {
                array.append(item.randomElement() ?? "")
            }
            return array
        }
    }

    private func setupImageCollectionView() {
        customLayout.minimumLineSpacing = 0
        customLayout.minimumInteritemSpacing = 0
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout)
        imageCollectionView.register(cellType: ImageCollectionCell.self)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }

    private func setupViews() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        addSubview(imageCollectionView)
        imageCollectionView.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: bottomAnchor,
                                   trailing: nil,
                                   padding: .init(top: 4, left: 4, bottom: 4, right: 0), size: .init(width: 100, height: 100))

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

extension LocationCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = imageArray.count > 1 ? 4 : 1
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCollectionCell.self, for: indexPath)
        if indexPath.item >= imageArray.count { return cell }
        cell.setImageForCellWith(urlString: imageArray[indexPath.item])
        return cell
    }
}

extension LocationCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = imageArray.count > 1 ? 2 : 1
        let width = collectionView.frame.width / CGFloat(count)
        let height = width
        return CGSize(width: width, height: height)
    }
}
