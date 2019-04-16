//
//  DetailsViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    let detailsView: CharacterDetailsView! = .fromNib()

    var character: CharacterOfShow! {
        didSet {
            detailsView.imageView.setImage(from: character.image,
                                           size: detailsView.imageView.frame.size)
            detailsView.nameLabel.text = character.name
            detailsView.idLabel.text = "id: \(character.id)"
            detailsView.statusLabel.text = character.status
            detailsView.speciesLabel.text = character.species
            detailsView.genderLabel.text = character.gender
            detailsView.originLabel.text = character.origin.name
            detailsView.locationButton.setTitle(character.location.name, for: .normal)
            detailsView.locationButton.addTarget(self,
                                                 action: #selector(handleLocationAction),
                                                 for: .touchUpInside)
        }
    }

    @objc func handleLocationAction() {
        let vc = LVC()
        let url = URL(string: character.location.url)
        vc.id = url?.lastPathComponent
        show(vc, sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsView)
        detailsView.fillSuperview()
    }
}
