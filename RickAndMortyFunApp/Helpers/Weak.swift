//
//  Weak.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 19/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

struct Weak<Object: AnyObject> {
    weak var value: Object?
}
