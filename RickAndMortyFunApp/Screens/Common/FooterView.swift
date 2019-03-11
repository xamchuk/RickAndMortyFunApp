//
//  FooterViewModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 05/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class FooterView<T> {

     weak var tableView: UITableView?

      func setFooterView(for state: State<T>) {
        switch state {
        case .error(let error):
            let errorView = ErrorView()
            tableView?.tableFooterView = errorView
            errorView.fillSuperview()
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
