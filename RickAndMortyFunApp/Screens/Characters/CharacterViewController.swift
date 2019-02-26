//
//  CharacterViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

enum State {
    case loading
    case populated([Character])
    case paging([Character], next: Int)
    case empty
    case error(Error)

    var currentCharacters: [Character] {
        switch self {
        case .paging(let character, _):
            return character
        case .populated(let characters):
            return characters
        default:
            return []
        }
    }
}

class CharacterViewController: UIViewController {

    var tableView = UITableView()
    var characters: [Character] = []
    var networkService: NetworkService
    var state = State.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCharacters()
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func loadCharacters() {
        state = .loading
        loadPage(1)
    }

    func loadPage(_ page: Int) {
        networkService.loadCharcters(matching: "", page: page ) { [weak self] response in
            guard let `self` = self else {
                return
            }
            self.update(response: response)
        }
    }

    func update(response: CharactersResult) {
        if let error = response.error {
            state = .error(error)
            return
        }

        guard let newCharacters = response.characters,
            !newCharacters.isEmpty else {
                state = .empty
                return
        }

        var allCharacters = state.currentCharacters
        allCharacters.append(contentsOf: newCharacters)

        if response.hasMorePages {
            state = .paging(allCharacters, next: response.nextPage)
        } else {
            state = .populated(allCharacters)
        }
    }
    func setFooterView() {
        switch state {
        case .error(let error):
            print("error: \(error.localizedDescription)")
            //   errorLabel.text = error.localizedDescription
        //   tableView.tableFooterView = errorView
        case .loading:
            print("loading")
        //   tableView.tableFooterView = loadingView
        case .paging:
            print("loading")
        //   tableView.tableFooterView = loadingView
        case .empty:
            print("empty")
        //   tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        }
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
        return state.currentCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        let character = state.currentCharacters[indexPath.row]
        cell.character = character

        if case .paging(_, let nextPage) = state,
            indexPath.row == state.currentCharacters.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }


}
