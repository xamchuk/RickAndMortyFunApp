//
//  LocationDetailsViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 29/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

enum LocationDetailsInitOption {
    case byId(id: String)
    case byItem(item: Location)
}

class LocationDetailsViewModel {

    var networkService: NetworkService
    var residents: [LocationDetailsCellContent]?
    var name: String?
    var reload: (() -> Void)?

    func fetchLocation(from id: String) {
        networkService.loadSingle(request: RickAndMortyRouter.getSingleLocation(id: id)) { [weak self] (response: Location) in
            self?.name = response.name
            self?.fetchResidents(residents: response.residents)
            self?.reload?()
        }
    }

    func fetchResidents(residents: [String]?) {
        var residentsIds: String = ""
        residents?.forEach {
            let id = URL(string: $0)?.lastPathComponent
            residentsIds.append("\(id!),")
        }
        networkService.loadResidents(request: RickAndMortyRouter.getResidents(ids: residentsIds)) { [weak self] (response: [CharacterOfShow]) in
            var residentsForCell: [LocationDetailsCellContent] {
              return response.map {
                    LocationDetailsCellContent(title: $0.name, imageUrl: $0.image, id: $0.id)
                }
            }
            self?.residents = residentsForCell
            self?.reload?()
        }
    }

    init(networkService: NetworkService = .init(), data: LocationDetailsInitOption) {
        self.networkService = networkService
        switch data {
        case .byId(let id):
            fetchLocation(from: id)
        case .byItem(let item):
            fetchResidents(residents: item.residents)
            name = item.name
        }
    }
}
