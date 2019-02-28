//
//  DetailsViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var detailsView = DetailsCharacterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsView)
        detailsView.fillSuperview()
    }
}
