//
//  CharacterViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

enum CharacterEnum {
    case next
    case error
    case isEmpty
    case paging
}

class CharacterViewController: UIViewController {

    var tableView = UITableView()
    var characters: [Character] = []
    var networkService: NetworkService

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchingCharacters()
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func fetchingCharacters() {
        networkService.loadCharcters(completion: { [weak self] charactersFromNetwork in
            self?.characters = charactersFromNetwork
            self?.tableView.reloadData()
        })
    }

    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.register(CharacterCell.self)
        tableView.tableFooterView = UITableViewHeaderFooterView()
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        let character = characters[indexPath.row]
        cell.character = character
        return cell
    }


}
