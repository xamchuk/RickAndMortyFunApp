//
//  String+extension.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 25/07/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
