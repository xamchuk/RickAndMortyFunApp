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

    private let imageSize = CGSize(width: 100, height: 100)

    let characterImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.kf.indicatorType = .activity
        imageV.layer.cornerRadius = 10
        imageV.layer.masksToBounds = true
        return imageV
    }()

    let nameLabel = UILabel()

    let detailsLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.body
        label.font = UIFont.preferredFont(forTextStyle: style)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setUpTheming()
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

    private func setupViews() {
        addSubview(characterImageView)
        characterImageView.anchor(top: topAnchor,
                                  leading: leadingAnchor,
                                  bottom: bottomAnchor,
                                  trailing: nil,
                                  padding: .init(top: 4, left: 4, bottom: 4, right: 0), size: imageSize)

        addSubview(nameLabel)
        nameLabel.anchor(top: characterImageView.topAnchor,
                         leading: characterImageView.trailingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 0, left: 8, bottom: 0, right: 4))
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2, constant: 8)

        addSubview(detailsLabel)
        detailsLabel.anchor(top: nameLabel.bottomAnchor,
                             leading: nameLabel.leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: nameLabel.trailingAnchor,
                             padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }
}

extension CharacterCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.layer.borderColor = theme.cellBorderColor.cgColor
        self.layer.borderWidth = 4
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = theme.backgroundColor
        nameLabel.textColor = theme.textColor
        nameLabel.font = theme.titleFont
        detailsLabel.textColor = theme.textColor
    }
}
