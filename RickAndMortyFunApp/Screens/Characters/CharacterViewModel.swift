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
    var networkService: Network<ItemsResponse<Character>>

    init(networkService: Network<ItemsResponse<Character>> = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<Character>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

    var items: [Character] {
        return state.currentItems
    }

    var stateUpdated: ((State<Character>) -> Void)?

    // MARK: - Input

    func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getCharacters(page: page)
        load(request: request, page: page)
    }

    func load(request: URLRequestConvertible, page: Int) {

        if page == 1 {
            state = .loading
        }

        networkService.loadItems(request: request, page: page) { [weak self] response in
            guard let `self` = self else {
                return
            }
            if let error = response.error {
                guard (error as NSError).code != NSURLErrorCancelled else { return }
                let result = Result<Character>(items: nil, error: error, currentPage: 0, pageCount: 0)
                self.update(response: result)
                return
            }

            guard let response = response.value else { return }

            let result = Result<Character>(
                items: response.results,
                error: nil,
                currentPage: page,
                pageCount: Int(response.info.pages)
            )
            self.update(response: result)
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
