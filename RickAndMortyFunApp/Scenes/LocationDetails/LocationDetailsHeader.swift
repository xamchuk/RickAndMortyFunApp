//
//  LocationDetailsHeader.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationDetailsHeader: UICollectionReusableView {
    private let padding: CGFloat = 16

// MARK: - Views
    let detailsBackgroundView = DetailsBackGroundView()

    lazy var locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.masksToBounds = true
        iv.image = #imageLiteral(resourceName: "Locations_Simple")
        iv.layer.cornerRadius = 16
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Light", size: 16)
       // label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = "R E S I D E N T S"
        label.textAlignment = .left
        return label
    }()

// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        setupBackgroundView()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup UI
    fileprivate func setupViews() {
        addSubview(locationImageView)
        locationImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                 leading: leadingAnchor,
                                 bottom: nil,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 3 * padding, left: padding, bottom: padding, right: padding))
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        addSubview(containerView)
        containerView.anchor(top: locationImageView.bottomAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                             size: .init(width: 0, height: 50))
        containerView.addSubview(nameLabel)
        nameLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
    }

    fileprivate func setupBackgroundView() {
        addSubview(detailsBackgroundView)
        detailsBackgroundView.imageView.image = #imageLiteral(resourceName: "Locations_Simple")
        detailsBackgroundView.fillWithSafeAreaSuperview()
    }
}
