//
//  AppTheme.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 19/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

struct AppTheme {
    var statusBarStyle: UIStatusBarStyle
    var barBackgroundColor: UIColor
    var barForegroundColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
    var isLargeTitle: Bool
    var cellBorderColor: UIColor
    var titleFont: UIFont
    var datailsFont: UIFont
}

extension AppTheme {
    static let light = AppTheme(
        statusBarStyle: .`default`,
        barBackgroundColor: .white,
        barForegroundColor: .black,
        backgroundColor: UIColor(white: 0.9, alpha: 1),
        textColor: .darkText,
        isLargeTitle: true,
        cellBorderColor: UIColor.gray,
        titleFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2),
        datailsFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    )

    static let dark = AppTheme(
        statusBarStyle: .lightContent,
        barBackgroundColor: UIColor(white: 0, alpha: 1),
        barForegroundColor: .white,
        backgroundColor: UIColor(white: 0.2, alpha: 1),
        textColor: .lightText,
        isLargeTitle: true,
        cellBorderColor: UIColor.black,
        titleFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3),
        datailsFont: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    )
}
