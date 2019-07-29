//
//  CharacterDetailsViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

class CharacterDetailsViewModel {

    let character: CharacterOfShow

    var characterDetailsArray: [CharacterDetails] = []

    var reload: (() -> Void)?

// MARK: - Init
    init(character: CharacterOfShow) {
        self.character = character
        fetchingData()
    }

    func fetchingData() {
            characterDetailsArray = [
                CharacterDetails(isButton: false, title: "Status", value: character.status),
                CharacterDetails(isButton: false, title: "Species", value: character.species),
                CharacterDetails(isButton: false, title: "Type", value: character.type),
                CharacterDetails(isButton: false, title: "Gender", value: character.gender),
                CharacterDetails(isButton: false, title: "Origin", value: character.origin.name),
                CharacterDetails(isButton: true, title: "Location", value: character.location.name)
            ]
        reload?()
        }
    // delegate

}
