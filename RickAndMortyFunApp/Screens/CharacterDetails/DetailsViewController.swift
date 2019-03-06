//
//  DetailsViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var detailsView = CharacterDetailsView()

    var character: Character! {
        didSet {
            detailsView.imageView.setImage(from: character.image, size: detailsView.imageView.frame.size)
            detailsView.nameLabel.text = character.name
            detailsView.idLabel.text = "id: \(character.id)"
            detailsView.statusLabel.text = character.status
            detailsView.speciesLabel.text = character.species
            detailsView.genderLabel.text = character.gender
            detailsView.originLabel.text = character.origin.name
            detailsView.lastLocation.text = character.location.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsView)
        detailsView.fillSuperview()
    }
}
