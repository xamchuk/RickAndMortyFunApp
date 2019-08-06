//
//  LocationDetailsCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationDetailsCell: UICollectionViewCell {
    private var imageSize = CGSize(width: 56, height: 56)

    // MARK: - Views
    let characterImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.image = #imageLiteral(resourceName: "Locations_Simple")
        imageV.kf.indicatorType = .activity
        imageV.layer.masksToBounds = true
        return imageV
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Unnkown"
        label.textColor = .white
        return label
    }()

    // MARK: - Fetch Data
    func fetchResident(resident: LocationDetailsCellContent) {
        characterImageView.setImage(from: resident.imageUrl, size: imageSize)
        titleLabel.text = resident.title
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    fileprivate func setupViews() {
        addSubviews(characterImageView, titleLabel)
        characterImageView.anchor(top: topAnchor,
                                         leading: leadingAnchor,
                                         bottom: bottomAnchor,
                                         trailing: nil,
                                         padding: .init(top: 8,
                                                        left: 20,
                                                        bottom: 8,
                                                        right: 0),
                                         size: imageSize)
               characterImageView.layer.cornerRadius = imageSize.height / 2
               titleLabel.anchor(top: topAnchor,
                                leading: characterImageView.trailingAnchor,
                                bottom: bottomAnchor,
                                trailing: trailingAnchor,
                                padding: .init(top: 0, left: 12, bottom: 0, right: 4))
    }
}
