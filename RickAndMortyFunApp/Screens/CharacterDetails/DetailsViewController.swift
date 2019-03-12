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

    var character: CharacterCellViewModel! {
        didSet {
            detailsView.imageView.image = character.image
            detailsView.nameLabel.text = character.name
            detailsView.idLabel.text = "id: \(character.id)"
            detailsView.statusLabel.text = character.status
            detailsView.speciesLabel.text = character.species
            detailsView.genderLabel.text = character.gender
            detailsView.originLabel.text = character.originName
            detailsView.lastLocation.text = character.locationName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsView)
        detailsView.fillSuperview()
    }
}
