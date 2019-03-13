//
//  LocationViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 12/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation
import Alamofire

class LocationViewModel {
    var networkService: NetworkService

    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<Location>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

    var items: [LocationCellViewModel] {
        return state.currentItems.map { LocationCellViewModel(name: $0.name, dimension: $0.dimension ?? "")}
    }

    var stateUpdated: ((State<Location>) -> Void)?

    // MARK: - Input

    func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getLocation(page: page)
        load(request: request, page: page)
    }

    func load(request: URLRequestConvertible, page: Int) {

        if page == 1 {
            state = .loading
        }

        networkService.load(request: request, page: page) { [weak self] (response: Result<Location>) in
            guard let `self` = self else {
                return
            }

            self.update(response: response)
        }

    }

    // MARK: - Private

    private func update(response: Result<Location>) {
        if let error = response.error {
            state = .error(error)
            return
        }
        guard let newItems = response.items,
            !newItems.isEmpty else {
                state = .empty
                return
        }
        var allitems = state.currentItems
        allitems.append(contentsOf: newItems)
        if response.hasMorePages {
            state = .paging(allitems, next: response.nextPage)
        } else {
            state = .populated(allitems)
        }
    }
}
