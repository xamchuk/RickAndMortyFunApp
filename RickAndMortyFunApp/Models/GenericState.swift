//
//  GenericState.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

enum GenericState<R> {
    case loading
    case populated([R])
    case paging([R], next: Int)
    case empty
    case error(Error)

    var currentItem: [R] {
        switch self {
        case .paging(let item, _):
            return item
        case .populated(let items):
            return items
        default:
            return []
        }
    }
}
