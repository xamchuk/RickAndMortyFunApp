//
//  CharacterDetailsHeader.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/04/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class CharacterDetailsHeader: UICollectionReusableView {

// MARK: - Views
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.masksToBounds = true
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()

// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

// MARK: - Setup UI
    fileprivate func setupViews() {
        addSubview(profileImageView)
        profileImageView.centerInSuperview()
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 16, left: 16, bottom: 0, right: 16))

    }
}
