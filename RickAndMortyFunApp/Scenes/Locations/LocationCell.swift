//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    // MARK: - Views
    let testImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "Locations_Simple")
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()

    let titleLabel: UILabel = {
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
        titleLabel.text = nil
        detailsLabel.text = nil
    }

    func configure(with viewModel: LocationCellViewModel) {
        titleLabel.text = viewModel.name
        detailsLabel.text = viewModel.dimension
    }

    // MARK: - Setup UI

    fileprivate func setupViews() {
        backgroundColor = .clear
        addSubviews(testImage, titleLabel, detailsLabel)
        testImage.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: nil,
                         padding: .init(top: 8, left: 16, bottom: 8, right: 0), size: .init(width: 80, height: 56))

        titleLabel.anchor(top: nil,
                          leading: testImage.trailingAnchor,
                          bottom: centerYAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 12, bottom: 0, right: 4))

        detailsLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: titleLabel.leadingAnchor,
                            bottom: nil,
                            trailing: titleLabel.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}
