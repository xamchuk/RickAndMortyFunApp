//
//  LocationCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationCell: GenericCell<Location> {
    override var item: Location! {
        didSet {
           // imageCharacter.imageFromURL(urlString: item.image)
            nameLabel.text = item.name
            locationLabel.text = item.type
        }
    }
}
