//
//  DetailsBackGroundView.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 25/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsBackGroundView: UIView {

// MARK: - Views
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()

// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        gradientView()
        setupVisualEffectBlur()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup UI
    fileprivate func setupViews() {
        backgroundColor = .black
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        let darkView = UIView()
        addSubview(darkView)
        darkView.fillWithSafeAreaSuperview()
        darkView.backgroundColor = .black
        darkView.alpha = 0.5
    }

    fileprivate func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.4, 1]
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: imageView.bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
        gradientLayer.frame.origin.y -= bounds.height
    }

    fileprivate func setupVisualEffectBlur() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        addSubview(visualEffectView)
        visualEffectView.fillWithSafeAreaSuperview()
    }
}
