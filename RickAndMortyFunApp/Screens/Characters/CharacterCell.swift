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

    private let imageSize = CGSize(width: 60, height: 60)
    var character: Character! {
        didSet {
            characterImageView.setImage(from: character.image, size: imageSize)
            nameLabel.text = character.name
            locationLabel.text = character.location.name
        }
    }
    let characterImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.kf.indicatorType = .activity
        return imageV
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        let style = UIFont.TextStyle.title2
        label.font = UIFont.preferredFont(forTextStyle: style)
        return label
    }()

    let locationLabel: UILabel = {
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
        characterImageView.image = nil
        nameLabel.text = nil
        locationLabel.text = nil
    }

    func setupViews() {
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

        addSubview(locationLabel)
        locationLabel.anchor(top: nameLabel.bottomAnchor,
                             leading: nameLabel.leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: nameLabel.trailingAnchor,
                             padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }
}
