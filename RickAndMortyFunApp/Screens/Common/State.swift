//
//  State.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 05/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

enum State<T> {
    case loading
    case populated([T])
    case paging([T], next: Int)
    case empty
    case error(Error)

    var currentItems: [T] {
        switch self {
        case .paging(let item, _):
            return item
        case .populated(let item):
            return item
        default:
            return []
        }
    }
}
