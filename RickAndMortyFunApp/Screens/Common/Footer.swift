//
//  FooterViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 05/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class Footer {

     weak var tableView: UITableView?

      func setFooterView<T>(for state: State<T>) {
        switch state {
        case .error(let error):
            let errorView: ErrorView = .fromNib()
            tableView?.tableFooterView = errorView
            errorView.errorLabel.text = error.localizedDescription
        case .loading:
            let loadingView = LoadingView()
            tableView?.tableFooterView = loadingView
        case .paging:
            let loadingView = LoadingView()
            tableView?.tableFooterView = loadingView
        case .empty:
            let emptyView = EmptyView()
            tableView?.tableFooterView = emptyView
        case .populated:
            tableView?.tableFooterView = nil
        }
    }
}
