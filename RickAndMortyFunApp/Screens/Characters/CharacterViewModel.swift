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
    var networkService: Network<Character>

    init(networkService: Network<Character> = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<Character>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

//    var items: [Character] {
//        return state.currentItems
//    }
    var items: [CharacterCellViewModel] {
        return state.currentItems.map(({ return CharacterCellViewModel(character: $0)}))
    }

    var stateUpdated: ((State<Character>) -> Void)?

    var footer: ((FooterView<Character>) -> Void)?

    // MARK: - Input

    func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getCharacters(page: page)
        load(request: request, page: page)
    }

    func load(request: URLRequestConvertible, page: Int) {

        if page == 1 {
            state = .loading
        }

        networkService.load(request: request, page: page) { [weak self] response in
            guard let `self` = self else {
                return
            }

            self.update(response: response)
        }

    }

    // MARK: - Private

    private func update(response: Result<Character>) {
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
