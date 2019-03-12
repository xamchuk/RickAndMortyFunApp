//
//  CharacterCellViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 12/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//
import Kingfisher
import UIKit

struct CharacterCellViewModel {
    let name: String
    let image: UIImage?
    let id: Int
    let status: String
    let species: String
    let gender: String
    let originName: String
    let locationName: String

    init(character: Character) {
        self.name = character.name
        self.image = {
            let iv = UIImageView()
            iv.setImage(from: character.image)
            return iv.image
        }()
        self.id = character.id
        self.status = character.status
        self.species = character.species
        self.gender = character.gender
        self.originName = character.origin.name
        self.locationName = character.location.name
    }
}
