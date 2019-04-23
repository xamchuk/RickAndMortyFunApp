//
//  ImageCollectionCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 17/04/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    let charactersImageView: UIImageView = {
        var imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.kf.indicatorType = .activity
        imageV.layer.masksToBounds = true
        return imageV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(charactersImageView)
        charactersImageView.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        charactersImageView.image = nil
    }
}
