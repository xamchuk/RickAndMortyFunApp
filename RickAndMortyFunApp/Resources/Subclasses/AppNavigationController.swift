//
//  AppNavigationController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 19/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    private var themedStatusBarStyle: UIStatusBarStyle?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()
    }
}

extension AppNavigationController: Themed {
    func applyTheme(_ theme: AppTheme) {
        navigationBar.prefersLargeTitles = theme.isLargeTitle
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        navigationBar.barTintColor = theme.barBackgroundColor
        navigationBar.tintColor = theme.barForegroundColor
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.barForegroundColor
        ]
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.barForegroundColor
        ]
    }
}
