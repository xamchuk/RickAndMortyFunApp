//
//  CharacterDetailsHeader.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/04/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class CharacterDetailsHeader: UICollectionReusableView {

    let imageView: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.textColor = .white
        return label
    }()

    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    var alphaOfBlur: CGFloat! {
        didSet {
            visualEffectView.alpha = alphaOfBlur
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
        setupBlurEffect()
        setupGradientLayer()
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: nil,
                         padding: .init(top: 0, left: 8, bottom: 8, right: 0))
    }

    func setupBlurEffect() {
        self.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
    }

    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.4, 1]

        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
