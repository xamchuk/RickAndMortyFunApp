//
//  EpisodeViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 12/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation
import Alamofire

class EpisodeViewModel {
    var networkService: NetworkService

    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }

    // MARK: - Output

    private(set) var state = State<Episode>.loading {
        didSet {
            stateUpdated?(state)
        }
    }

    var sections: [Section<Episode>] = []

    var stateUpdated: ((State<Episode>) -> Void)?

    // MARK: - Input

    func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getEpisode(page: page)
        load(request: request, page: page)
    }

    func load(request: URLRequestConvertible, page: Int) {

        if page == 1 {
            state = .loading
        }

        networkService.load(request: request, page: page) { [weak self] (response: Result<Episode>) in
            guard let `self` = self else {
                return
            }

            self.update(response: response)
        }

    }

    // MARK: - Private

    private func update(response: Result<Episode>) {
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
        sections = Dictionary(grouping: allitems) { $0.season }
            .sorted { $0.key < $1.key }
            .map { Section(title: $0.value.first?.season, rows: $0.value) }

        if response.hasMorePages {
            state = .paging(allitems, next: response.nextPage)
        } else {
            state = .populated(allitems)
        }
    }
}
