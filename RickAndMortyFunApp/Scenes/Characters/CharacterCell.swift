//
//  CharacterCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Kingfisher
import UIKit

class CharacterCell: UITableViewCell {

    private var imageSize = CGSize(width: 56, height: 56)

// MARK: - Views properties
    let characterImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.kf.indicatorType = .activity
        imageV.layer.masksToBounds = true
        return imageV
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.title2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.textColor = .white
        return label
    }()

    let detailsLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.callout
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.textColor = .gray
        return label
    }()

// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        detailsLabel.text = nil
    }

    func configure(with viewModel: CharacterCellViewModel) {
        characterImageView.setImage(from: viewModel.imageURl, size: imageSize)
        nameLabel.text = viewModel.name
        detailsLabel.text = viewModel.locationName
    }

// MARK: - Setup UI
    fileprivate func setupViews() {
        backgroundColor = .clear
        addSubviews(characterImageView, nameLabel, detailsLabel)
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
        nameLabel.anchor(top: nil,
                         leading: characterImageView.trailingAnchor,
                         bottom: centerYAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 0, left: 12, bottom: 0, right: 4))
        detailsLabel.anchor(top: nameLabel.bottomAnchor,
                             leading: nameLabel.leadingAnchor,
                             bottom: nil,
                             trailing: nameLabel.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}
