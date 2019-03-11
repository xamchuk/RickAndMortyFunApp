//
//  EpisodeCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 05/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    var episode: Episode! {
        didSet {
            nameLabel.text = episode.name
            locationLabel.text = episode.episode
        }
    }

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
        nameLabel.text = nil
        locationLabel.text = nil
    }

    func setupViews() {
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 8, bottom: 0, right: 4))
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2, constant: 8)

        addSubview(locationLabel)
        locationLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: nameLabel.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }

}


