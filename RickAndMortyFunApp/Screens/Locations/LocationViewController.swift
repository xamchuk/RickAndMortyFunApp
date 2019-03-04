//
//  LocationViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//
import UIKit

class LocationViewController: GenericViewController<LocationCell, Location, Result<Locations>> {
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadPage(_ page: Int) {
        networkService.loadLocations(page: page ) { [weak self] response in
            guard let `self` = self else {
                return
            }
            self.update(response: response)
        }
    }
    
    override func update(response: Result<Locations>) {
        if let error = response.error {
            state = .error(error)
            return
        }
        guard let newItems = response.items?.results,
            !newItems.isEmpty else {
                state = .empty
                return
        }
        var allItems = state.currentItem
        allItems.append(contentsOf: newItems)
        if response.hasMorePages {
            state = .paging(allItems, next: response.nextPage)
        } else {
            state = .populated(allItems)
        }
    }
}
