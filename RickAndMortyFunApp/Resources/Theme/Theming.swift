//
//  Theming.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 19/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

protocol ThemeProvider {

    associatedtype Theme

    var currentTheme: Theme { get }

    func subscribeToChanges(_ object: AnyObject, handler: @escaping (Theme) -> Void)
}

protocol Themed {

    associatedtype ThemeProviderType: ThemeProvider

    var themeProvider: ThemeProviderType { get }

    func applyTheme(_ theme: ThemeProviderType.Theme)
}

extension Themed where Self: AnyObject {
    func setUpTheming() {
        applyTheme(themeProvider.currentTheme)
        themeProvider.subscribeToChanges(self) { [weak self] newTheme in
            self?.applyTheme(newTheme)
        }
    }
}
