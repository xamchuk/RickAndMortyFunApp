//
//  LocationViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    private let cellId = "CellId"
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UITableViewHeaderFooterView()
    }
}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            as UITableViewCell
        return cell
    }


}
