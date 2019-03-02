//
//  DetailsCharacterView.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class CharacterDetailsView: UIView {

    let nibName = String(describing: CharacterDetailsView.self)

    @IBOutlet var detailsView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var lastLocation: UILabel!
    @IBOutlet var idLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }

    func initFromNib() {
        detailsView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
        addSubview(detailsView)
        detailsView.fillSuperview()
    }
}
