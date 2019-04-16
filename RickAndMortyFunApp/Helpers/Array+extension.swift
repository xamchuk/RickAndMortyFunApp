//
//  Array+extension.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 19/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

extension Array {
    mutating func rotate() -> Element? {
        guard let lastElement = popLast() else {
            return nil
        }
        insert(lastElement, at: 0)
        return lastElement
    }
}
