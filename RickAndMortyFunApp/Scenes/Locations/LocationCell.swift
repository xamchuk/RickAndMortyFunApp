//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

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
    }

    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 4, left: 8, bottom: 0, right: 4))
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2, constant: 8)

        addSubview(detailsLabel)
        detailsLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: titleLabel.leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: titleLabel.trailingAnchor,
                            padding: .init(top: 4, left: 0, bottom: 4, right: 0))
    }
}
