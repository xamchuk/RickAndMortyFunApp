//
//  GenericTableViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 04/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class GenericViewController<T: GenericCell<U>, U, S>: UIViewController, UITableViewDataSource {

    var tableView = UITableView()
    
    var state = GenericState<U>.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.register(T.self)
        loadItems()
    }

    @objc func loadItems() {
        state = .loading
        loadPage(1)
    }

    func loadPage(_ page: Int) {
      
    }

    func update(response: S) {
       
    }
    
    func setFooterView() {
        switch state {
        case .error(let error):
            let errorView = ErrorView()
            tableView.tableFooterView = errorView
            errorView.fillSuperview()
            errorView.errorLabel.text = error.localizedDescription
        case .loading:
            let loadingView = LoadingView()
            tableView.tableFooterView = loadingView
        case .paging:
            let loadingView = LoadingView()
            tableView.tableFooterView = loadingView
        case .empty:
            let emptyView = EmptyView()
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        }
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.currentItem.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: T = tableView.dequeueReusableCell(for: indexPath)
        cell.item = state.currentItem[indexPath.row]
        
        if case .paging(_, let nextPage) = state,
            indexPath.row == state.currentItem.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}
