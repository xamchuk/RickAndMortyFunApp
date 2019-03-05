//
//  ViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 05/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation
import Alamofire

class ViewModel<T> where T: ResponseType & Decodable {
    var networkService: NetworkService<T>

    init(networkService: NetworkService<T> = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<T.Model>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

    var items: [T.Model] {
        return state.currentItem
    }

    var stateUpdated: ((State<T.Model>) -> Void)?

    // MARK: - Input

    func load(request: URLRequestConvertible, page: Int) {
        if page == 1 {
            state = .loading
        }

        networkService.loadItems(request: request, page: page) { [weak self] response in
            guard let `self` = self else {
                return
            }
            self.update(response: response)
        }
    }

    // MARK: - Private

    private func update(response: Result<T.Model>) {
        if let error = response.error {
            state = .error(error)
            return
        }
        guard let newItems = response.items,
            !newItems.isEmpty else {
                state = .empty
                return
        }
        var allitems = state.currentItem
        allitems.append(contentsOf: newItems)
        if response.hasMorePages {
            state = .paging(allitems, next: response.nextPage)
        } else {
            state = .populated(allitems)
        }
    }
}
