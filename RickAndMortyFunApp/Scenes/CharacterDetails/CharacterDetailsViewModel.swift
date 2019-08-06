//
//  CharacterDetailsViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

enum CharacterData {
    case byItem(item: CharacterOfShow)
    case byId(id: Int)
}

class CharacterDetailsViewModel {

    var character: CharacterOfShow?
    var characterDetailsArray: [CharacterDetails] = []
    var reload: (() -> Void)?

    init(data: CharacterData) {
        switch data {
        case .byId(let id):
            let networkService = NetworkService()
            networkService.loadSingle(request: RickAndMortyRouter.getSingleCharacter(id: id)) { [weak self] (response: CharacterOfShow) in
                self?.character = response
                self?.fetchingData()
            }
        case .byItem(let item):
            self.character = item
            fetchingData()
        }
    }

    func fetchingData() {
        guard let character = character else { return }
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
}
