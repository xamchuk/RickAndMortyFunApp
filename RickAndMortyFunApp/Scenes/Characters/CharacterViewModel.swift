//
//  CharacterViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 12/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation
import Alamofire

class CharacterViewModel {
    var networkService: NetworkService

    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<CharacterOfShow>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

    var items: [CharacterCellViewModel] {
        return state.currentItems.map { CharacterCellViewModel(name: $0.name, imageURl: $0.image, locationName: $0.location.name)}

    }

    func character(for indexPath: IndexPath) -> CharacterOfShow {
        return state.currentItems[indexPath.row]
    }

    var stateUpdated: ((State<CharacterOfShow>) -> Void)?

    // MARK: - Input

    func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getCharacters(page: page)
        load(request: request, page: page)
    }

    func load(request: URLRequestConvertible, page: Int) {

        if page == 1 {
            state = .loading
        }

        networkService.load(request: request, page: page) { [weak self] (response: Result<CharacterOfShow>) in
            guard let `self` = self else {
                return
            }
            self.update(response: response)
        }
    }

    // MARK: - Private

    private func update(response: Result<CharacterOfShow>) {
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
