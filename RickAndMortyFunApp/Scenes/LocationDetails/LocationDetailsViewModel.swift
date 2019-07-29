//
//  LocationDetailsViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 29/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

class LocationDetailsViewModel {

    var item: Location?

    var networkService: NetworkService
    var id: String? {
        didSet {
            guard let id = id else { return }
            fetchLocation(from: id)
        }
    }

    func fetchLocation(from id: String) {
        networkService.loadSingle(request: RickAndMortyRouter.getSingleLocation(id: id)) { [weak self] (response: Location) in
            self?.item = response
        }
    }

    init(networkService: NetworkService = .init()){
        self.networkService = networkService
    }
}
